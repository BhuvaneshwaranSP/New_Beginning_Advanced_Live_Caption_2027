/*
1. PAGE NAME
   Onboarding States

2. PURPOSE
   Provides reusable local UI representations for onboarding exceptional states.

3. DESCRIPTION
   Contains empty and error/retry presentations without implementing real
   connectivity or backend behavior.

4. UI SECTIONS
   State message and optional action.

5. NAVIGATION FLOW
   Used by the onboarding page when local UI state requires feedback.

6. DYNAMIC COMPONENTS
   Message, icon, and action callback.

7. FUTURE BACKEND INTEGRATION
   Future: map language-service failures into this presentation state when
   supported language configuration becomes remotely loaded.

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
    Icons.language_off_rounded and Icons.refresh_rounded.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Clear state message and labelled retry action.

17. EDGE CASES
    Long error messages.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    Presentation only.

20. LOADING STATE
    Not implemented because no asynchronous source exists.

21. EMPTY STATE
    Included.

22. OFFLINE BEHAVIOUR
    Local data normally prevents an offline failure.

23. SECURITY CONSIDERATIONS
    No sensitive error details are exposed.

24. PERFORMANCE OPTIMIZATIONS
    Stateless widgets.

25. WIDGET TREE OVERVIEW
    Card → Icon → Text → Button.

26. COMPLETE TESTING CHECKLIST
    Verify empty/error layout, accessibility, text scaling, and callbacks.
*/

import 'package:flutter/material.dart';

class OnboardingEmptyState extends StatelessWidget {
  const OnboardingEmptyState({super.key, this.onRetry});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final ThemeData _ = Theme.of(context);

    return _OnboardingStateCard(
      icon: Icons.language_rounded,
      title: 'No languages available',
      message: 'Language choices are not available in this local demo state.',
      actionLabel: 'Try again',
      actionIcon: Icons.refresh_rounded,
      onAction: onRetry,
    );
  }
}

class OnboardingErrorState extends StatelessWidget {
  const OnboardingErrorState({super.key, required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return _OnboardingStateCard(
      icon: Icons.error_outline_rounded,
      title: 'Something went wrong',
      message: message,
      actionLabel: 'Try again',
      actionIcon: Icons.refresh_rounded,
      onAction: onRetry,
    );
  }
}

class _OnboardingStateCard extends StatelessWidget {
  const _OnboardingStateCard({
    required this.icon,
    required this.title,
    required this.message,
    required this.actionLabel,
    required this.actionIcon,
    required this.onAction,
  });

  final IconData icon;
  final String title;
  final String message;
  final String actionLabel;
  final IconData actionIcon;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Icon(icon, size: 32, color: theme.colorScheme.primary),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            if (onAction != null) ...<Widget>[
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: onAction,
                icon: Icon(actionIcon),
                label: Text(actionLabel),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
