/*
1. PAGE NAME
   About Feature Barrel

2. PURPOSE
   Provides the public exports for the LinguaLive About feature.

3. DESCRIPTION
   Keeps feature imports centralized while preserving the supplied
   feature-based folder architecture.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Application navigation → AboutPage.

6. DYNAMIC COMPONENTS
   Exposes the About domain entities and presentation page.

7. FUTURE BACKEND INTEGRATION
   Data-layer exports remain available internally; infrastructure should
   not be introduced merely for the About UI.

8. TECHNOLOGIES USED
   Dart import/export syntax only.

9. REQUIRED DATA MODELS
   About feature models and entities.

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
    Implemented by the presentation page and widgets.

17. EDGE CASES
    Incorrect or unnecessary public exports should be avoided.

18. VALIDATION RULES
    Export only files that belong to the About feature's current
    implementation.

19. ERROR HANDLING
    Not applicable.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Not applicable.

23. SECURITY CONSIDERATIONS
    No sensitive functionality is exposed.

24. PERFORMANCE OPTIMIZATIONS
    Barrel exports contain no runtime logic.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify imports compile, AboutPage is publicly accessible,
    and no circular dependency is introduced.
*/

export 'domain/entities/about_feature_entity.dart';
export 'presentation/pages/about_page.dart';
