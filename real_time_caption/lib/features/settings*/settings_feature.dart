/*
1. PAGE NAME
   Settings Feature Barrel

2. PURPOSE
   Provides the public entry point and exports for the LinguaLive Settings feature.

3. DESCRIPTION
   Exposes the Settings page and feature-specific presentation components without
   introducing backend or infrastructure behavior.

4. UI SECTIONS
   The exported page contains language, translation, speech/caption,
   connectivity, appearance, and information-oriented settings.

5. NAVIGATION FLOW
   Application navigation → SettingsPage.

6. DYNAMIC COMPONENTS
   Settings preferences, selection values, switches, and local UI states.

7. FUTURE BACKEND INTEGRATION
   Settings persistence and synchronization can be connected at the controller
   or data-source boundary when the application backend is implemented.

8. TECHNOLOGIES USED
   Dart and Flutter Material 3.

9. REQUIRED DATA MODELS
   SettingsFeatureEntity and SettingsFeatureModel.

10. FUTURE API ENDPOINTS
    None defined by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    None defined by the supplied project documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Uses the application's active Material 3 color scheme.

15. ANIMATIONS
    Lightweight implicit selection and state animations.

16. ACCESSIBILITY
    Semantic labels, adequate touch targets, readable hierarchy,
    and non-color-only state communication.

17. EDGE CASES
    Empty preference labels, long language names, narrow layouts,
    large text, and offline preference state.

18. VALIDATION RULES
    Displayed settings values must remain valid local UI values.

19. ERROR HANDLING
    Local error state only; no real service failure handling.

20. LOADING STATE
    Local loading representation is available for future integration.

21. EMPTY STATE
    Local empty representation is available when no settings are available.

22. OFFLINE BEHAVIOUR
    Offline preference is represented locally only.

23. SECURITY CONSIDERATIONS
    No credentials, tokens, or private data are handled by this feature.

24. PERFORMANCE OPTIMIZATIONS
    Small immutable models, local state, const widgets, and lightweight rebuilds.

25. WIDGET TREE OVERVIEW
    SettingsPage
      → Header
      → Settings Sections
        → Settings Tiles
      → State representations where required.

26. COMPLETE TESTING CHECKLIST
    See the screen-level checklist supplied before this file.
*/

export 'presentation/pages/settings_page.dart';
export 'presentation/controllers/settings_controller.dart';
export 'presentation/widgets/settings_header.dart';
export 'presentation/widgets/settings_section.dart';
export 'presentation/widgets/settings_tile.dart';
export 'presentation/widgets/settings_states.dart';
