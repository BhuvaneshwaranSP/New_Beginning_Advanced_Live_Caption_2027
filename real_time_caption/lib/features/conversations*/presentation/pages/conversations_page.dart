/*
1. PAGE NAME
   Conversations Page

2. PURPOSE
   Displays LinguaLive's multilingual conversation/session history.

3. DESCRIPTION
   The page provides a focused history experience for previous multilingual
   communication sessions, with search, category filtering, sorting, pinned
   sessions, and explicit UI states.

4. UI SECTIONS
   Header, search/filter controls, conversation history, and state content.

5. NAVIGATION FLOW
   LinguaLive navigation → Conversations → future selected session detail.

6. DYNAMIC COMPONENTS
   Local conversation cards, search results, filters, sorting, and state views.

7. FUTURE BACKEND INTEGRATION
   Future Session History persistence/retrieval will be connected at the
   controller/data-source boundary. Selecting a conversation will eventually
   open its stored transcript/session detail.

8. TECHNOLOGIES USED
   Flutter Material 3, ChangeNotifier, and local Dart models.

9. REQUIRED DATA MODELS
   ConversationsFeatureModel.

10. FUTURE API ENDPOINTS
    No exact API endpoint is defined by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    The project specifies Session History, but does not define an exact
    collection/table schema for this screen.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 ColorScheme from the application theme.

15. ANIMATIONS
    AnimatedSwitcher for content-state transitions and native Material
    interaction animations.

16. ACCESSIBILITY
    Semantic conversation cards, labelled controls, readable contrast,
    scalable text, and sufficient touch targets.

17. EDGE CASES
    Empty history, no search results, long titles, long previews, multiple
    participants, multilingual strings, loading, error, and offline states.

18. VALIDATION RULES
    Search is plain text and filtering is case-insensitive.

19. ERROR HANDLING
    Local error state with retry.

20. LOADING STATE
    Local conversation skeleton representation.

21. EMPTY STATE
    Separate empty-history and no-search-results presentations.

22. OFFLINE BEHAVIOUR
    A local offline state is available; no connectivity service is invoked.

23. SECURITY CONSIDERATIONS
    This UI-only implementation contains fictional data and performs no
    external transmission or persistence.

24. PERFORMANCE OPTIMIZATIONS
    Uses local immutable dummy data, bounded content widths, lightweight
    widgets, and ListView.builder for conversation rendering.

25. WIDGET TREE OVERVIEW
    Scaffold
      → SafeArea
        → CustomScrollView
          → header
          → search/filter section
          → AnimatedSwitcher
             → state widget OR conversation list

26. COMPLETE TESTING CHECKLIST
    Layout/overflow, keyboard, phone/tablet responsiveness, landscape,
    dark mode, large text, screen reader, loading, empty, error, success,
    offline, long/null/invalid display data, search, filtering, sorting,
    state transitions, animation, performance, memory, and localization.
*/

import 'package:flutter/material.dart';
import '../../data/models/conversations_feature_model.dart';
import '../controllers/conversations_controller.dart';
import '../widgets/conversation_card.dart';
import '../widgets/conversation_filter_bar.dart';
import '../widgets/conversation_states.dart';
import '../widgets/conversations_header.dart';

class ConversationsPage extends StatefulWidget {
  const ConversationsPage({super.key});

  @override
  State<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  late final ConversationsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ConversationsController();
    _controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double horizontalPadding = constraints.maxWidth >= 900
                ? 32
                : 18;

            final double maxContentWidth = constraints.maxWidth >= 1200
                ? 980
                : 900;

            return CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxContentWidth),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          20,
                          horizontalPadding,
                          0,
                        ),
                        child: ConversationsHeader(
                          onRefreshPressed: _controller.simulateLoading,
                          onMorePressed: _showMoreOptions,
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxContentWidth),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          22,
                          horizontalPadding,
                          16,
                        ),
                        child: ConversationFilterBar(controller: _controller),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxContentWidth),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 220),
                          child: _buildContent(),
                        ),
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 28)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (_controller.state) {
      case ConversationsViewState.loading:
        return const ConversationLoadingState(key: ValueKey<String>('loading'));

      case ConversationsViewState.empty:
        return ConversationEmptyState(
          key: const ValueKey<String>('empty'),
          isSearchEmpty: false,
          onClearSearch: _controller.clearSearch,
        );

      case ConversationsViewState.error:
        return ConversationErrorState(
          key: const ValueKey<String>('error'),
          onRetry: _controller.retry,
        );

      case ConversationsViewState.offline:
        return const ConversationOfflineState(key: ValueKey<String>('offline'));

      case ConversationsViewState.success:
        if (_controller.visibleConversations.isEmpty) {
          return ConversationEmptyState(
            key: const ValueKey<String>('search-empty'),
            isSearchEmpty: _controller.isSearchResultEmpty,
            onClearSearch: _controller.clearSearch,
          );
        }

        return _ConversationList(
          key: const ValueKey<String>('success'),
          conversations: _controller.visibleConversations,
        );
    }
  }

  void _showMoreOptions() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.checklist_rounded),
                  title: const Text('Select conversations'),
                  subtitle: const Text('UI-only selection preview'),
                  onTap: () => Navigator.of(context).pop(),
                ),
                ListTile(
                  leading: const Icon(Icons.cloud_off_rounded),
                  title: const Text('Preview offline state'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _controller.simulateOffline();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.inbox_outlined),
                  title: const Text('Preview empty state'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _controller.showEmptyState();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ConversationList extends StatelessWidget {
  const _ConversationList({super.key, required this.conversations});

  final List<ConversationsFeatureModel> conversations;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List<Widget>.generate(conversations.length, (int index) {
        final conversation = conversations[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: ConversationCard(
            conversation: conversation,
            onTap: () {
              // Future: open the selected Session History record here;
              // this card represents a previously stored multilingual session.
            },
            onMorePressed: () {
              // Future: expose actions for the selected Session History record
              // here, such as viewing or managing its stored conversation.
            },
          ),
        );
      }),
    );
  }
}
