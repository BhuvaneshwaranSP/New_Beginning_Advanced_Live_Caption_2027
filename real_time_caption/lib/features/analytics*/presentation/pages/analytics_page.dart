/*
1. PAGE NAME
   Analytics Page

2. PURPOSE
   Provides LinguaLive users with a clear visual summary of multilingual
   conversation and translation activity.

3. DESCRIPTION
   The screen presents high-level usage metrics, conversation activity,
   language distribution, session statistics, and translation quality
   using local dummy data. It is UI-only and does not perform real
   analytics collection, AI inference, networking, persistence, or
   backend operations.

4. UI SECTIONS
   - Analytics header
   - Time-range selector
   - Summary metric cards
   - Conversation activity chart
   - Language mix
   - Session overview
   - Translation quality
   - Loading/empty/error/offline states

5. NAVIGATION FLOW
   Existing LinguaLive navigation → AnalyticsPage.
   Buttons on this page currently use valid local callbacks only.

6. DYNAMIC COMPONENTS
   Analytics metrics, usage chart, language distribution,
   session statistics, translation statistics, selected range,
   loading state, empty state, error state, and offline state.

7. FUTURE BACKEND INTEGRATION
   AnalyticsController.load is the intended integration boundary for
   repository-backed analytics retrieval. The time-range callback in
   AnalyticsController is the intended location for requesting analytics
   for a selected reporting period.
   
   // Future: connect persisted LinguaLive session analytics here so the
   // dashboard reflects real conversation and translation activity.

8. TECHNOLOGIES USED
   Flutter Material 3.
   Dart local state through ChangeNotifier.
   No external state-management package.

9. REQUIRED DATA MODELS
   AnalyticsFeatureEntity, AnalyticsMetricEntity, UsagePointEntity,
   LanguageUsageEntity, SessionAnalyticsEntity,
   TranslationAnalyticsEntity.

10. FUTURE API ENDPOINTS
    Not specified by the current UI-only implementation.

11. DATABASE COLLECTIONS/TABLES
    Not specified by the current UI-only implementation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons:
    insights, refresh, trending_up, forum, language, schedule,
    check_circle, compare_arrows, show_chart, cloud_off.

14. THEME COLORS
    Uses the application's active Material 3 ColorScheme.
    No hard-coded brand palette is required by this screen.

15. ANIMATIONS
    Material segmented control transitions and progress indicators.
    No expensive custom animation is used.

16. ACCESSIBILITY
    - Semantic page heading.
    - Descriptive labels for analytics metrics.
    - Chart has a textual summary.
    - Percentages are displayed numerically as well as visually.
    - Touch targets use Material controls.
    - Layout remains readable with larger text.

17. EDGE CASES
    - No analytics
    - Loading
    - Error
    - Offline
    - Zero sessions
    - Zero translated words
    - Empty language list
    - Long language names
    - Long language-pair names
    - Narrow phone width
    - Tablet width
    - Landscape orientation
    - Large system text

18. VALIDATION RULES
    Analytics percentages are displayed within meaningful ranges.
    Time-range values must be one of the supported local options.

19. ERROR HANDLING
    Local data-source failures are represented by AnalyticsErrorState.
    The retry button invokes the controller's local load callback.

20. LOADING STATE
    AnalyticsLoadingState is shown while the local data source is loading.

21. EMPTY STATE
    AnalyticsEmptyState is shown when no meaningful analytics are available.

22. OFFLINE BEHAVIOUR
    AnalyticsOfflineState is available as a local representation.
    No real connectivity detection is implemented.

23. SECURITY CONSIDERATIONS
    No credentials, private transcripts, authentication information,
    network tokens, or personal data are used.

24. PERFORMANCE OPTIMIZATIONS
    - Local immutable dummy models.
    - Const widgets wherever practical.
    - Lightweight CustomPainter chart.
    - No network work in build methods.
    - Responsive Wrap/Row layouts.
    - Limited widget nesting.

25. WIDGET TREE OVERVIEW
    Scaffold
    └── SafeArea
        └── CustomScrollView
            └── SliverPadding
                └── SliverToBoxAdapter
                    └── AnalyticsHeader
                    └── Summary metrics
                    └── AnalyticsUsageChart
                    └── Responsive lower analytics cards
                        ├── LanguageUsageCard
                        ├── SessionAnalyticsCard
                        └── TranslationAnalyticsCard

26. COMPLETE TESTING CHECKLIST
    - Compile with null safety.
    - No analyzer warnings.
    - No deprecated Flutter APIs.
    - Verify small phone width.
    - Verify large phone width.
    - Verify tablet portrait.
    - Verify tablet landscape.
    - Verify dark mode.
    - Verify large text.
    - Verify screen-reader semantics.
    - Verify loading state.
    - Verify success state.
    - Verify empty state.
    - Verify error/retry state.
    - Verify offline state.
    - Verify time-range selection.
    - Verify refresh callback.
    - Verify zero-value analytics.
    - Verify long multilingual labels.
    - Verify chart rendering.
    - Verify scrolling.
    - Verify orientation changes.
    - Verify no keyboard overlap.
    - Verify smooth scrolling and chart performance.
    - Verify no backend/network/persistence implementation.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/analytics_feature_entity.dart';
import '../controllers/analytics_controller.dart';
import '../widgets/analytics_header.dart';
import '../widgets/analytics_states.dart';
import '../widgets/analytics_summary_card.dart';
import '../widgets/analytics_usage_chart.dart';
import '../widgets/language_usage_card.dart';
import '../widgets/session_analytics_card.dart';
import '../widgets/translation_analytics_card.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  late final AnalyticsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnalyticsController();
    _controller.addListener(_handleControllerChanged);
    _controller.load();
  }

  void _handleControllerChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleControllerChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = _controller.state;

    return Scaffold(body: SafeArea(child: _buildBody(state)));
  }

  Widget _buildBody(AnalyticsViewState state) {
    switch (state) {
      case AnalyticsViewState.loading:
        return const AnalyticsLoadingState();

      case AnalyticsViewState.empty:
        return _buildStateWithHeader(const AnalyticsEmptyState());

      case AnalyticsViewState.error:
        return _buildStateWithHeader(
          AnalyticsErrorState(onRetry: _handleRetry),
        );

      case AnalyticsViewState.offline:
        return _buildStateWithHeader(
          AnalyticsOfflineState(onRetry: _handleRetry),
        );

      case AnalyticsViewState.success:
        final analytics = _controller.analytics;

        if (analytics == null) {
          return _buildStateWithHeader(
            AnalyticsErrorState(onRetry: _handleRetry),
          );
        }

        return _buildAnalyticsContent(analytics);
    }
  }

  Widget _buildStateWithHeader(Widget stateWidget) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              AnalyticsHeader(
                selectedRange: _controller.selectedRange,
                onRangeChanged: _handleRangeChanged,
                onRefreshPressed: _handleRetry,
              ),
              const SizedBox(height: 180),
              SizedBox(height: 260, child: stateWidget),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildAnalyticsContent(AnalyticsFeatureEntity analytics) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontalPadding = constraints.maxWidth >= 900 ? 32.0 : 20.0;
        final contentMaxWidth = constraints.maxWidth >= 1200
            ? 1160.0
            : double.infinity;

        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                24,
                horizontalPadding,
                40,
              ),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: contentMaxWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnalyticsHeader(
                          selectedRange: _controller.selectedRange,
                          onRangeChanged: _handleRangeChanged,
                          onRefreshPressed: _handleRetry,
                        ),
                        const SizedBox(height: 24),
                        _buildSummaryGrid(context, analytics.metrics),
                        const SizedBox(height: 20),
                        AnalyticsUsageChart(points: analytics.usagePoints),
                        const SizedBox(height: 20),
                        _buildDetailGrid(context, analytics),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSummaryGrid(
    BuildContext context,
    List<AnalyticsMetricEntity> metrics,
  ) {
    const icons = [
      Icons.forum_outlined,
      Icons.translate_rounded,
      Icons.schedule_rounded,
      Icons.auto_awesome_rounded,
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 900
            ? 4
            : constraints.maxWidth >= 560
            ? 2
            : 1;

        final spacing = 14.0;
        final cardWidth =
            (constraints.maxWidth - ((columns - 1) * spacing)) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (var index = 0; index < metrics.length; index++)
              SizedBox(
                width: cardWidth,
                child: AnalyticsSummaryCard(
                  metric: metrics[index],
                  icon: icons[index % icons.length],
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildDetailGrid(
    BuildContext context,
    AnalyticsFeatureEntity analytics,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 760) {
          return Column(
            children: [
              LanguageUsageCard(languages: analytics.languages),
              const SizedBox(height: 16),
              SessionAnalyticsCard(analytics: analytics.sessions),
              const SizedBox(height: 16),
              TranslationAnalyticsCard(analytics: analytics.translations),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: LanguageUsageCard(languages: analytics.languages),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 4,
              child: SessionAnalyticsCard(analytics: analytics.sessions),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 5,
              child: TranslationAnalyticsCard(
                analytics: analytics.translations,
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleRangeChanged(String range) {
    _controller.selectRange(range);
  }

  void _handleRetry() {
    _controller.load();
  }
}
