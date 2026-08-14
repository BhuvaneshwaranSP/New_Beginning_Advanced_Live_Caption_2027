/*
1. PAGE NAME
   Calls States

2. PURPOSE
   Provides reusable loading, empty, error, and offline UI states.

3. DESCRIPTION
   These are presentation-only states using local dummy conditions.

4. UI SECTIONS
   Loading, empty, error, and offline banners.

5. NAVIGATION FLOW
   CallsController state → CallsPage → state widget.

6. DYNAMIC COMPONENTS
   Error retry callback and state messages.

7. FUTURE BACKEND INTEGRATION
   Future connection state will be supplied by the real call-session service.

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
    cloud_off, error_outline, phone_disabled.

14. THEME COLORS
    Active ColorScheme.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    State messages are visible text, not color-only indicators.

17. EDGE CASES
    All states can be displayed independently.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    Local retry callback.

20. LOADING STATE
    Included.

21. EMPTY STATE
    Included.

22. OFFLINE BEHAVIOUR
    Included.

23. SECURITY CONSIDERATIONS
    No sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Small stateless widgets.

25. WIDGET TREE OVERVIEW
    Center → icon → text → optional button.

26. COMPLETE TESTING CHECKLIST
    Verify every state at small and large text sizes.
*/

import 'package:flutter/material.dart';

class CallsOfflineBanner extends StatelessWidget {
  const CallsOfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        children: <Widget>[
          Icon(Icons.cloud_off_outlined),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'You are offline. Recent call information is shown locally.',
            ),
          ),
        ],
      ),
    );
  }
}

class CallsLoadingState extends StatelessWidget {
  const CallsLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class CallsEmptyState extends StatelessWidget {
  const CallsEmptyState({super.key, this.searching = false});

  final bool searching;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              searching
                  ? Icons.search_off_rounded
                  : Icons.phone_disabled_outlined,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              searching ? 'No calls found' : 'No calls yet',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              searching
                  ? 'Try another name or language.'
                  : 'Your multilingual conversations will appear here.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class CallsErrorState extends StatelessWidget {
  const CallsErrorState({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.error_outline_rounded, size: 48),
            const SizedBox(height: 16),
            Text(
              'Something went wrong',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'The local Calls preview could not be prepared.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
