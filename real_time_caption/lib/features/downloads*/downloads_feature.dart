/*
1. PAGE NAME
   Downloads Feature Entry

2. PURPOSE
   Public entry point for the LinguaLive Downloads feature.

3. DESCRIPTION
   Exports the Downloads presentation page and feature-level components.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Application navigation → Downloads page.

6. DYNAMIC COMPONENTS
   Downloads list, search, filters, download states, and item actions.

7. FUTURE BACKEND INTEGRATION
   Future: connect the Downloads feature to the project's intended local/offline
   storage and download services; this entry point exposes the feature without
   coupling navigation to implementation details.

8. TECHNOLOGIES USED
   Dart and Flutter Material 3.

9. REQUIRED DATA MODELS
   DownloadsFeatureModel and DownloadsFeatureEntity.

10. FUTURE API ENDPOINTS
    No Downloads-specific endpoint is defined in the supplied project sources.

11. DATABASE COLLECTIONS/TABLES
    No Downloads-specific table is defined in the supplied project sources.

12. REQUIRED ASSETS
    No dedicated assets required.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Uses the application's Material 3 ColorScheme.

15. ANIMATIONS
    Lightweight implicit card/state animations.

16. ACCESSIBILITY
    Semantic labels, adequate touch targets, and text-scalable layouts.

17. EDGE CASES
    Empty downloads, failed items, paused items, offline state, and long names.

18. VALIDATION RULES
    Search/filter values are local UI values only.

19. ERROR HANDLING
    Error state is represented locally with retry UI.

20. LOADING STATE
    Local skeleton/loading representation.

21. EMPTY STATE
    Dedicated empty downloads representation.

22. OFFLINE BEHAVIOUR
    Local offline banner; no network operation is performed.

23. SECURITY CONSIDERATIONS
    No credentials, files, or remote resources are accessed by this UI.

24. PERFORMANCE OPTIMIZATIONS
    Const widgets where possible and lightweight list construction.

25. WIDGET TREE OVERVIEW
    DownloadsPage → Header → Search/Filters → Download Items/State.

26. COMPLETE TESTING CHECKLIST
    See the project-level Downloads test checklist supplied with this feature.
*/

export 'presentation/pages/downloads_page.dart';
export 'presentation/controllers/downloads_controller.dart';
export 'data/models/downloads_feature_model.dart';
export 'domain/entities/downloads_feature_entity.dart';
