/*
1. PAGE NAME
   AI Models Feature Entry

2. PURPOSE
   Provides the public exports for the LinguaLive AI Models feature.

3. DESCRIPTION
   Keeps the feature entry point small and exposes the AI Models page and
   feature-level domain/data components required by the application.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Application navigation → AI Models feature → AiModelsPage.

6. DYNAMIC COMPONENTS
   AI model catalog, model categories, model status, and local selection state.

7. FUTURE BACKEND INTEGRATION
   The feature page will later receive model availability and configuration
   information from the intended AI model infrastructure.

8. TECHNOLOGIES USED
   Dart and Flutter Material 3 are used by the presentation layer.

9. REQUIRED DATA MODELS
   AiModelEntity and AiModelModel.

10. FUTURE API ENDPOINTS
   None defined for the UI-only implementation.

11. DATABASE COLLECTIONS/TABLES
   None defined for the UI-only implementation.

12. REQUIRED ASSETS
   None. Material Icons are used.

13. REQUIRED ICONS
   AI/model-related Material Icons.

14. THEME COLORS
   Uses the application's active Material 3 ColorScheme.

15. ANIMATIONS
   Lightweight implicit card and selection animations are used by the page.

16. ACCESSIBILITY
   Public widgets are intended to support semantic labels and large text.

17. EDGE CASES
   Empty model catalog and unavailable model data are represented by UI states.

18. VALIDATION RULES
   No user-entered model configuration is validated in this UI-only layer.

19. ERROR HANDLING
   Local error and retry representations are provided by the presentation layer.

20. LOADING STATE
   Local loading representation is provided by the presentation layer.

21. EMPTY STATE
   Local empty-search/catalog representation is provided by the presentation layer.

22. OFFLINE BEHAVIOUR
   The UI can represent unavailable/offline model status without performing
   real connectivity detection.

23. SECURITY CONSIDERATIONS
   No credentials, model keys, endpoints, or sensitive configuration are stored.

24. PERFORMANCE OPTIMIZATIONS
   Dummy data is static and widgets are split into reusable components.

25. WIDGET TREE OVERVIEW
   AiModelsPage
   ├── AiModelsHeader
   ├── SearchBar
   ├── AiModelFilterBar
   └── AiModelCard list/grid

26. COMPLETE TESTING CHECKLIST
   Validate responsiveness, accessibility, theme behavior, state transitions,
   long content, search/filter presentation, and offline/error representations.
*/

export 'data/models/ai_model_model.dart';
export 'data/data_sources/mock_ai_models_data_source.dart';
export 'data/dummy/ai_models_dummy_data.dart';

export 'domain/entities/ai_model_entity.dart';

export 'presentation/controllers/ai_models_controller.dart';
export 'presentation/pages/ai_models_page.dart';
export 'presentation/widgets/ai_models_header.dart';
export 'presentation/widgets/ai_model_card.dart';
export 'presentation/widgets/ai_model_filter_bar.dart';
export 'presentation/widgets/ai_models_states.dart';
