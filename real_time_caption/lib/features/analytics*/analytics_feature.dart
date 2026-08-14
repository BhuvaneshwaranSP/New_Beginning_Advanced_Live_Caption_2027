/*
1. PAGE NAME
   Analytics Feature

2. PURPOSE
   Provides the public entry points for the LinguaLive Analytics feature.

3. DESCRIPTION
   Exposes Analytics domain entities, data models, dummy data sources,
   controller, page, and reusable presentation widgets.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Existing LinguaLive navigation → AnalyticsPage.

6. DYNAMIC COMPONENTS
   Analytics metrics, usage trend, language usage, session statistics,
   translation statistics, time-range state, and screen states.

7. FUTURE BACKEND INTEGRATION
   Replace the mock data source with repository-backed analytics data
   while keeping presentation contracts unchanged.

8. TECHNOLOGIES USED
   Dart and Flutter Material 3 in presentation layers.

9. REQUIRED DATA MODELS
   AnalyticsFeatureModel, AnalyticsMetricModel, UsagePointModel,
   LanguageUsageModel, SessionAnalyticsModel, TranslationAnalyticsModel.

10. FUTURE API ENDPOINTS
    Not defined at this UI stage.

11. DATABASE COLLECTIONS/TABLES
    None at this UI stage.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Derived from the application's active Material 3 ColorScheme.

15. ANIMATIONS
    Lightweight implicit animations may be used by presentation widgets.

16. ACCESSIBILITY
    Semantic labels, readable typography, sufficient touch targets,
    and non-color-only status communication.

17. EDGE CASES
    Empty analytics, zero sessions, long language names, zero usage,
    large text, and offline state.

18. VALIDATION RULES
    Analytics values displayed by the UI must remain within meaningful
    presentation ranges.

19. ERROR HANDLING
    Represented locally through AnalyticsViewState.

20. LOADING STATE
    Represented locally through AnalyticsViewState.loading.

21. EMPTY STATE
    Represented locally through AnalyticsViewState.empty.

22. OFFLINE BEHAVIOUR
    Represented locally through AnalyticsViewState.offline.

23. SECURITY CONSIDERATIONS
    No credentials, private user information, or network data are stored.

24. PERFORMANCE OPTIMIZATIONS
    Immutable models, const widgets, lightweight CustomPainter usage,
    and local dummy data.

25. WIDGET TREE OVERVIEW
    AnalyticsPage
    ├── AnalyticsHeader
    ├── AnalyticsSummaryCard
    ├── AnalyticsUsageChart
    ├── LanguageUsageCard
    ├── SessionAnalyticsCard
    └── TranslationAnalyticsCard

26. COMPLETE TESTING CHECKLIST
    Verify responsive layout, accessibility, dark mode, large text,
    multilingual content, chart rendering, empty/loading/error/offline
    states, local state changes, callbacks, and performance.
*/

export 'data/data_sources/mock_analytics_data_source.dart';
export 'data/dummy/analytics_dummy_data.dart';
export 'data/models/analytics_feature_model.dart';
export 'domain/entities/analytics_feature_entity.dart';
export 'presentation/controllers/analytics_controller.dart';
export 'presentation/pages/analytics_page.dart';
export 'presentation/widgets/analytics_header.dart';
export 'presentation/widgets/analytics_states.dart';
export 'presentation/widgets/analytics_summary_card.dart';
export 'presentation/widgets/analytics_usage_chart.dart';
export 'presentation/widgets/language_usage_card.dart';
export 'presentation/widgets/session_analytics_card.dart';
export 'presentation/widgets/translation_analytics_card.dart';
