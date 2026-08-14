/*
1. PAGE NAME
   Conversation States

2. PURPOSE
   Provides loading, empty, error, and offline representations.

3. DESCRIPTION
   Keeps non-success UI states visually consistent with LinguaLive.

4. UI SECTIONS
   State icon, title, description, and optional action.

5. NAVIGATION FLOW
   Conversations page → state widget.

6. DYNAMIC COMPONENTS
   State-specific message and callback.

7. FUTURE BACKEND INTEGRATION
   Real session-history failures and connectivity conditions will later map
   into these UI states at the controller boundary.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   None.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    None specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    AnimatedSwitcher is supplied by the page.

16. ACCESSIBILITY
    Clear headings, descriptions, and semantic action labels.

17. EDGE CASES
    Empty history versus no search results.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    Retry callback is supplied by the parent.

20. LOADING STATE
    Skeleton-like animated placeholders.

21. EMPTY STATE
    Dedicated empty content.

22. OFFLINE BEHAVIOUR
    Explicit offline message without network access.

23. SECURITY CONSIDERATIONS
    No external data access.

24. PERFORMANCE OPTIMIZATIONS
    Lightweight placeholders instead of expensive shimmer packages.

25. WIDGET TREE OVERVIEW
    Center → constrained content → icon → title → description → action.

26. COMPLETE TESTING CHECKLIST
    Verify state transitions, semantics, large text, dark mode, and
    narrow screen behavior.
*/

import 'package:flutter/material.dart';

class ConversationLoadingState extends StatelessWidget {
  const ConversationLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      children: List<Widget>.generate(
        3,
        (int index) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  _LoadingBlock(
                    width: 48,
                    height: 48,
                    color: theme.colorScheme.surfaceContainerHighest,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _LoadingBlock(
                          width: double.infinity,
                          height: 17,
                          color: theme.colorScheme.surfaceContainerHighest,
                        ),
                        const SizedBox(height: 9),
                        _LoadingBlock(
                          width: index == 1 ? 180 : 240,
                          height: 14,
                          color: theme.colorScheme.surfaceContainerHighest,
                        ),
                        const SizedBox(height: 10),
                        _LoadingBlock(
                          width: 150,
                          height: 12,
                          color: theme.colorScheme.surfaceContainerHighest,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ConversationEmptyState extends StatelessWidget {
  const ConversationEmptyState({
    super.key,
    required this.isSearchEmpty,
    required this.onClearSearch,
  });

  final bool isSearchEmpty;
  final VoidCallback onClearSearch;

  @override
  Widget build(BuildContext context) {
    return _StateContent(
      icon: isSearchEmpty ? Icons.search_off_rounded : Icons.forum_outlined,
      title: isSearchEmpty ? 'No conversations found' : 'No conversations yet',
      description: isSearchEmpty
          ? 'Try another name, language, or search phrase.'
          : 'Your completed multilingual sessions will appear here.',
      actionLabel: isSearchEmpty ? 'Clear search' : null,
      onAction: isSearchEmpty ? onClearSearch : null,
    );
  }
}

class ConversationErrorState extends StatelessWidget {
  const ConversationErrorState({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return _StateContent(
      icon: Icons.error_outline_rounded,
      title: 'Could not load conversations',
      description:
          'The conversation history is temporarily unavailable in this demo state.',
      actionLabel: 'Retry',
      onAction: onRetry,
    );
  }
}

class ConversationOfflineState extends StatelessWidget {
  const ConversationOfflineState({super.key});

  @override
  Widget build(BuildContext context) {
    return const _StateContent(
      icon: Icons.cloud_off_rounded,
      title: 'You are offline',
      description:
          'Previously available local conversation previews remain visible when offline.',
    );
  }
}

class _StateContent extends StatelessWidget {
  const _StateContent({
    required this.icon,
    required this.title,
    required this.description,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String description;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 440),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
        child: Column(
          children: <Widget>[
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: 34,
                color: theme.colorScheme.onSecondaryContainer,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            if (actionLabel != null && onAction != null) ...<Widget>[
              const SizedBox(height: 20),
              FilledButton.tonal(
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _LoadingBlock extends StatelessWidget {
  const _LoadingBlock({
    required this.width,
    required this.height,
    required this.color,
  });

  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
