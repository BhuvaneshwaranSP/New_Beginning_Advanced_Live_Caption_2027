/*
1. PAGE NAME
   Help Center Feature

2. PURPOSE
   Public barrel entry for the LinguaLive Help Center feature.

3. DESCRIPTION
   Exports the feature's page, domain entities, models, data source, and
   controller without changing the supplied project folder structure.

4. UI SECTIONS
   Exports the Help Center page and reusable feature components.

5. NAVIGATION FLOW
   Application router → HelpCenterPage.

6. DYNAMIC COMPONENTS
   Search, categories, FAQ articles, and UI states.

7. FUTURE BACKEND INTEGRATION
   Future: expose production-ready Help Center data contracts through the
   feature exports once the project defines a supported backend source.

8. TECHNOLOGIES USED
   Dart and Flutter.

9. REQUIRED DATA MODELS
   Help Center models and entities.

10. FUTURE API ENDPOINTS
    Not specified by supplied documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified by supplied documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Global application theme.

15. ANIMATIONS
    FAQ expansion animation.

16. ACCESSIBILITY
    Provided by exported presentation widgets.

17. EDGE CASES
    Empty, error, loading, offline, and long-content states.

18. VALIDATION RULES
    Local search uses normalized text matching.

19. ERROR HANDLING
    Local presentation states.

20. LOADING STATE
    Provided by Help Center state widgets.

21. EMPTY STATE
    Provided by Help Center state widgets.

22. OFFLINE BEHAVIOUR
    Local content and offline representation.

23. SECURITY CONSIDERATIONS
    No sensitive data is handled by the UI.

24. PERFORMANCE OPTIMIZATIONS
    Small immutable dummy data and reusable widgets.

25. WIDGET TREE OVERVIEW
    HelpCenterPage → Help Center presentation widgets.

26. COMPLETE TESTING CHECKLIST
    Validate public exports and integration with the application's router.
*/

export 'data/data_sources/mock_help_center_data_source.dart';
export 'data/models/help_center_feature_model.dart';
export 'domain/entities/help_center_feature_entity.dart';
export 'presentation/controllers/help_center_controller.dart';
export 'presentation/pages/help_center_page.dart';
export 'presentation/widgets/help_center_article_tile.dart';
export 'presentation/widgets/help_center_category_card.dart';
export 'presentation/widgets/help_center_header.dart';
export 'presentation/widgets/help_center_search.dart';
export 'presentation/widgets/help_center_states.dart';
