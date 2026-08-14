/*
1. PAGE NAME
   Subscription States

2. PURPOSE
   Provides local loading, empty, error, success, and offline UI states.

3. DESCRIPTION
   These states are visual representations only and do not perform real
   connectivity or subscription operations.

4. UI SECTIONS
   State icon, title, message, optional action.

5. NAVIGATION FLOW
   SubscriptionPage → SubscriptionStates.

6. DYNAMIC COMPONENTS
   State type and optional callback.

7. FUTURE BACKEND INTEGRATION
   Future: map real subscription-service results to these visual states.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   SubscriptionViewState.

10. FUTURE API ENDPOINTS
    Not specified.

11. DATABASE COLLECTIONS/TABLES
    Not specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    State messages are exposed as readable text.

17. EDGE CASES
    Long error messages.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    UI representation only.

20. LOADING STATE
    Circular progress indicator.

21. EMPTY STATE
    Empty catalog message.

22. OFFLINE BEHAVIOUR
    Offline informational state.

23. SECURITY CONSIDERATIONS
    No sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Stateless widgets.

25. WIDGET TREE OVERVIEW
    Center → icon/progress → title → message → action.

26. COMPLETE TESTING CHECKLIST
    Verify all state variants with large text and screen readers.
*/

import 'package:flutter/material.dart';

enum SubscriptionViewState { ready, loading, empty, error, offline, success }

class SubscriptionStateView extends StatelessWidget {
  const SubscriptionStateView({super.key, required this.state, this.onAction});

  final SubscriptionViewState state;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    if (state == SubscriptionViewState.loading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
        ),
      );
    }

    final configuration = switch (state) {
      SubscriptionViewState.empty => (
        Icons.inbox_rounded,
        'No plans available',
        'There are currently no subscription plans to display.',
        'Refresh',
      ),
      SubscriptionViewState.error => (
        Icons.error_outline_rounded,
        'Something went wrong',
        'The subscription catalog could not be displayed.',
        'Retry',
      ),
      SubscriptionViewState.offline => (
        Icons.cloud_off_rounded,
        'You are offline',
        'This screen is showing local subscription information only.',
        'Continue',
      ),
      SubscriptionViewState.success => (
        Icons.check_circle_outline_rounded,
        'Subscription updated',
        'Your local preview reflects the selected subscription.',
        'Done',
      ),
      SubscriptionViewState.ready => (
        Icons.info_outline_rounded,
        'Subscription information',
        'Choose a plan to preview its benefits.',
        'Continue',
      ),
      SubscriptionViewState.loading => (
        Icons.hourglass_empty_rounded,
        'Loading',
        'Preparing subscription information.',
        'Continue',
      ),
    };

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                configuration.$1,
                size: 48,
                color: colors.primary,
                semanticLabel: configuration.$2,
              ),
              const SizedBox(height: 16),
              Text(
                configuration.$2,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                configuration.$3,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
              if (onAction != null) ...[
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: onAction,
                  child: Text(configuration.$4),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
