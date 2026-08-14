/*
1. PAGE NAME
   Profile Controller

2. PURPOSE
   Controls local presentation state for the Profile page.

3. DESCRIPTION
   Uses Flutter's local ChangeNotifier only. No external state-management
   package or backend functionality is used.

4. UI SECTIONS
   Controls profile loading, success, empty, and error representations.

5. NAVIGATION FLOW
   ProfilePage → ProfileController → MockProfileDataSource.

6. DYNAMIC COMPONENTS
   Profile entity and local UI state.

7. FUTURE BACKEND INTEGRATION
   The loadProfile boundary is where a future profile repository can provide
   account data; the UI should continue receiving a domain entity here.

8. TECHNOLOGIES USED
   Flutter ChangeNotifier.

9. REQUIRED DATA MODELS
   ProfileFeatureModel and ProfileFeatureEntity.

10. FUTURE API ENDPOINTS
    Not specified by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified by the supplied project documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    Application Material 3 theme.

15. ANIMATIONS
    Page widgets may animate state transitions.

16. ACCESSIBILITY
    State changes are exposed through the resulting UI.

17. EDGE CASES
    Loading, empty, error, and offline-demo states are represented locally.

18. VALIDATION RULES
    No remote validation.

19. ERROR HANDLING
    Local error state is intentionally simulated.

20. LOADING STATE
    Local loading state is supported.

21. EMPTY STATE
    Local empty state is supported.

22. OFFLINE BEHAVIOUR
    Offline demo state is supported without real connectivity detection.

23. SECURITY CONSIDERATIONS
    No credentials or tokens are processed.

24. PERFORMANCE OPTIMIZATIONS
    One small notifier controls only the Profile page.

25. WIDGET TREE OVERVIEW
    ProfilePage → Animated state content.

26. COMPLETE TESTING CHECKLIST
    Verify every state transition and disposal behavior.
*/

import 'package:flutter/foundation.dart';

import '../../data/data_sources/mock_profile_data_source.dart';
import '../../domain/entities/profile_feature_entity.dart';

enum ProfileUiState { loading, success, empty, error, offline }

class ProfileController extends ChangeNotifier {
  ProfileController({
    MockProfileDataSource dataSource = const MockProfileDataSource(),
  }) : _dataSource = dataSource;

  final MockProfileDataSource _dataSource;

  ProfileUiState _state = ProfileUiState.loading;
  ProfileFeatureEntity? _profile;

  ProfileUiState get state => _state;
  ProfileFeatureEntity? get profile => _profile;

  void loadProfile() {
    _state = ProfileUiState.loading;
    notifyListeners();

    try {
      final model = _dataSource.getProfile();
      final entity = model.toEntity();

      if (entity.displayName.trim().isEmpty) {
        _profile = null;
        _state = ProfileUiState.empty;
      } else {
        _profile = entity;
        _state = ProfileUiState.success;
      }
    } catch (_) {
      _profile = null;
      _state = ProfileUiState.error;
    }

    notifyListeners();
  }

  void showOfflineDemo() {
    _state = ProfileUiState.offline;
    notifyListeners();
  }

  void showErrorDemo() {
    _profile = null;
    _state = ProfileUiState.error;
    notifyListeners();
  }

  void showEmptyDemo() {
    _profile = null;
    _state = ProfileUiState.empty;
    notifyListeners();
  }
}
