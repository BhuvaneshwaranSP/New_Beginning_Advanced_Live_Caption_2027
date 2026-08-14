/*
1. PAGE NAME
   Splash Mock Data Source

2. PURPOSE
   Supplies local dummy data to the Splash feature.

3. DESCRIPTION
   Provides presentation-safe data without networking or persistence.

4. UI SECTIONS
   Branding and loading state.

5. NAVIGATION FLOW
   Mock data source → Controller → Splash page.

6. DYNAMIC COMPONENTS
   Branding text and loading text.

7. FUTURE BACKEND INTEGRATION
   No backend is required for the Splash UI. Application startup routing
   may later determine the destination after the splash state completes.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   SplashFeatureModel.

10. FUTURE API ENDPOINTS
    None.

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
    Provides concise text suitable for semantic labels.

17. EDGE CASES
    Local-only execution supports offline startup.

18. VALIDATION RULES
    Supplied values must remain non-empty.

19. ERROR HANDLING
    No external operation can fail.

20. LOADING STATE
    Supplies the loading label displayed by the presentation.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Fully available offline.

23. SECURITY CONSIDERATIONS
    No sensitive information is included.

24. PERFORMANCE OPTIMIZATIONS
    Returns immutable constant data.

25. WIDGET TREE OVERVIEW
    Data source → Model → Entity → Controller → Page.

26. COMPLETE TESTING CHECKLIST
    Verify dummy data renders correctly across theme and text-scale variants.
*/

import '../models/splash_feature_model.dart';
import '../dummy/splash_dummy_data.dart';

class MockSplashDataSource {
  const MockSplashDataSource();

  SplashFeatureModel loadSplashData() {
    return splashDummyModel;
  }
}
