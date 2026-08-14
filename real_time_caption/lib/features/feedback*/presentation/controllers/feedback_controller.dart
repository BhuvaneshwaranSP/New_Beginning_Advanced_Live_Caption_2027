/*
1. PAGE NAME
   Feedback Controller

2. PURPOSE
   Manages local UI state for the Feedback page.

3. DESCRIPTION
   Uses Flutter's local ChangeNotifier only. No external state-management
   package or real submission functionality is implemented.

4. UI SECTIONS
   Rating, category, message, loading, success, and error states.

5. NAVIGATION FLOW
   FeedbackPage → FeedbackController → local state changes.

6. DYNAMIC COMPONENTS
   Selected rating, category, message, and submission state.

7. FUTURE BACKEND INTEGRATION
   Future: submit the validated feedback payload through the application's
   approved feedback service from submitFeedback(); this belongs here because
   the controller owns the form's submission state.

8. TECHNOLOGIES USED
   Flutter foundation ChangeNotifier.

9. REQUIRED DATA MODELS
   FeedbackFeatureModel.

10. FUTURE API ENDPOINTS
    Not specified by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    Presentation layer.

15. ANIMATIONS
    Presentation layer.

16. ACCESSIBILITY
    State changes are exposed through normal Flutter widgets.

17. EDGE CASES
    Empty message, missing category, and loading-state submission are handled.

18. VALIDATION RULES
    Rating must be 1–5; a category must be selected; message must not be
    empty after trimming.

19. ERROR HANDLING
    Invalid form input and simulated submission failure are represented locally.

20. LOADING STATE
    A short local loading transition is provided for UI testing.

21. EMPTY STATE
    Empty message state is handled by validation.

22. OFFLINE BEHAVIOUR
    The demo can show an offline state without performing connectivity checks.

23. SECURITY CONSIDERATIONS
    No feedback is persisted or transmitted.

24. PERFORMANCE OPTIMIZATIONS
    Notifies listeners only after meaningful state changes.

25. WIDGET TREE OVERVIEW
    FeedbackPage → form widgets → controller.

26. COMPLETE TESTING CHECKLIST
    Test every state transition, validation branch, reset operation, and
    listener notification.
*/

import 'package:flutter/foundation.dart';
import 'package:real_time_caption/features/feedback*/data/models/feedback_feature_model.dart';
import 'package:real_time_caption/features/feedback*/domain/entities/feedback_feature_entity.dart';

import '../../data/data_sources/mock_feedback_data_source.dart';

enum FeedbackSubmissionState { idle, loading, success, error, offline }

class FeedbackController extends ChangeNotifier {
  FeedbackController({MockFeedbackDataSource? dataSource})
    : _dataSource = dataSource ?? const MockFeedbackDataSource() {
    _model = _dataSource.loadConfiguration();
    _selectedRating = _model.initialRating;
  }

  final MockFeedbackDataSource _dataSource;

  late FeedbackFeatureModel _model;

  int _selectedRating = 0;
  String? _selectedCategoryId;
  String _message = '';
  FeedbackSubmissionState _submissionState = FeedbackSubmissionState.idle;

  FeedbackFeatureModel get model => _model;
  int get selectedRating => _selectedRating;
  String? get selectedCategoryId => _selectedCategoryId;
  String get message => _message;
  FeedbackSubmissionState get submissionState => _submissionState;

  bool get canSubmit =>
      _selectedRating >= 1 &&
      _selectedRating <= 5 &&
      _selectedCategoryId != null &&
      _message.trim().isNotEmpty &&
      _submissionState != FeedbackSubmissionState.loading;

  int get remainingCharacters => _model.maxMessageLength - _message.length;

  void selectRating(int rating) {
    if (rating < 1 || rating > 5) {
      return;
    }

    _selectedRating = rating;
    _submissionState = FeedbackSubmissionState.idle;
    notifyListeners();
  }

  void selectCategory(String categoryId) {
    final bool exists = _model.categories.any(
      (FeedbackCategoryEntity category) => category.id == categoryId,
    );

    if (!exists) {
      return;
    }

    _selectedCategoryId = categoryId;
    _submissionState = FeedbackSubmissionState.idle;
    notifyListeners();
  }

  void updateMessage(String value) {
    final String nextValue = value.length > _model.maxMessageLength
        ? value.substring(0, _model.maxMessageLength)
        : value;

    _message = nextValue;

    if (_submissionState != FeedbackSubmissionState.idle) {
      _submissionState = FeedbackSubmissionState.idle;
    }

    notifyListeners();
  }

  void submitFeedback() {
    if (!canSubmit) {
      _submissionState = FeedbackSubmissionState.error;
      notifyListeners();
      return;
    }

    _submissionState = FeedbackSubmissionState.loading;
    notifyListeners();

    // Future: connect the approved feedback submission service here so the
    // validated rating, category, and message can be delivered to the backend.
    Future<void>.delayed(const Duration(milliseconds: 700), () {
      if (_submissionState != FeedbackSubmissionState.loading) {
        return;
      }

      _submissionState = FeedbackSubmissionState.success;
      notifyListeners();
    });
  }

  void showOfflineState() {
    _submissionState = FeedbackSubmissionState.offline;
    notifyListeners();
  }

  void retry() {
    _submissionState = FeedbackSubmissionState.idle;
    notifyListeners();
  }

  void reset() {
    _selectedRating = _model.initialRating;
    _selectedCategoryId = null;
    _message = '';
    _submissionState = FeedbackSubmissionState.idle;
    notifyListeners();
  }
}
