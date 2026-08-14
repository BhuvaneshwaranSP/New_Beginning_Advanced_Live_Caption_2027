/*
1. PAGE NAME
   History Feature Barrel

2. PURPOSE
   Provides the public exports for the LinguaLive History feature.

3. DESCRIPTION
   Exposes the History page and feature-level types without changing
   the existing LinguaLive project structure.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Home / Conversations / Calls / Chat
        → History
        → selected historical session

6. DYNAMIC COMPONENTS
   History records, filters, search results, sorting state, and local
   loading/empty/error/offline representations.

7. FUTURE BACKEND INTEGRATION
   The presentation layer will later consume persisted session history
   from the project's supported history data source and repository flow.

8. TECHNOLOGIES USED
   Dart and Flutter Material 3.

9. REQUIRED DATA MODELS
   HistoryFeatureModel and HistoryFeatureEntity.

10. FUTURE API ENDPOINTS
    No endpoint is implemented by this UI-only feature.

11. DATABASE COLLECTIONS/TABLES
    No database is implemented by this UI-only feature.

12. REQUIRED ASSETS
    No custom asset is required.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    Lightweight implicit card/filter transitions.

16. ACCESSIBILITY
    Semantic labels, readable status text, adequate touch targets,
    and color-independent status communication.

17. EDGE CASES
    Empty history, long multilingual content, search with no results,
    offline state, and loading state.

18. VALIDATION RULES
    Search accepts empty or non-empty text without invalid operations.

19. ERROR HANDLING
    UI-only error state with retry callback representation.

20. LOADING STATE
    Local simulated loading representation.

21. EMPTY STATE
    Dedicated empty-history and no-search-results representations.

22. OFFLINE BEHAVIOUR
    Previously available local history remains represented while the
    UI communicates that synchronization is unavailable.

23. SECURITY CONSIDERATIONS
    No real conversation content is persisted or transmitted by this UI.

24. PERFORMANCE OPTIMIZATIONS
    Local immutable dummy data, const widgets where possible, and
    filtered lists generated only when controller state changes.

25. WIDGET TREE OVERVIEW
    HistoryPage
      └── Scaffold
          ├── HistoryHeader
          └── CustomScrollView
              ├── Summary
              ├── Search
              ├── Filters
              └── HistorySessionCard list

26. COMPLETE TESTING CHECKLIST
    See the screen-level checklist supplied before the Dart files.
*/

export 'data/models/history_feature_model.dart';
export 'data/data_sources/mock_history_data_source.dart';
export 'data/dummy/history_dummy_data.dart';
export 'domain/entities/history_feature_entity.dart';
export 'presentation/controllers/history_controller.dart';
export 'presentation/pages/history_page.dart';
export 'presentation/widgets/history_filter_bar.dart';
export 'presentation/widgets/history_header.dart';
export 'presentation/widgets/history_session_card.dart';
export 'presentation/widgets/history_states.dart';
