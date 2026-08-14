/*
1. PAGE NAME
   Downloads Page

2. PURPOSE
   Provides LinguaLive's central view for downloaded multilingual resources
   and resources prepared for offline communication.

3. DESCRIPTION
   The screen presents downloaded language packs, transcripts, conversations,
   and audio resources using local dummy data only. It supports local search,
   filtering, loading/error/empty/offline representations, responsive layouts,
   and Material 3 accessibility patterns.

4. UI SECTIONS
   - Downloads heading and offline summary
   - Search
   - Filter chips
   - Download resource cards
   - Loading state
   - Error/retry state
   - Empty/search-empty state
   - Offline representation

5. NAVIGATION FLOW
   Application navigation → DownloadsPage.
   Individual action callbacks are intentionally empty because real file
   opening, download management, deletion, and persistence are not implemented.

6. DYNAMIC COMPONENTS
   - Download list
   - Search query
   - Download filters
   - Progress indicators
   - Download statuses
   - Offline availability
   - Loading/error/empty states

7. FUTURE BACKEND INTEGRATION
   Future: connect downloaded-resource inventory and item actions to the
   project's intended local/offline storage and download services; this page
   owns the presentation of those resources and therefore is the integration
   boundary for the resulting UI state.

8. TECHNOLOGIES USED
   - Flutter
   - Material 3
   - ChangeNotifier for local UI state

9. REQUIRED DATA MODELS
   DownloadsFeatureModel
   DownloadsFeatureEntity
   DownloadsFilter

10. FUTURE API ENDPOINTS
    No Downloads-specific API endpoints are defined in the supplied project
    documentation.

11. DATABASE COLLECTIONS/TABLES
    The project documentation specifies PostgreSQL + pgvector for application
    database search, but does not define a Downloads-specific table or schema.

12. REQUIRED ASSETS
    No dedicated assets are required.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Uses the application's inherited Material 3 ColorScheme.

15. ANIMATIONS
    Lightweight AnimatedContainer transitions on resource cards.

16. ACCESSIBILITY
    - Semantic status labels
    - Text labels accompanying status icons
    - Adequate interactive target sizes
    - Screen-reader-friendly search/filter controls
    - No status communicated through color alone
    - Flexible text layout for large font sizes

17. EDGE CASES
    - No downloads
    - No search matches
    - Failed resource
    - Paused resource
    - Resource currently downloading
    - Offline mode
    - Long multilingual filenames
    - Long language names
    - Large text scaling
    - Narrow screens
    - Tablet and landscape layouts

18. VALIDATION RULES
    Search is optional and locally filtered.
    No real file or network validation is performed.

19. ERROR HANDLING
    A local error state is displayed with a retry callback.
    Retry only reloads the local dummy source.

20. LOADING STATE
    A local loading representation is provided by DownloadsLoadingState.

21. EMPTY STATE
    DownloadsEmptyState distinguishes between an empty collection and an empty
    search result.

22. OFFLINE BEHAVIOUR
    The UI can display a local offline representation. No network operation
    is attempted.

23. SECURITY CONSIDERATIONS
    This UI does not access files, credentials, authentication tokens, network
    services, or persistent storage.

24. PERFORMANCE OPTIMIZATIONS
    - Small local immutable dummy dataset
    - Lightweight ChangeNotifier state
    - Stateless reusable widgets
    - Const constructors where possible
    - No unnecessary animation controllers
    - No external state-management package

25. WIDGET TREE OVERVIEW
    DownloadsPage
    └── SafeArea
        └── LayoutBuilder
            └── CustomScrollView
                ├── Header
                ├── Search + Filters
                └── Download content
                    ├── Loading
                    ├── Error
                    ├── Empty
                    └── Adaptive download cards

26. COMPLETE TESTING CHECKLIST
    - Layout/overflow
    - Keyboard/search
    - Portrait/landscape
    - Phone/tablet
    - Dark mode
    - Large text
    - Screen reader
    - Touch targets
    - Loading
    - Empty
    - Error/retry
    - Success/completed
    - Offline
    - Long multilingual data
    - Search/filter transitions
    - Action callbacks
    - Animation smoothness
    - Performance
    - Memory
    - Localization readiness
    - Analyzer/deprecated API validation
*/

import 'package:flutter/material.dart';

import '../../data/models/downloads_feature_model.dart';
import '../controllers/downloads_controller.dart';
import '../widgets/download_item_card.dart';
import '../widgets/downloads_filter_bar.dart';
import '../widgets/downloads_header.dart';
import '../widgets/downloads_states.dart';

class DownloadsPage extends StatefulWidget {
  const DownloadsPage({super.key});

  @override
  State<DownloadsPage> createState() => _DownloadsPageState();
}

class _DownloadsPageState extends State<DownloadsPage> {
  late final DownloadsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = DownloadsController();
    _controller.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onControllerChanged)
      ..dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final bool isWide = constraints.maxWidth >= 720;

            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isWide ? 32 : 20,
                    vertical: 24,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: DownloadsHeader(
                      totalCount: _controller.totalCount,
                      completedCount: _controller.completedCount,
                      isOffline: _controller.isOffline,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: isWide ? 32 : 20),
                  sliver: SliverToBoxAdapter(
                    child: DownloadsFilterBar(controller: _controller),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                if (_controller.isOffline)
                  const SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverToBoxAdapter(child: DownloadsOfflineState()),
                  ),
                if (_controller.isLoading)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: DownloadsLoadingState(),
                  )
                else if (_controller.hasError)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: DownloadsErrorState(onRetry: _controller.retry),
                  )
                else if (_controller.visibleDownloads.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: DownloadsEmptyState(
                      isSearchResult:
                          _controller.filter != DownloadsFilter.all ||
                          _controller.visibleDownloads.isEmpty,
                    ),
                  )
                else
                  _buildDownloadSliver(isWide),
                const SliverToBoxAdapter(child: SizedBox(height: 32)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDownloadSliver(bool isWide) {
    final List<DownloadsFeatureModel> items = _controller.visibleDownloads;

    if (!isWide) {
      return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        sliver: SliverList.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            final DownloadsFeatureModel item = items[index];

            return Padding(
              padding: EdgeInsets.only(
                bottom: index == items.length - 1 ? 0 : 12,
              ),
              child: DownloadItemCard(
                item: item,
                onActionPressed: () {
                  // Future: connect the selected resource action to the
                  // project's local download/open service; this callback
                  // belongs here because the card initiates the user action.
                },
              ),
            );
          },
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          final DownloadsFeatureModel item = items[index];

          return DownloadItemCard(
            item: item,
            onActionPressed: () {
              // Future: connect the selected resource action to the
              // project's local download/open service; this callback
              // belongs here because the card initiates the user action.
            },
          );
        }, childCount: items.length),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 520,
          mainAxisExtent: 260,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
      ),
    );
  }
}
