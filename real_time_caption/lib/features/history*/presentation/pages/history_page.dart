/*
1. PAGE NAME
   History Page

2. PURPOSE
   Provides the main LinguaLive History experience for reviewing previous
   multilingual speech, call, and conversation sessions.

3. DESCRIPTION
   The page presents searchable and filterable historical communication
   sessions. It emphasizes language direction, transcript context,
   participants, duration, date, and session status while remaining
   lightweight and accessible.

4. UI SECTIONS
   - Material 3 History app bar
   - Offline information banner
   - Search and filter controls
   - History summary
   - Historical session cards
   - Loading, empty, error, and offline states

5. NAVIGATION FLOW
   LinguaLive Home / Conversations / Calls / Chat
       → History
       → select a historical session
       → future session detail/transcript view

6. DYNAMIC COMPONENTS
   - Search query
   - Session-type filters
   - Newest/oldest sorting
   - Local history records
   - Loading state
   - Empty state
   - Error state
   - Offline state

7. FUTURE BACKEND INTEGRATION
   The history list will later consume persisted conversation/session
   records from the application's supported history storage and
   synchronization flow. This page currently uses only local dummy data.

8. TECHNOLOGIES USED
   - Flutter
   - Material 3
   - Built-in ChangeNotifier
   - Local Dart dummy models

9. REQUIRED DATA MODELS
   HistoryFeatureModel
   HistoryFeatureEntity

10. FUTURE API ENDPOINTS
    No API endpoint is implemented in this UI-only version.
    Future integration should expose historical session retrieval and
    session-detail retrieval according to the project's backend design.

11. DATABASE COLLECTIONS/TABLES
    No database is implemented in this UI-only version.
    Future persistence should store session metadata and supported
    conversation-history records according to the project's data design.

12. REQUIRED ASSETS
    No custom assets are required.

13. REQUIRED ICONS
    Material Icons:
    history, search, refresh, graphic_eq, call, forum, cloud_off,
    people, timer, calendar, check_circle, pause_circle, chevron_right.

14. THEME COLORS
    Material 3 ColorScheme:
    primary, secondaryContainer, surface, surfaceContainer,
    surfaceContainerHighest, onSurfaceVariant, and error.

15. ANIMATIONS
    - Material interaction animations
    - Lightweight skeleton transition
    - Standard chip/menu transitions

16. ACCESSIBILITY
    - Semantic session summaries
    - Descriptive tooltips
    - Readable status labels
    - Status never depends only on color
    - Minimum practical touch targets
    - Flexible text layouts for large fonts
    - High readability of multilingual transcript previews

17. EDGE CASES
    - Zero history records
    - No search matches
    - Long session names
    - Long multilingual text
    - Large participant counts
    - Interrupted sessions
    - Offline sessions
    - Loading state
    - Error/retry state
    - Large text scaling
    - Narrow landscape layouts

18. VALIDATION RULES
    Search accepts normal Unicode multilingual text.
    Filter and sort values are restricted to HistoryController enums.
    No remote input is accepted by the UI-only screen.

19. ERROR HANDLING
    A local error state is represented for integration testing.
    Retry reloads the local mock history.

20. LOADING STATE
    Initial local history loading is represented with skeleton cards.

21. EMPTY STATE
    Empty history and empty search/filter results are represented
    separately.

22. OFFLINE BEHAVIOUR
    The UI can display available history while showing an offline banner.
    No actual network detection or synchronization is implemented.

23. SECURITY CONSIDERATIONS
    No real conversation data, authentication, networking, database,
    or external AI service is used. Dummy transcript text is fictional.

24. PERFORMANCE OPTIMIZATIONS
    - Immutable dummy data
    - Lightweight stateless widgets
    - Local ChangeNotifier state
    - Limited implicit animation
    - No unnecessary third-party dependencies
    - Flexible list rendering

25. WIDGET TREE OVERVIEW
    HistoryPage
      └── Scaffold
          └── CustomScrollView
              ├── HistoryHeader
              └── SliverToBoxAdapter
                  └── Centered content
                      ├── Offline banner
                      ├── Search/filter controls
                      ├── Summary row
                      └── State / HistorySessionCard list

26. COMPLETE TESTING CHECKLIST
    Layout:
      - Phone portrait
      - Phone landscape
      - Tablet portrait
      - Tablet landscape
      - Large font
      - Long multilingual strings
      - No horizontal/vertical overflow

    Interaction:
      - Search
      - Clear search
      - Session filters
      - Sort menu
      - Refresh
      - Retry
      - Reset filters
      - Session card action

    States:
      - Loading
      - Success
      - Empty
      - No search results
      - Error
      - Offline

    Accessibility:
      - Screen reader
      - Semantic card labels
      - Icon tooltips
      - Keyboard navigation where supported
      - Non-color-only status

    Theme:
      - Light mode
      - Dark mode
      - Material 3 contrast

    Performance:
      - Smooth scrolling
      - No excessive rebuilds
      - Stable skeleton animation
      - Larger dummy history lists

    Integration:
      - Page can receive a session-open callback
      - Future session detail integration point remains isolated
      - No backend/API/database functionality is executed
*/

import 'package:flutter/material.dart';

import '../controllers/history_controller.dart';
import '../widgets/history_filter_bar.dart';
import '../widgets/history_header.dart';
import '../widgets/history_session_card.dart';
import '../widgets/history_states.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key, this.onOpenSession});

  final ValueChanged<String>? onOpenSession;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late final HistoryController _controller;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _controller = HistoryController();
    _searchController = TextEditingController();
    _controller.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    if (!mounted) {
      return;
    }

    if (_searchController.text != _controller.searchQuery) {
      _searchController.value = TextEditingValue(
        text: _controller.searchQuery,
        selection: TextSelection.collapsed(
          offset: _controller.searchQuery.length,
        ),
      );
    }

    setState(() {});
  }

  void _handleSessionOpen(String sessionId) {
    if (widget.onOpenSession != null) {
      widget.onOpenSession!(sessionId);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Session detail is ready for future integration.'),
      ),
    );
    // Future: navigate to the persisted session-detail/transcript view here; this action belongs here because the history card is the user's entry point into a historical session.
  }

  void _resetFilters() {
    _searchController.clear();
    _controller.clearSearch();
    _controller.setFilter(HistoryFilter.all);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.sizeOf(context);

    final horizontalPadding = mediaQuery.width >= 900
        ? 32.0
        : mediaQuery.width >= 600
        ? 24.0
        : 16.0;

    final maxContentWidth = mediaQuery.width >= 1100 ? 880.0 : 760.0;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            HistoryHeader(
              sessionCount: _controller.totalSessions,
              isLoading: _controller.isLoading,
              onRefresh: _controller.loadHistory,
            ),
            SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxContentWidth),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      16,
                      horizontalPadding,
                      32,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_controller.isOffline) ...[
                          HistoryOfflineBanner(
                            onDismiss: () {
                              _controller.setOfflinePreview(false);
                            },
                          ),
                          const SizedBox(height: 16),
                        ],
                        HistoryFilterBar(
                          searchController: _searchController,
                          filter: _controller.filter,
                          sort: _controller.sort,
                          onSearchChanged: _controller.setSearchQuery,
                          onClearSearch: () {
                            _searchController.clear();
                            _controller.clearSearch();
                          },
                          onFilterChanged: _controller.setFilter,
                          onSortChanged: _controller.setSort,
                        ),
                        const SizedBox(height: 24),
                        _HistorySummary(
                          visibleCount: _controller.visibleHistory.length,
                          totalCount: _controller.totalSessions,
                          filter: _controller.filter,
                        ),
                        const SizedBox(height: 14),
                        _buildHistoryContent(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryContent() {
    if (_controller.isLoading) {
      return const HistoryLoadingState();
    }

    if (_controller.hasError) {
      return HistoryErrorState(onRetry: _controller.loadHistory);
    }

    final sessions = _controller.visibleHistory;

    if (sessions.isEmpty) {
      return HistoryEmptyState(
        hasSearch:
            _controller.searchQuery.trim().isNotEmpty ||
            _controller.filter != HistoryFilter.all,
        onReset: _resetFilters,
      );
    }

    return ListView.separated(
      itemCount: sessions.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final session = sessions[index];

        return HistorySessionCard(
          session: session,
          onOpen: () => _handleSessionOpen(session.id),
        );
      },
    );
  }
}

class _HistorySummary extends StatelessWidget {
  const _HistorySummary({
    required this.visibleCount,
    required this.totalCount,
    required this.filter,
  });

  final int visibleCount;
  final int totalCount;
  final HistoryFilter filter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final filterLabel = switch (filter) {
      HistoryFilter.all => 'All sessions',
      HistoryFilter.liveSpeech => 'Live speech',
      HistoryFilter.calls => 'Calls',
      HistoryFilter.conversations => 'Conversations',
    };

    return Row(
      children: [
        Expanded(
          child: Text(
            filter == HistoryFilter.all
                ? '$visibleCount sessions available'
                : '$visibleCount of $totalCount sessions',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            filterLabel,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
