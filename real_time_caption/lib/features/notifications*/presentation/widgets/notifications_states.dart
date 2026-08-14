/*
1. PAGE NAME
   Notifications States

2. PURPOSE
   Provides reusable loading, empty, error, and offline UI states.

3. DESCRIPTION
   Keeps non-success notification states separate from the notification list.

4. UI SECTIONS
   Loading indicator, empty illustration/icon, error retry action, and offline
   message/action.

5. NAVIGATION FLOW
   NotificationsPage → appropriate state widget.

6. DYNAMIC COMPONENTS
   Error message and retry callbacks.

7. FUTURE BACKEND INTEGRATION
   Retry can later trigger the supported notification data refresh operation.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   None.

10. FUTURE API ENDPOINTS
    None defined.

11. DATABASE COLLECTIONS/TABLES
    None defined.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material state icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    None required.

16. ACCESSIBILITY
    Text-based state explanations and accessible buttons.

17. EDGE CASES
    Long error messages and large text.

18. VALIDATION RULES
    Retry callbacks must be supplied by the parent.

19. ERROR HANDLING
    Error state displays a retry action.

20. LOADING STATE
    CircularProgressIndicator.

21. EMPTY STATE
    Dedicated empty notification message.

22. OFFLINE BEHAVIOUR
    Dedicated offline message.

23. SECURITY CONSIDERATIONS
    No sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Stateless reusable widgets.

25. WIDGET TREE OVERVIEW
    State widget
      → Center
         → ConstrainedBox
            → Column
               → Icon
               → title
               → message
               → optional action.

26. COMPLETE TESTING CHECKLIST
    Loading, empty, error, retry, offline, long messages, large text,
    screen reader, dark mode, narrow width, and touch targets.
*/

import 'package:flutter/material.dart';

class NotificationsLoadingState extends StatelessWidget {
  const NotificationsLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class NotificationsEmptyState extends StatelessWidget {
  const NotificationsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const _NotificationsMessageState(
      icon: Icons.notifications_none_rounded,
      title: 'You are all caught up',
      message:
          'New session, call, chat, and translation updates will appear here.',
    );
  }
}

class NotificationsErrorState extends StatelessWidget {
  const NotificationsErrorState({
    super.key,
    required this.onRetry,
    required this.message,
  });

  final VoidCallback onRetry;
  final String message;

  @override
  Widget build(BuildContext context) {
    return _NotificationsMessageState(
      icon: Icons.error_outline_rounded,
      title: 'Something went wrong',
      message: message,
      action: FilledButton.icon(
        onPressed: onRetry,
        icon: const Icon(Icons.refresh_rounded),
        label: const Text('Retry'),
      ),
    );
  }
}

class NotificationsOfflineState extends StatelessWidget {
  const NotificationsOfflineState({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return _NotificationsMessageState(
      icon: Icons.wifi_off_rounded,
      title: 'You are offline',
      message:
          'Previously available notification information can be shown when local data is available.',
      action: OutlinedButton.icon(
        onPressed: onRetry,
        icon: const Icon(Icons.refresh_rounded),
        label: const Text('Check again'),
      ),
    );
  }
}

class _NotificationsMessageState extends StatelessWidget {
  const _NotificationsMessageState({
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
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 56, color: theme.colorScheme.primary),
              const SizedBox(height: 20),
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
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.45,
                ),
              ),
              if (action != null) ...[const SizedBox(height: 20), action!],
            ],
          ),
        ),
      ),
    );
  }
}
