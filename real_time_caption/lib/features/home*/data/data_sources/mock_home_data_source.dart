/*
1. PAGE NAME
   Mock Home Data Source

2. PURPOSE
   Provides local dummy Home data while real services are not connected.

3. DESCRIPTION
   This source intentionally contains no API, database, Firebase, networking,
   persistence, speech, translation, or AI functionality.

4. UI SECTIONS
   Home languages, features, and recent sessions.

5. NAVIGATION FLOW
   Mock source → controller → Home page.

6. DYNAMIC COMPONENTS
   Local language, feature, and session collections.

7. FUTURE BACKEND INTEGRATION
   Future: replace this mock source with the project's actual local/remote
   data source; this location isolates data retrieval from presentation.

8. TECHNOLOGIES USED
   Dart.

9. REQUIRED DATA MODELS
   HomeFeatureModel family.

10. FUTURE API ENDPOINTS
    None implemented.

11. DATABASE COLLECTIONS/TABLES
    None implemented.

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
    Empty collections can be returned by future implementations.

18. VALIDATION RULES
    Dummy values are valid.

19. ERROR HANDLING
    No external errors are generated.

20. LOADING STATE
    Controlled by presentation/controller.

21. EMPTY STATE
    Supported through returned empty collections if required.

22. OFFLINE BEHAVIOUR
    Local dummy content remains available.

23. SECURITY CONSIDERATIONS
    No user data.

24. PERFORMANCE OPTIMIZATIONS
    Static data with no I/O.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Data retrieval, empty lists, multilingual content, and mapping.
*/

import '../dummy/home_dummy_data.dart';
import '../models/home_feature_model.dart';

class MockHomeDataSource {
  const MockHomeDataSource();

  List<LanguageOptionModel> getLanguages() {
    return HomeDummyData.languages;
  }

  List<HomeFeatureModel> getFeatures() {
    return HomeDummyData.features;
  }

  List<RecentSessionModel> getRecentSessions() {
    return HomeDummyData.recentSessions;
  }
}
