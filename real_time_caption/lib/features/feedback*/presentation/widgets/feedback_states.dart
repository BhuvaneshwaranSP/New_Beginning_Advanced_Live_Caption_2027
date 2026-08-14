/*
1. PAGE NAME
   Feedback States

2. PURPOSE
   Displays local success, error, and offline feedback states.

3. DESCRIPTION
   Keeps state-specific UI separate from the main form.

4. UI SECTIONS
   Status icon, title, description, action.

5. NAVIGATION FLOW
   Controller state → state widget → retry/reset callback.

6. DYNAMIC COMPONENTS
   State-specific messaging and action.

7. FUTURE BACKEND INTEGRATION
   Future: replace simulated state transitions with real submission results
   from the approved feedback service.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   FeedbackSubmissionState.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material status icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    AnimatedSwitcher.

16. ACCESSIBILITY
    State messages are exposed as normal text and buttons.

17. EDGE CASES
    Retry callback is optional.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    Error state has a retry action.

20. LOADING STATE
    Loading is represented separately by the page's progress indicator.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Dedicated offline state.

23. SECURITY CONSIDERATIONS
    No data transmission.

24. PERFORMANCE OPTIMIZATIONS
    Small stateless widgets.

25. WIDGET TREE OVERVIEW
    AnimatedSwitcher → Card → icon → text → action.

26. COMPLETE TESTING CHECKLIST
    Verify success, error, offline states, semantics, dark mode, and text scaling.
*/

import 'package:flutter/material.dart';

import '../controllers/feedback_controller.dart';

class FeedbackStateView extends StatelessWidget {
  const FeedbackStateView({
    super.key,
    required this.state,
    required this.onAction,
  });

  final FeedbackSubmissionState state;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    late final IconData icon;
    late final String title;
    late final String description;
    late final String actionLabel;

    switch (state) {
      case FeedbackSubmissionState.success:
        icon = Icons.check_circle_rounded;
        title = 'Thank you for sharing';
        description =
            'Your feedback has been captured in this demo experience.';
        actionLabel = 'Send another';
      case FeedbackSubmissionState.error:
        icon = Icons.error_outline_rounded;
        title = 'Feedback needs attention';
        description =
            'Choose a rating, select a category, and add a short message '
            'before submitting.';
        actionLabel = 'Try again';
      case FeedbackSubmissionState.offline:
        icon = Icons.cloud_off_rounded;
        title = 'You appear to be offline';
        description =
            'This demo cannot send feedback while offline. Your current '
            'screen remains available for testing.';
        actionLabel = 'Return to form';
      case FeedbackSubmissionState.idle:
      case FeedbackSubmissionState.loading:
        return const SizedBox.shrink();
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      child: Card(
        key: ValueKey<FeedbackSubmissionState>(state),
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: <Widget>[
              Icon(icon, size: 48, color: theme.colorScheme.primary),
              const SizedBox(height: 16),
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
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.tonal(onPressed: onAction, child: Text(actionLabel)),
            ],
          ),
        ),
      ),
    );
  }
}
