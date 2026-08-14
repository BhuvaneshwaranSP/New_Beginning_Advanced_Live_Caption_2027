/*
1. PAGE NAME
   Transcription Controller

2. PURPOSE
   Manages local UI state for the transcription page.

3. DESCRIPTION
   Uses only Flutter local state concepts and a mock data source.
   No state-management package or real service is used.

4. UI SECTIONS
   Transcript list, live status, and bottom controls.

5. NAVIGATION FLOW
   Page → Controller → Mock data source.

6. DYNAMIC COMPONENTS
   Loading, live, paused, empty, error, and offline states.

7. FUTURE BACKEND INTEGRATION
   Future: connect streaming ASR events here for live transcript updates;
   the controller owns presentation state and coordinates transcript changes.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   TranscriptionEntity.

10. FUTURE API ENDPOINTS
    Not defined.

11. DATABASE COLLECTIONS/TABLES
    Not defined.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    Not applicable.

15. ANIMATIONS
    State changes are animated by presentation widgets.

16. ACCESSIBILITY
    State is exposed through readable labels in the page.

17. EDGE CASES
    Empty data and local error representation.

18. VALIDATION RULES
    State transitions are local only.

19. ERROR HANDLING
    Error state can be explicitly displayed.

20. LOADING STATE
    Initial local loading state.

21. EMPTY STATE
    Empty transcript state.

22. OFFLINE BEHAVIOUR
    Local offline state can be displayed without connectivity detection.

23. SECURITY CONSIDERATIONS
    No audio or transcript persistence.

24. PERFORMANCE OPTIMIZATIONS
    Data is loaded once and reused.

25. WIDGET TREE OVERVIEW
    Controller → TranscriptionPage.

26. COMPLETE TESTING CHECKLIST
    Test all local state transitions.
*/

import 'package:flutter/foundation.dart';

import '../../data/data_sources/mock_transcription_data_source.dart';
import '../../domain/entities/transcription_entity.dart';

enum TranscriptionStatus { loading, live, paused, empty, error, offline }

class TranscriptionController extends ChangeNotifier {
  TranscriptionController({MockTranscriptionDataSource? dataSource})
    : _dataSource = dataSource ?? const MockTranscriptionDataSource();

  final MockTranscriptionDataSource _dataSource;

  List<TranscriptionEntity> _segments = const [];
  TranscriptionStatus _status = TranscriptionStatus.loading;

  List<TranscriptionEntity> get segments => _segments;
  TranscriptionStatus get status => _status;

  bool get isActive => _status == TranscriptionStatus.live;

  Future<void> load() async {
    _status = TranscriptionStatus.loading;
    notifyListeners();

    await Future<void>.delayed(const Duration(milliseconds: 350));

    final models = _dataSource.loadTranscriptions();

    _segments = models.map((model) => model.toEntity()).toList(growable: false);
    _status = _segments.isEmpty
        ? TranscriptionStatus.empty
        : TranscriptionStatus.live;

    notifyListeners();
  }

  void toggleRecording() {
    if (_status == TranscriptionStatus.live) {
      _status = TranscriptionStatus.paused;
    } else if (_status == TranscriptionStatus.paused) {
      _status = TranscriptionStatus.live;
    }

    // Future: connect the streaming ASR session state here; this control
    // represents whether the transcription stream is actively displayed.
    notifyListeners();
  }

  void clearTranscript() {
    _segments = const [];
    _status = TranscriptionStatus.empty;
    notifyListeners();
  }

  void showOfflineState() {
    _status = TranscriptionStatus.offline;
    notifyListeners();
  }

  void showErrorState() {
    _status = TranscriptionStatus.error;
    notifyListeners();
  }

  Future<void> retry() => load();
}
