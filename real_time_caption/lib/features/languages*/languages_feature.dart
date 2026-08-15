/*
1. PAGE NAME
   Languages Feature Entry

2. PURPOSE
   Provides the public entry point for the LinguaLive Languages feature.

3. DESCRIPTION
   Exposes the Languages page without introducing additional architecture
   or dependencies.

4. UI SECTIONS
   Languages feature entry only.

5. NAVIGATION FLOW
   Application router → LanguagesFeature → LanguagesPage.

6. DYNAMIC COMPONENTS
   LanguagesPage.

7. FUTURE BACKEND INTEGRATION
   No direct integration. The page and controller contain the UI
   integration boundaries.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   Defined internally by the feature.

10. FUTURE API ENDPOINTS
    None implemented.

11. DATABASE COLLECTIONS/TABLES
    None implemented.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None directly.

14. THEME COLORS
    Application Material 3 theme.

15. ANIMATIONS
    Defined by presentation widgets.

16. ACCESSIBILITY
    Implemented by the page and widgets.

17. EDGE CASES
    Delegated to LanguagesPage.

18. VALIDATION RULES
    Delegated to LanguagesController.

19. ERROR HANDLING
    UI-only local states.

20. LOADING STATE
    Defined by LanguagesPage.

21. EMPTY STATE
    Defined by LanguageSection.

22. OFFLINE BEHAVIOUR
    Local preview only.

23. SECURITY CONSIDERATIONS
    No sensitive functionality.

24. PERFORMANCE OPTIMIZATIONS
    Feature-level exports only.

25. WIDGET TREE OVERVIEW
    LanguagesFeature → LanguagesPage.

26. COMPLETE TESTING CHECKLIST
    Verify the feature exports compile and the page can be opened
    by the application router.
*/

import 'presentation/pages/languages_page.dart';

class LanguagesFeature {
  const LanguagesFeature();

  LanguagesPage buildPage() {
    return const LanguagesPage();
  }
}
