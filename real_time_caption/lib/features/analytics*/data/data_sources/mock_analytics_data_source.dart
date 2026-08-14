/*
1. PAGE NAME
   Mock Analytics Data Source

2. PURPOSE
   Provides local Analytics data without backend dependencies.

3. DESCRIPTION
   Acts as the temporary data boundary between dummy data and the
   Analytics controller.

4. UI SECTIONS
   All Analytics sections consume data returned here.

5. NAVIGATION FLOW
   MockAnalyticsDataSource → AnalyticsController → AnalyticsPage.

6. DYNAMIC COMPONENTS
   AnalyticsFeatureModel.

7. FUTURE BACKEND INTEGRATION
   Replace this implementation with the project's intended analytics
   repository/data source when backend integration begins.

8. TECHNOLOGIES USED
   Dart and Flutter's local asynchronous Future API.

9. REQUIRED DATA MODELS
   AnalyticsFeatureModel.

10. FUTURE API ENDPOINTS
    Not specified at this UI stage.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Not applicable.

17. EDGE CASES
    Empty or unavailable analytics can be represented by the controller.

18. VALIDATION RULES
    Returned data must match AnalyticsFeatureModel.

19. ERROR HANDLING
    Future production implementation should map source failures here.

20. LOADING STATE
    Simulated by the controller.

21. EMPTY STATE
    Can be represented using an empty model.

22. OFFLINE BEHAVIOUR
    The controller can expose offline state without performing
    connectivity detection.

23. SECURITY CONSIDERATIONS
    No external data is accessed.

24. PERFORMANCE OPTIMIZATIONS
    Uses one immutable local data object.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify data retrieval, model shape, asynchronous completion,
    and controller integration.
*/

import '../dummy/analytics_dummy_data.dart';
import '../models/analytics_feature_model.dart';

class MockAnalyticsDataSource {
  const MockAnalyticsDataSource();

  Future<AnalyticsFeatureModel> loadAnalytics() async {
    // Future: replace local demonstration data with the approved LinguaLive
    // analytics data source when persistent analytics are integrated.
    return analyticsDummyData;
  }
}
