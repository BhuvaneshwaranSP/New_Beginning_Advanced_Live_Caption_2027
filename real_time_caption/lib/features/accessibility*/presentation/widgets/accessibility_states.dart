/*
1. PAGE NAME
   Accessibility States

2. PURPOSE
   Provides local loading, error, empty, and success-state representations.

3. DESCRIPTION
   Keeps state feedback visually consistent without implementing real
   connectivity or service calls.

4. UI SECTIONS
   Loading, error/retry, empty, and ready feedback.

5. NAVIGATION FLOW
   AccessibilityPage → state widget.

6. DYNAMIC COMPONENTS
   State-specific message and retry action.

7. FUTURE BACKEND INTEGRATION
   Future: map real preference-service failures to this error state.

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
    check_circle, error_outline, accessibility.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    Lightweight AnimatedSwitcher.

16. ACCESSIBILITY
    State messages use semantic live-region-like labels.

17. EDGE CASES
    Error state must remain readable with large text.

18. VALIDATION RULES
    Retry callback must always be valid.

19. ERROR HANDLING
    Error state exposes retry callback.

20. LOADING STATE
    Circular progress indicator and explanatory text.

21. EMPTY STATE
    Friendly empty representation.

22. OFFLINE BEHAVIOUR
    The local UI does not depend on connectivity.

23. SECURITY CONSIDERATIONS
    No sensitive information in errors.

24. PERFORMANCE OPTIMIZATIONS
    Small stateless widgets.

25. WIDGET TREE OVERVIEW
    AnimatedSwitcher → state panel.

26. COMPLETE TESTING CHECKLIST
    Test loading, error, empty, ready, retry, semantics, and large text.
*/

import 'package:flutter/material.dart';

enum AccessibilityViewState { ready, loading, error, empty }

class AccessibilityStates extends StatelessWidget {
  const AccessibilityStates({
    super.key,
    required this.state,
    required this.onRetry,
  });

  final AccessibilityViewState state;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 180),
      child: switch (state) {
        AccessibilityViewState.ready => const SizedBox.shrink(),
        AccessibilityViewState.loading => const _StatePanel(
          key: ValueKey('loading'),
          icon: Icons.sync,
          title: 'Preparing accessibility settings',
          message: 'Your local accessibility controls are being prepared.',
        ),
        AccessibilityViewState.error => _StatePanel(
          key: const ValueKey('error'),
          icon: Icons.error_outline,
          title: 'Settings could not be prepared',
          message: 'The local preview state needs to be reset.',
          actionLabel: 'Try again',
          onAction: onRetry,
        ),
        AccessibilityViewState.empty => const _StatePanel(
          key: ValueKey('empty'),
          icon: Icons.accessibility_new,
          title: 'No accessibility settings',
          message: 'Accessibility options will appear here when available.',
        ),
      },
    );
  }
}

class _StatePanel extends StatelessWidget {
  const _StatePanel({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      container: true,
      label: '$title. $message',
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(icon, size: 34, color: theme.colorScheme.primary),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                message,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              if (actionLabel != null && onAction != null) ...[
                const SizedBox(height: 14),
                FilledButton.tonal(
                  onPressed: onAction,
                  child: Text(actionLabel!),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
