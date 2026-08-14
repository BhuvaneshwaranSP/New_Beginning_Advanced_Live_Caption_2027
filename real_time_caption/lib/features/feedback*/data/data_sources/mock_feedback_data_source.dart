/*
1. PAGE NAME
   Mock Feedback Data Source

2. PURPOSE
   Provides local-only feedback configuration to the presentation layer.

3. DESCRIPTION
   This source deliberately avoids networking, persistence, APIs, or databases.

4. UI SECTIONS
   Feedback form configuration.

5. NAVIGATION FLOW
   FeedbackPage → controller → mock data source.

6. DYNAMIC COMPONENTS
   Categories, rating, placeholder, and character limit.

7. FUTURE BACKEND INTEGRATION
   Future: replace this source with the approved feedback repository source
   when backend integration is implemented.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   FeedbackFeatureModel.

10. FUTURE API ENDPOINTS
    No endpoint is specified in the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Presentation concern.

14. THEME COLORS
    Presentation concern.

15. ANIMATIONS
    Presentation concern.

16. ACCESSIBILITY
    Presentation concern.

17. EDGE CASES
    Local configuration can contain an empty category list.

18. VALIDATION RULES
    Presentation/controller concern.

19. ERROR HANDLING
    Local source can represent a source failure through controller state.

20. LOADING STATE
    Simulated locally by the controller.

21. EMPTY STATE
    Supported by the page.

22. OFFLINE BEHAVIOUR
    No network dependency exists.

23. SECURITY CONSIDERATIONS
    No external data access.

24. PERFORMANCE OPTIMIZATIONS
    Returns immutable local configuration.

25. WIDGET TREE OVERVIEW
    Mock source → controller → FeedbackPage.

26. COMPLETE TESTING CHECKLIST
    Verify source construction and configuration retrieval.
*/

import '../dummy/feedback_dummy_data.dart';
import '../models/feedback_feature_model.dart';

class MockFeedbackDataSource {
  const MockFeedbackDataSource();

  FeedbackFeatureModel loadConfiguration() {
    return feedbackDummyModel;
  }
}
