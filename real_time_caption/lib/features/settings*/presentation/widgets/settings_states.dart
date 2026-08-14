/*
1. PAGE NAME
   Settings States

2. PURPOSE
   Provides reusable local loading, empty, error, and offline UI states.

3. DESCRIPTION
   These states represent UI conditions without implementing real connectivity
   or backend functionality.

4. UI SECTIONS
   Loading, empty, error, and offline status representations.

5. NAVIGATION FLOW
   SettingsPage → SettingsState widgets.

6. DYNAMIC COMPONENTS
   Loading indicator, messages, and retry callback.

7. FUTURE BACKEND INTEGRATION
   Future: map repository loading and failure states into these presentation
   states when real settings data becomes available.

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
    Material 3 color scheme.

15. ANIMATIONS
    Progress indicator and implicit visibility handled by Flutter.

16. ACCESSIBILITY
    State messages are readable by screen readers.

17. EDGE CASES
    Long messages and narrow layouts.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    Presentation-only error representation.

20. LOADING STATE
    SettingsLoadingState.

21. EMPTY STATE
    SettingsEmptyState.

22. OFFLINE BEHAVIOUR
    SettingsOfflineBanner.

23. SECURITY CONSIDERATIONS
    No sensitive data.

24. PERFORMANCE OPTIMIZATIONS
    Lightweight stateless widgets.

25. WIDGET TREE OVERVIEW
    State widget → icon → message → optional action.

26. COMPLETE TESTING CHECKLIST
    Verify each state in light/dark themes and large text.
*/

import 'package:flutter/material.dart';

class SettingsLoadingState extends StatelessWidget {
  const SettingsLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              'Preparing your settings',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsEmptyState extends StatelessWidget {
  const SettingsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.tune_rounded,
              size: 48,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'No settings available',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              'Settings will appear here when they are available.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsErrorState extends StatelessWidget {
  const SettingsErrorState({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Settings could not be displayed',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              'Please try again.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsOfflineBanner extends StatelessWidget {
  const SettingsOfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          Icon(
            Icons.cloud_off_rounded,
            size: 20,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Offline preference preview — no network service is connected.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
