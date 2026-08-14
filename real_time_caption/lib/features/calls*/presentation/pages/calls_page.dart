/*
1. PAGE NAME
   Calls Page

2. PURPOSE
   Main LinguaLive Calls screen for browsing recent multilingual call
   sessions and presenting the call-oriented communication entry point.

3. DESCRIPTION
   A responsive Material 3 Calls interface using local dummy data only.
   The screen intentionally represents the Call Caption direction described
   in the project documentation without implementing actual calling,
   speech recognition, translation, audio, or networking.

4. UI SECTIONS
   - Calls introduction
   - Search
   - Offline status
   - Call capability summary
   - Recent calls
   - Loading state
   - Empty state
   - Error state

5. NAVIGATION FLOW
   Calls → select a recent call → future multilingual call/caption screen.

6. DYNAMIC COMPONENTS
   - Search results
   - Recent call cards
   - Connection state
   - Local loading/error/empty states

7. FUTURE BACKEND INTEGRATION
   Future: connect the selected call here to the live call-session layer so
   speech recognition, real-time captions, multilingual translation,
   speaker recognition, and optional text-to-speech can be provided during
   an active call. These capabilities belong at the call-session boundary
   because the supplied project defines them as Call Caption functionality.

8. TECHNOLOGIES USED
   - Flutter
   - Material 3
   - Dart null safety
   - ChangeNotifier from Flutter SDK

9. REQUIRED DATA MODELS
   - CallsFeatureModel
   - CallParticipantModel
   - CallLanguagePairModel
   - CallSessionEntity

10. FUTURE API ENDPOINTS
    No real endpoints are implemented.
    Future services will require:
    - Call session creation
    - Call accept/reject
    - Participant presence
    - Call state
    - Caption stream
    - Translation stream

11. DATABASE COLLECTIONS/TABLES
    No database is implemented.
    Future persistence may contain call-session history.

12. REQUIRED ASSETS
    No external assets required.

13. REQUIRED ICONS
    phone, videocam, translate, mic, language, search, cloud_off,
    history, refresh, chevron_right.

14. THEME COLORS
    Uses the application's active Material 3 ColorScheme.

15. ANIMATIONS
    Lightweight AnimatedSwitcher and implicit Material transitions.

16. ACCESSIBILITY
    - Semantic call-card descriptions
    - Readable status labels
    - Icon + text status communication
    - Adequate touch targets
    - Responsive layout
    - Large-text compatibility

17. EDGE CASES
    - No calls
    - No search matches
    - Long participant names
    - Long language labels
    - Offline state
    - Reconnecting state
    - Local error state
    - Large text
    - Narrow screens

18. VALIDATION RULES
    Search is trimmed and matched against participant and language labels.

19. ERROR HANDLING
    Local error state with retry callback. No actual service retry is performed.

20. LOADING STATE
    Local circular progress state.

21. EMPTY STATE
    Separate no-history and no-search-result representations.

22. OFFLINE BEHAVIOUR
    Displays an offline banner while continuing to show local dummy history.

23. SECURITY CONSIDERATIONS
    No authentication, call tokens, personal credentials, recordings,
    network addresses, or private communication data are implemented.

24. PERFORMANCE OPTIMIZATIONS
    - Local immutable dummy data
    - Small focused widgets
    - Limited ChangeNotifier updates
    - No expensive animations
    - No network or media processing

25. WIDGET TREE OVERVIEW
    CallsPage
      └── Scaffold
          └── SafeArea
              └── CustomScrollView
                  ├── SliverPadding
                  │   └── SliverToBoxAdapter
                  │       └── CallsHeader
                  ├── SliverPadding
                  │   └── SliverToBoxAdapter
                  │       └── OfflineBanner
                  ├── SliverPadding
                  │   └── SliverToBoxAdapter
                  │       └── CallsCapabilityCard
                  └── SliverPadding
                      └── SliverList
                          └── CallSessionCard

26. COMPLETE TESTING CHECKLIST
    - Layout/overflow
    - Keyboard/search
    - Portrait/landscape
    - Phone/tablet
    - Dark mode
    - Large text
    - Screen reader
    - Loading
    - Empty
    - Error/retry
    - Offline
    - Reconnecting
    - Long/null/invalid display values
    - Call-card interactions
    - Search filtering
    - Animation
    - Performance
    - Localization readiness
*/

import 'package:flutter/material.dart';

import '../controllers/calls_controller.dart';
import '../widgets/call_session_card.dart';
import '../widgets/calls_header.dart';
import '../widgets/calls_states.dart';

class CallsPage extends StatefulWidget {
  const CallsPage({super.key, this.onCallSelected});

  final ValueChanged<String>? onCallSelected;

  @override
  State<CallsPage> createState() => _CallsPageState();
}

class _CallsPageState extends State<CallsPage> {
  late final CallsController _controller;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _controller = CallsController();
    _searchController = TextEditingController();

    _controller.addListener(_handleControllerChanged);
    _controller.load();
  }

  void _handleControllerChanged() {
    if (!mounted) {
      return;
    }

    setState(() {});
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_handleControllerChanged)
      ..dispose();

    _searchController.dispose();
    super.dispose();
  }

  void _handleSearchChanged(String value) {
    _controller.setSearchQuery(value);
    setState(() {});
  }

  void _handleClearSearch() {
    _searchController.clear();
    _controller.clearSearch();
    setState(() {});
  }

  void _handleCallSelected(String callId) {
    widget.onCallSelected?.call(callId);

    // Future: connect this action to the active multilingual call session;
    // the selected card is the entry point into call captions and translation.
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double horizontalPadding = constraints.maxWidth >= 700
                ? 32
                : 20;

            final double contentMaxWidth = constraints.maxWidth >= 1100
                ? 900
                : double.infinity;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: contentMaxWidth),
                child: CustomScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: <Widget>[
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        20,
                        horizontalPadding,
                        16,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: CallsHeader(
                          searchController: _searchController,
                          onSearchChanged: _handleSearchChanged,
                          onClearSearch: _handleClearSearch,
                        ),
                      ),
                    ),
                    if (_controller.isOffline)
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          0,
                          horizontalPadding,
                          12,
                        ),
                        sliver: const SliverToBoxAdapter(
                          child: CallsOfflineBanner(),
                        ),
                      ),
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        0,
                        horizontalPadding,
                        20,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: _CallsCapabilityCard(
                          onPressed: () {
                            // Future: open the live Call Caption experience;
                            // this action represents the primary call entry point.
                          },
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        0,
                        horizontalPadding,
                        mediaQuery.padding.bottom + 24,
                      ),
                      sliver: _buildCallContent(theme),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCallContent(ThemeData theme) {
    if (_controller.isLoading) {
      return const SliverToBoxAdapter(child: CallsLoadingState());
    }

    if (_controller.hasError) {
      return SliverToBoxAdapter(
        child: CallsErrorState(onRetry: _controller.retry),
      );
    }

    final calls = _controller.calls;

    if (calls.isEmpty) {
      return SliverToBoxAdapter(
        child: CallsEmptyState(
          searching: _controller.searchQuery.trim().isNotEmpty,
        ),
      );
    }

    return SliverList.separated(
      itemCount: calls.length + 1,
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 10),
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Text(
              'Recent calls',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        }

        final call = calls[index - 1];

        return CallSessionCard(
          call: call,
          onPressed: () => _handleCallSelected(call.id),
        );
      },
    );
  }
}

class _CallsCapabilityCard extends StatelessWidget {
  const _CallsCapabilityCard({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;

    return Card(
      color: colors.primaryContainer,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: <Widget>[
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: colors.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.translate_rounded,
                  color: colors.onPrimary,
                  size: 27,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Multilingual calling',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colors.onPrimaryContainer,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Calls designed around live captions and language-aware communication.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_rounded,
                color: colors.onPrimaryContainer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
