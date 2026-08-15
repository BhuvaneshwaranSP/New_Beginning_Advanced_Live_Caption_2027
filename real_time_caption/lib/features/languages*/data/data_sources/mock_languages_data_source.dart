/*
1. PAGE NAME
   Mock Languages Data Source

2. PURPOSE
   Provides local dummy language data for UI development.

3. DESCRIPTION
   Keeps the page independent from networking, databases, authentication,
   and real language services.

4. UI SECTIONS
   Supplies data to every language section.

5. NAVIGATION FLOW
   Mock source → controller → LanguagesPage.

6. DYNAMIC COMPONENTS
   Language catalog and selected language pair.

7. FUTURE BACKEND INTEGRATION
   Future: replace this local source with the project's supported-language
   repository when real language availability and user preferences are added.

8. TECHNOLOGIES USED
   Pure Dart.

9. REQUIRED DATA MODELS
   LanguageFeatureModel.

10. FUTURE API ENDPOINTS
    Determined by the eventual language-catalog service contract.

11. DATABASE COLLECTIONS/TABLES
    None currently.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Not applicable at data-source level.

17. EDGE CASES
    Empty catalog and unavailable language records.

18. VALIDATION RULES
    Preserve unique language IDs.

19. ERROR HANDLING
    No remote failures are generated.

20. LOADING STATE
    Controller can locally represent loading.

21. EMPTY STATE
    Controller can represent an empty catalog.

22. OFFLINE BEHAVIOUR
    Local dummy data remains usable.

23. SECURITY CONSIDERATIONS
    No user or credential data.

24. PERFORMANCE OPTIMIZATIONS
    Returns an immutable-style constant catalog.

25. WIDGET TREE OVERVIEW
    Data source → controller → page.

26. COMPLETE TESTING CHECKLIST
    Verify catalog loading and conversion to entities.
*/

import '../dummy/languages_dummy_data.dart';
import '../models/languages_feature_model.dart';

class MockLanguagesDataSource {
  const MockLanguagesDataSource();

  List<LanguageFeatureModel> getLanguages() {
    return languagesDummyData;
  }
}
