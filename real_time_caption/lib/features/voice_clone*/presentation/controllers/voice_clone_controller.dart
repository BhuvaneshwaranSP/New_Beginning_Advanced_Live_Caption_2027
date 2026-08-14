/*
1. PAGE NAME
   Voice Clone Controller

2. PURPOSE
   Manages local UI state for the Voice Clone screen.

3. DESCRIPTION
   Uses Flutter's built-in ChangeNotifier only. No state-management package
   or real voice-processing operation is implemented.

4. UI SECTIONS
   Profile selection, recording state, processing state, and connection state.

5. NAVIGATION FLOW
   Page → controller → local mock data.

6. DYNAMIC COMPONENTS
   Selected profile, recording state, processing state, and status messages.

7. FUTURE BACKEND INTEGRATION
   The recording action is the integration boundary for the project's future
   voice-processing pipeline; it currently changes only local demonstration state.

8. TECHNOLOGIES USED
   Flutter foundation ChangeNotifier.

9. REQUIRED DATA MODELS
   VoiceCloneEntity.

10. FUTURE API ENDPOINTS
    Not defined.

11. DATABASE COLLECTIONS/TABLES
    Not defined.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Supplied by the active Material 3 theme.

15. ANIMATIONS
    UI animation is handled by widgets, not this controller.

16. ACCESSIBILITY
    State changes are exposed through the UI.

17. EDGE CASES
    Empty profiles and unavailable/offline profile.

18. VALIDATION RULES
    Actions are local demonstrations only.

19. ERROR HANDLING
    Local error state can be selected for UI testing.

20. LOADING STATE
    Local processing state.

21. EMPTY STATE
    Supported when profile list is empty.

22. OFFLINE BEHAVIOUR
    Offline status is demonstrated locally.

23. SECURITY CONSIDERATIONS
    No microphone or voice data is accessed.

24. PERFORMANCE OPTIMIZATIONS
    Minimal notifications and immutable profile list.

25. WIDGET TREE OVERVIEW
    Page → header → profile → controls → state sections.

26. COMPLETE TESTING CHECKLIST
    Test state transitions, disposal, empty data, and repeated interactions.
*/

import 'package:flutter/foundation.dart';

import '../../data/data_sources/mock_voice_clone_data_source.dart';
import '../../domain/entities/voice_clone_entity.dart';

class VoiceCloneController extends ChangeNotifier {
  VoiceCloneController({
    MockVoiceCloneDataSource? dataSource,
  }) : _dataSource = dataSource ?? const MockVoiceCloneDataSource();

  final MockVoiceCloneDataSource _dataSource;

  List<VoiceCloneEntity> _profiles = const [];
  int _selectedIndex = 0;
  bool _isLoading = true;
  bool _isRecording = false;
  bool _isProcessing = false;
  bool _showError = false;

  List<VoiceCloneEntity> get profiles => _profiles;

  int get selectedIndex => _selectedIndex;

  bool get isLoading => _isLoading;

  bool get isRecording => _isRecording;

  bool get isProcessing => _isProcessing;

  bool get showError => _showError;

  VoiceCloneEntity? get selectedProfile {
    if (_profiles.isEmpty ||
        _selectedIndex < 0 ||
        _selectedIndex >= _profiles.length) {
      return null;
    }
    return _profiles[_selectedIndex];
  }

  void load() {
    _isLoading = true;
    _showError = false;
    notifyListeners();

    final models = _dataSource.loadProfiles();
    _profiles = models.map((model) => model.toEntity()).toList(growable: false);
    _selectedIndex = _profiles.isEmpty ? 0 : 0;
    _isLoading = false;
    notifyListeners();
  }

  void selectProfile(int index) {
    if (index < 0 || index >= _profiles.length || _isRecording) {
      return;
    }

    _selectedIndex = index;
    _showError = false;
    notifyListeners();
  }

  void toggleRecording() {
    if (_isLoading || _isProcessing || _profiles.isEmpty) {
      return;
    }

    _showError = false;
    _isRecording = !_isRecording;
    notifyListeners();

    // Future: connect the approved voice-sample capture pipeline here;
    // this action is the UI boundary for collecting the sample required
    // by the future voice-profile workflow.
  }

  void startProcessingPreview() {
    if (_isLoading || _isRecording || _profiles.isEmpty) {
      return;
    }

    _showError = false;
    _isProcessing = true;
    notifyListeners();

    Future<void>.delayed(const Duration(milliseconds: 900), () {
      if (!_isProcessing) {
        return;
      }
      _isProcessing = false;
      notifyListeners();

      // Future: connect the supported voice synthesis/profile-processing
      // pipeline here; the current implementation only demonstrates the
      // processing state and never generates or stores a real voice clone.
    });
  }

  void showErrorState() {
    _showError = true;
    _isRecording = false;
    _isProcessing = false;
    notifyListeners();
  }

  void retry() {
    load();
  }

  void reset() {
    _isRecording = false;
    _isProcessing = false;
    _showError = false;
    notifyListeners();
  }
}