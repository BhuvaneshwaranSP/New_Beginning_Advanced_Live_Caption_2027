/*
1. PAGE NAME
   Chat States

2. PURPOSE
   Provides reusable loading, empty, error, and offline UI for Chat.

3. DESCRIPTION
   Keeps state presentations consistent and accessible.

4. UI SECTIONS
   State icon, title, description, and optional retry action.

5. NAVIGATION FLOW
   ChatPage → ChatStates.

6. DYNAMIC COMPONENTS
   State-specific content.

7. FUTURE BACKEND INTEGRATION
   Future: map real chat-session, translation, and connectivity results into
   these presentation states.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   ChatViewState.

10. FUTURE API ENDPOINTS
    Not specified in supplied documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified in supplied documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Text and buttons are exposed normally to assistive technologies.

17. EDGE CASES
    Small screens and large accessibility text.

18. VALIDATION RULES
    Retry callback is optional.

19. ERROR HANDLING
    Error and retry state is explicitly represented.

20. LOADING STATE
    Circular progress indicator.

21. EMPTY STATE
    Informative empty conversation state.

22. OFFLINE BEHAVIOUR
    Explicit offline/reconnecting representation.

23. SECURITY CONSIDERATIONS
    No service calls.

24. PERFORMANCE OPTIMIZATIONS
    Stateless reusable widgets.

25. WIDGET TREE OVERVIEW
    Center → icon → title → description → action.

26. COMPLETE TESTING CHECKLIST
    Test every state with dark mode, large text, narrow layouts, and semantics.
*/

import 'package:flutter/material.dart';

class ChatLoadingState extends StatelessWidget {
  const ChatLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class ChatEmptyState extends StatelessWidget {
  const ChatEmptyState({super.key, required this.onStartPressed});

  final VoidCallback onStartPressed;

  @override
  Widget build(BuildContext context) {
    return _ChatStateCard(
      icon: Icons.forum_outlined,
      title: 'Your conversation starts here',
      description:
          'Translated messages and spoken conversation will appear in this space.',
      actionLabel: 'Start conversation',
      onActionPressed: onStartPressed,
    );
  }
}

class ChatErrorState extends StatelessWidget {
  const ChatErrorState({super.key, required this.onRetryPressed});

  final VoidCallback onRetryPressed;

  @override
  Widget build(BuildContext context) {
    return _ChatStateCard(
      icon: Icons.error_outline_rounded,
      title: 'Something went wrong',
      description: 'The conversation could not be prepared. Please try again.',
      actionLabel: 'Retry',
      onActionPressed: onRetryPressed,
    );
  }
}

class ChatOfflineState extends StatelessWidget {
  const ChatOfflineState({super.key, required this.onRetryPressed});

  final VoidCallback onRetryPressed;

  @override
  Widget build(BuildContext context) {
    return _ChatStateCard(
      icon: Icons.cloud_off_rounded,
      title: 'You are offline',
      description:
          'Previously available conversation content can remain visible while the connection is unavailable.',
      actionLabel: 'Check again',
      onActionPressed: onRetryPressed,
    );
  }
}

class _ChatStateCard extends StatelessWidget {
  const _ChatStateCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.onActionPressed,
  });

  final IconData icon;
  final String title;
  final String description;
  final String actionLabel;
  final VoidCallback onActionPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: colorScheme.onSecondaryContainer,
                ),
              ),
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
                description,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.tonal(
                onPressed: onActionPressed,
                child: Text(actionLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
