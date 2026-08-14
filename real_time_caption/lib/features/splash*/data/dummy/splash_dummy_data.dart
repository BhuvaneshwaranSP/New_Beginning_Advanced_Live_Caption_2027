/*
1. PAGE NAME
   Splash Dummy Data

2. PURPOSE
   Defines realistic local presentation data for LinguaLive startup.

3. DESCRIPTION
   Keeps Splash UI content independent from backend services.

4. UI SECTIONS
   LinguaLive branding and loading state.

5. NAVIGATION FLOW
   Dummy data → Splash presentation.

6. DYNAMIC COMPONENTS
   Application name, multilingual communication tagline, and loading label.

7. FUTURE BACKEND INTEGRATION
   None.

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
    Text is concise and semantic-friendly.

17. EDGE CASES
    Localization may expand the tagline in future implementations.

18. VALIDATION RULES
    Text values must remain meaningful and non-empty.

19. ERROR HANDLING
    Not applicable.

20. LOADING STATE
    "Preparing your multilingual space" represents local startup preparation.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Data is local and requires no network.

23. SECURITY CONSIDERATIONS
    No personal or sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Constant model instance.

25. WIDGET TREE OVERVIEW
    Dummy model → entity → branding widget.

26. COMPLETE TESTING CHECKLIST
    Verify text rendering, localization expansion, accessibility, and themes.
*/

import '../models/splash_feature_model.dart';

const SplashFeatureModel splashDummyModel = SplashFeatureModel(
  appName: 'LinguaLive',
  tagline: 'Speak naturally. Understand globally.',
  loadingLabel: 'Preparing your multilingual space',
);
