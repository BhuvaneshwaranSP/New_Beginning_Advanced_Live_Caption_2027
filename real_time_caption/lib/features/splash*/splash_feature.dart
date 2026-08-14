/*
1. PAGE NAME
   Splash Feature Entry

2. PURPOSE
   Provides the public entry point for the LinguaLive Splash feature.

3. DESCRIPTION
   Exports the Splash page and feature-level components without introducing
   backend, networking, persistence, authentication, or real AI functionality.

4. UI SECTIONS
   The feature exposes the LinguaLive splash presentation.

5. NAVIGATION FLOW
   Application startup → Splash → future startup destination.

6. DYNAMIC COMPONENTS
   Splash branding, local loading state, and animated progress indicator.

7. FUTURE BACKEND INTEGRATION
   No backend integration is performed by this feature.
   The startup destination can later be connected by the application router.

8. TECHNOLOGIES USED
   Flutter Material 3 and Dart null safety.

9. REQUIRED DATA MODELS
   SplashFeatureModel and SplashFeatureEntity.

10. FUTURE API ENDPOINTS
    None specified for the Splash UI.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    No external asset is required by the current UI implementation.

13. REQUIRED ICONS
    Icons.language, Icons.graphic_eq, and Icons.circle.

14. THEME COLORS
    Material 3 ColorScheme primary, secondary, surface, and onSurface colors.

15. ANIMATIONS
    Lightweight implicit scale/fade animation and progress indicator.

16. ACCESSIBILITY
    Semantic branding label, meaningful loading description, and accessible
    touch targets for any interactive elements.

17. EDGE CASES
    Small screens, large screens, landscape mode, dark mode, large text,
    localization expansion, and reduced available vertical space.

18. VALIDATION RULES
    No user input is collected on this screen.

19. ERROR HANDLING
    No real service is invoked, so service errors are outside this UI.

20. LOADING STATE
    The splash presentation visually communicates application preparation.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    The splash UI remains displayable because it does not require networking.

23. SECURITY CONSIDERATIONS
    No credentials, personal data, tokens, or remote data are handled.

24. PERFORMANCE OPTIMIZATIONS
    Uses const widgets where possible and avoids unnecessary rebuilds.

25. WIDGET TREE OVERVIEW
    Material → Scaffold → Center → Responsive branding column →
    logo mark → LinguaLive name → multilingual tagline → progress indicator.

26. COMPLETE TESTING CHECKLIST
    Verify responsiveness, accessibility, dark mode, large text, animation,
    localization readiness, and clean startup integration.
*/

export 'presentation/pages/splash_page.dart';
export 'presentation/controllers/splash_controller.dart';
export 'presentation/widgets/splash_branding.dart';
export 'domain/entities/splash_feature_entity.dart';
export 'data/models/splash_feature_model.dart';
export 'data/data_sources/mock_splash_data_source.dart';
export 'data/dummy/splash_dummy_data.dart';
