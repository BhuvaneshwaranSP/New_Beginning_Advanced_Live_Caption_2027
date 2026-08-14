/*
1. PAGE NAME
   History States

2. PURPOSE
   Provides reusable loading, empty, error, and offline state widgets.

3. DESCRIPTION
   Keeps state-specific presentation separate from the main History page.

4. UI SECTIONS
   Loading skeleton, empty state, error state, offline banner.

5. NAVIGATION FLOW
   History page → appropriate state based on local controller state.

6. DYNAMIC COMPONENTS
   State messages and callbacks.

7. FUTURE BACKEND INTEGRATION
   Retry and synchronization callbacks will later invoke the project's
   history persistence/synchronization flow.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   None.

10. FUTURE API ENDPOINTS
    None implemented.

11. DATABASE COLLECTIONS/TABLES
    None implemented.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    AnimatedContainer for skeleton shimmer-like state emphasis without
    introducing an animation dependency.

16. ACCESSIBILITY
    State icons are accompanied by readable text.

17. EDGE CASES
    No search result versus completely empty history.

18. VALIDATION RULES
    Retry callback is always supplied.

19. ERROR HANDLING
    Error state only communicates a local UI simulation.

20. LOADING STATE
    Skeleton cards are displayed.

21. EMPTY STATE
    Separate messages distinguish no history from no search matches.

22. OFFLINE BEHAVIOUR
    Offline banner explains that locally available history remains usable.

23. SECURITY CONSIDERATIONS
    No network or persistence operation is performed.

24. PERFORMANCE OPTIMIZATIONS
    Small fixed skeleton list.

25. WIDGET TREE OVERVIEW
    State widget → icon → message → optional action.

26. COMPLETE TESTING CHECKLIST
    Verify state text, button semantics, dark mode, large text, and
    narrow screen layout.
*/

import 'package:flutter/material.dart';

class HistoryLoadingState extends StatelessWidget {
  const HistoryLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (index) => const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: _HistorySkeletonCard(),
        ),
      ),
    );
  }
}

class _HistorySkeletonCard extends StatefulWidget {
  const _HistorySkeletonCard();

  @override
  State<_HistorySkeletonCard> createState() => _HistorySkeletonCardState();
}

class _HistorySkeletonCardState extends State<_HistorySkeletonCard> {
  bool _highlight = false;

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 250), () {
      if (mounted) {
        setState(() {
          _highlight = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: 178,
      decoration: BoxDecoration(
        color: _highlight
            ? theme.colorScheme.surfaceContainerHighest
            : theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainer,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 18,
                  width: 170,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 14,
                  width: 120,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  height: 12,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 12,
                  width: 210,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryEmptyState extends StatelessWidget {
  const HistoryEmptyState({
    super.key,
    required this.hasSearch,
    required this.onReset,
  });

  final bool hasSearch;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 48),
        child: Column(
          children: [
            CircleAvatar(
              radius: 34,
              backgroundColor: theme.colorScheme.secondaryContainer,
              child: Icon(
                hasSearch ? Icons.search_off_rounded : Icons.history_rounded,
                size: 32,
                color: theme.colorScheme.onSecondaryContainer,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              hasSearch ? 'No matching sessions' : 'Your history is empty',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              hasSearch
                  ? 'Try a different phrase, language, or session type.'
                  : 'Completed multilingual sessions will appear here.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            if (hasSearch) ...[
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: onReset,
                icon: const Icon(Icons.filter_alt_off_rounded),
                label: const Text('Reset filters'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class HistoryErrorState extends StatelessWidget {
  const HistoryErrorState({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 48),
        child: Column(
          children: [
            Icon(
              Icons.cloud_off_rounded,
              size: 44,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'History could not be loaded',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This is a local UI error state for integration testing.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryOfflineBanner extends StatelessWidget {
  const HistoryOfflineBanner({super.key, required this.onDismiss});

  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(
            Icons.cloud_off_outlined,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Offline history is shown. New synchronization is unavailable.',
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            tooltip: 'Dismiss offline notice',
            onPressed: onDismiss,
            icon: const Icon(Icons.close_rounded),
          ),
        ],
      ),
    );
  }
}
