/*
1. PAGE NAME
   Analytics States

2. PURPOSE
   Provides local UI representations for Analytics loading, empty,
   error, and offline states.

3. DESCRIPTION
   Keeps state-specific presentation separate from the main page.

4. UI SECTIONS
   Loading skeleton, empty state, error/retry state, offline state.

5. NAVIGATION FLOW
   AnalyticsPage → AnalyticsStates widgets.

6. DYNAMIC COMPONENTS
   Retry callback and state-specific messaging.

7. FUTURE BACKEND INTEGRATION
   Retry will later trigger the real analytics repository request.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   None.

10. FUTURE API ENDPOINTS
    None defined.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    Loading shimmer is intentionally avoided to keep the UI lightweight.

16. ACCESSIBILITY
    State messages are exposed as readable text.

17. EDGE CASES
    Error retry, offline representation, and empty analytics.

18. VALIDATION RULES
    Retry callback must always be supplied.

19. ERROR HANDLING
    Error state exposes a retry action.

20. LOADING STATE
    AnalyticsLoadingState.

21. EMPTY STATE
    AnalyticsEmptyState.

22. OFFLINE BEHAVIOUR
    AnalyticsOfflineState.

23. SECURITY CONSIDERATIONS
    No sensitive error details are shown.

24. PERFORMANCE OPTIMIZATIONS
    Simple const-capable widgets.

25. WIDGET TREE OVERVIEW
    Center → icon/text/action.

26. COMPLETE TESTING CHECKLIST
    Verify every state, retry callback, semantics, dark mode,
    large text, and responsive spacing.
*/

import 'package:flutter/material.dart';

class AnalyticsLoadingState extends StatelessWidget {
  const AnalyticsLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 18),
            Text('Preparing your analytics…'),
          ],
        ),
      ),
    );
  }
}

class AnalyticsEmptyState extends StatelessWidget {
  const AnalyticsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const _AnalyticsStateMessage(
      icon: Icons.insights_outlined,
      title: 'No analytics yet',
      message:
          'Complete a few multilingual conversations to see your activity here.',
    );
  }
}

class AnalyticsErrorState extends StatelessWidget {
  const AnalyticsErrorState({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return _AnalyticsStateMessage(
      icon: Icons.cloud_off_rounded,
      title: 'Analytics unavailable',
      message: 'The analytics view could not be prepared. You can try again.',
      action: FilledButton.icon(
        onPressed: onRetry,
        icon: const Icon(Icons.refresh_rounded),
        label: const Text('Try again'),
      ),
    );
  }
}

class AnalyticsOfflineState extends StatelessWidget {
  const AnalyticsOfflineState({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return _AnalyticsStateMessage(
      icon: Icons.cloud_off_outlined,
      title: 'Offline analytics',
      message:
          'Live analytics are currently unavailable. Previously prepared local information can be shown when available.',
      action: OutlinedButton(
        onPressed: onRetry,
        child: const Text('Check again'),
      ),
    );
  }
}

class _AnalyticsStateMessage extends StatelessWidget {
  const _AnalyticsStateMessage({
    required this.icon,
    required this.title,
    required this.message,
    this.action,
  });

  final IconData icon;
  final String title;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, color: theme.colorScheme.primary),
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
                message,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
              if (action != null) ...[const SizedBox(height: 20), action!],
            ],
          ),
        ),
      ),
    );
  }
}
