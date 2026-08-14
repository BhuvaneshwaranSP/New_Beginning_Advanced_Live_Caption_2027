/*
1. PAGE NAME
   Calls Controller

2. PURPOSE
   Manages local presentation state for the Calls page.

3. DESCRIPTION
   Uses Flutter's built-in ChangeNotifier only. No external state-management
   package or backend service is used.

4. UI SECTIONS
   Controls search, loading, offline, error, and recent-call states.

5. NAVIGATION FLOW
   CallsPage → CallsController → local mock data.

6. DYNAMIC COMPONENTS
   Search results, loading state, connection state, and call history.

7. FUTURE BACKEND INTEGRATION
   Future: connect call-session state here so active calls, participant
   presence, captions, and translation availability can update the page.

8. TECHNOLOGIES USED
   Flutter ChangeNotifier.

9. REQUIRED DATA MODELS
   CallsFeatureModel.

10. FUTURE API ENDPOINTS
    Future call-session and presence services.

11. DATABASE COLLECTIONS/TABLES
    Future call-history persistence.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    State changes are consumed by lightweight implicit UI animations.

16. ACCESSIBILITY
    Search and state changes are exposed through normal Flutter widgets.

17. EDGE CASES
    Empty search, no calls, offline mode, and simulated error state.

18. VALIDATION RULES
    Search is trimmed before matching.

19. ERROR HANDLING
    Local simulated error state with retry callback.

20. LOADING STATE
    Local loading flag.

21. EMPTY STATE
    Empty filtered results or empty call history.

22. OFFLINE BEHAVIOUR
    Local offline flag only.

23. SECURITY CONSIDERATIONS
    No credentials or personal data are processed.

24. PERFORMANCE OPTIMIZATIONS
    Search filtering is performed against a small immutable local collection.

25. WIDGET TREE OVERVIEW
    CallsPage → controller → state widgets.

26. COMPLETE TESTING CHECKLIST
    Test search, loading, retry, offline, empty results, and state transitions.
*/

import 'package:flutter/foundation.dart';

import '../../data/data_sources/mock_calls_data_source.dart';
import '../../data/models/calls_feature_model.dart';

class CallsController extends ChangeNotifier {
  CallsController({
    MockCallsDataSource dataSource = const MockCallsDataSource(),
  }) : _dataSource = dataSource;

  final MockCallsDataSource _dataSource;

  List<CallsFeatureModel> _calls = <CallsFeatureModel>[];
  String _searchQuery = '';
  bool _isLoading = false;
  bool _hasError = false;
  bool _isOffline = false;

  List<CallsFeatureModel> get calls =>
      List<CallsFeatureModel>.unmodifiable(_filteredCalls);

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  bool get isOffline => _isOffline;
  String get searchQuery => _searchQuery;

  List<CallsFeatureModel> get _filteredCalls {
    final String query = _searchQuery.trim().toLowerCase();

    if (query.isEmpty) {
      return _calls;
    }

    return _calls
        .where((CallsFeatureModel call) {
          return call.participant.name.toLowerCase().contains(query) ||
              call.participant.language.toLowerCase().contains(query) ||
              call.languagePair.source.toLowerCase().contains(query) ||
              call.languagePair.target.toLowerCase().contains(query);
        })
        .toList(growable: false);
  }

  void load() {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    _calls = _dataSource.loadCalls();

    _isLoading = false;
    notifyListeners();
  }

  void setSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  void setOffline(bool value) {
    _isOffline = value;
    notifyListeners();
  }

  void simulateError() {
    _hasError = true;
    notifyListeners();
  }

  void retry() {
    load();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }
}
