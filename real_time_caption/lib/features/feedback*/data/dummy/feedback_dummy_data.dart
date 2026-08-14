/*
1. PAGE NAME
   Feedback Dummy Data

2. PURPOSE
   Provides local dummy feedback categories for UI development.

3. DESCRIPTION
   Contains only local immutable data. No backend or persistence is used.

4. UI SECTIONS
   Feedback categories and form defaults.

5. NAVIGATION FLOW
   Dummy data → MockFeedbackDataSource → FeedbackController → FeedbackPage.

6. DYNAMIC COMPONENTS
   Category cards and feedback form configuration.

7. FUTURE BACKEND INTEGRATION
   Future: replace this local configuration with approved application data
   when the feedback service is introduced.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   FeedbackFeatureModel.
   FeedbackCategoryEntity.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material icon code points.

14. THEME COLORS
    Application Material 3 theme.

15. ANIMATIONS
    Presentation layer.

16. ACCESSIBILITY
    Category text is exposed by presentation widgets.

17. EDGE CASES
    Empty category collections are supported.

18. VALIDATION RULES
    Controller validates user input.

19. ERROR HANDLING
    Presentation layer handles local validation errors.

20. LOADING STATE
    Controller provides a simulated loading state.

21. EMPTY STATE
    Presentation layer handles an empty category collection.

22. OFFLINE BEHAVIOUR
    Dummy data remains available without connectivity.

23. SECURITY CONSIDERATIONS
    No sensitive information is included.

24. PERFORMANCE OPTIMIZATIONS
    Immutable local data.

25. WIDGET TREE OVERVIEW
    FeedbackFeatureModel → FeedbackController → FeedbackPage.

26. COMPLETE TESTING CHECKLIST
    Verify all categories render correctly and empty collections are handled.
*/

import '../../domain/entities/feedback_feature_entity.dart';
import '../models/feedback_feature_model.dart';

const FeedbackFeatureModel feedbackDummyModel = FeedbackFeatureModel(
  categories: <FeedbackCategoryEntity>[
    FeedbackCategoryEntity(
      id: 'experience',
      title: 'Overall experience',
      subtitle: 'How LinguaLive feels in everyday communication',
      iconName: 'experience',
    ),
    FeedbackCategoryEntity(
      id: 'translation',
      title: 'Translation',
      subtitle: 'Accuracy, clarity, and natural multilingual output',
      iconName: 'translation',
    ),
    FeedbackCategoryEntity(
      id: 'captions',
      title: 'Live captions',
      subtitle: 'Readability and timing of spoken captions',
      iconName: 'captions',
    ),
    FeedbackCategoryEntity(
      id: 'calls',
      title: 'Calls & conversations',
      subtitle: 'Communication flow during calls and sessions',
      iconName: 'calls',
    ),
    FeedbackCategoryEntity(
      id: 'other',
      title: 'Something else',
      subtitle: 'Tell us about anything not covered above',
      iconName: 'other',
    ),
  ],
  initialRating: 4,
  placeholder:
      'Tell us what worked well, what felt difficult, or what you would improve…',
  maxMessageLength: 600,
);
