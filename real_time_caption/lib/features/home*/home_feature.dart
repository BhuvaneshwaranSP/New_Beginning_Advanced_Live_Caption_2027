/*
1. PAGE NAME
   Home Feature Barrel

2. PURPOSE
   Provides the public entry point for the Home feature.

3. DESCRIPTION
   Exports the Home page and public Home domain types required by other
   application modules.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Application router → HomePage.

6. DYNAMIC COMPONENTS
   Exposed Home page and domain types.

7. FUTURE BACKEND INTEGRATION
   None. This file only controls feature exports.

8. TECHNOLOGIES USED
   Dart.

9. REQUIRED DATA MODELS
   Home domain entities.

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
    Implemented by Home presentation.

17. EDGE CASES
    None.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    None.

20. LOADING STATE
    Home presentation.

21. EMPTY STATE
    Home presentation.

22. OFFLINE BEHAVIOUR
    Home presentation.

23. SECURITY CONSIDERATIONS
    No sensitive data.

24. PERFORMANCE OPTIMIZATIONS
    Barrel exports only required public members.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify exports and router access.
*/

export 'domain/entities/home_feature_entity.dart';
export 'presentation/pages/home_page.dart';
export 'data/data_sources/mock_home_data_source.dart';
export 'presentation/controllers/home_controller.dart';
export 'presentation/widgets/home_feature_grid.dart';
export 'presentation/widgets/home_header.dart';
export 'presentation/widgets/home_states.dart';
export 'presentation/widgets/language_pair_card.dart';
export 'presentation/widgets/recent_session_card.dart';