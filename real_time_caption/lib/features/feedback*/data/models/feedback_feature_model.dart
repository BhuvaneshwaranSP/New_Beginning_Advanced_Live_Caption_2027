/*
1. PAGE NAME
   Feedback Feature Data Model

2. PURPOSE
   Represents local feedback options and submission-preview data.

3. DESCRIPTION
   Pure data representation used by the UI-only Feedback feature.

4. UI SECTIONS
   Rating, category, message, and submission state.

5. NAVIGATION FLOW
   FeedbackPage consumes these local values.

6. DYNAMIC COMPONENTS
   Feedback category and rating data.

7. FUTURE BACKEND INTEGRATION
   Future: map this model to the application's feedback submission contract
   when feedback persistence is introduced.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   FeedbackFeatureModel.

10. FUTURE API ENDPOINTS
    Not defined because the supplied project documentation does not specify
    a feedback endpoint.

11. DATABASE COLLECTIONS/TABLES
    None specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Stored as presentation concerns.

14. THEME COLORS
    Not stored in the data model.

15. ANIMATIONS
    Not applicable.

16. ACCESSIBILITY
    Presentation layer converts model labels into accessible controls.

17. EDGE CASES
    Empty labels and empty collections are supported.

18. VALIDATION RULES
    Validation remains in the controller.

19. ERROR HANDLING
    Model contains no infrastructure errors.

20. LOADING STATE
    Represented by presentation state, not the model.

21. EMPTY STATE
    Supported by empty category lists.

22. OFFLINE BEHAVIOUR
    Local dummy data remains available offline.

23. SECURITY CONSIDERATIONS
    No credentials or sensitive information are stored.

24. PERFORMANCE OPTIMIZATIONS
    Immutable fields and const constructors where possible.

25. WIDGET TREE OVERVIEW
    Model → controller → presentation widgets.

26. COMPLETE TESTING CHECKLIST
    Verify construction, equality-independent rendering, empty values, and
    null-safe access.
*/

import '../../domain/entities/feedback_feature_entity.dart';

class FeedbackFeatureModel {
  const FeedbackFeatureModel({
    required this.categories,
    required this.initialRating,
    required this.placeholder,
    required this.maxMessageLength,
  });

  final List<FeedbackCategoryEntity> categories;
  final int initialRating;
  final String placeholder;
  final int maxMessageLength;

  FeedbackFeatureModel copyWith({
    List<FeedbackCategoryEntity>? categories,
    int? initialRating,
    String? placeholder,
    int? maxMessageLength,
  }) {
    return FeedbackFeatureModel(
      categories: categories ?? this.categories,
      initialRating: initialRating ?? this.initialRating,
      placeholder: placeholder ?? this.placeholder,
      maxMessageLength: maxMessageLength ?? this.maxMessageLength,
    );
  }
}
