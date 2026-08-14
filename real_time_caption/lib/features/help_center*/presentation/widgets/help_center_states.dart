/*
1. PAGE NAME
   Help Center States

2. PURPOSE
   Provides loading, empty, error, and offline UI representations.

3. DESCRIPTION
   Keeps screen-state presentation reusable and consistent.

4. UI SECTIONS
   Loading indicator, empty search, error retry, and offline content.

5. NAVIGATION FLOW
   Controller state → Help Center state widget.

6. DYNAMIC COMPONENTS
   State-specific messaging and retry action.

7. FUTURE BACKEND INTEGRATION
   Future: map real Help Center loading/error/offline results into these states
   when the supported content source is integrated.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   None.

10. FUTURE API ENDPOINTS
    Not specified.

11. DATABASE COLLECTIONS/TABLES
    Not specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Application ColorScheme.

15. ANIMATIONS
    CircularProgressIndicator.

16. ACCESSIBILITY
    State messages are readable text with semantic buttons.

17. EDGE CASES
    Empty search and offline content are explicitly represented.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    Retry callback is supplied by the controller.

20. LOADING STATE
    Circular progress indicator.

21. EMPTY STATE
    Search-specific empty state.

22. OFFLINE BEHAVIOUR
    Offline explanation with local-content action.

23. SECURITY CONSIDERATIONS
    No sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Small stateless widgets.

25. WIDGET TREE OVERVIEW
    Center → icon/progress → message → optional action.

26. COMPLETE TESTING CHECKLIST
    Verify every state, semantic labels, dark mode, large text, and retry.
*/

import 'package:flutter/material.dart';

class HelpCenterLoadingState extends StatelessWidget {
  const HelpCenterLoadingState({super.key});

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

class HelpCenterEmptyState extends StatelessWidget {
  const HelpCenterEmptyState({
    super.key,
    required this.query,
    required this.onClear,
  });

  final String query;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return _HelpCenterStateCard(
      icon: Icons.search_off_rounded,
      title: 'No help topics found',
      message: 'Try a different search such as “translation” or “captions”.',
      actionLabel: query.isEmpty ? null : 'Clear search',
      onAction: query.isEmpty ? null : onClear,
      theme: theme,
    );
  }
}

class HelpCenterErrorState extends StatelessWidget {
  const HelpCenterErrorState({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return _HelpCenterStateCard(
      icon: Icons.error_outline_rounded,
      title: 'Help content could not be loaded',
      message: 'The current UI is showing a local error state for testing.',
      actionLabel: 'Retry',
      onAction: onRetry,
      theme: Theme.of(context),
    );
  }
}

class HelpCenterOfflineState extends StatelessWidget {
  const HelpCenterOfflineState({super.key, required this.onRestore});

  final VoidCallback onRestore;

  @override
  Widget build(BuildContext context) {
    return _HelpCenterStateCard(
      icon: Icons.cloud_off_rounded,
      title: 'You are offline',
      message:
          'Previously available local help content can still be represented in this UI.',
      actionLabel: 'Show local content',
      onAction: onRestore,
      theme: Theme.of(context),
    );
  }
}

class _HelpCenterStateCard extends StatelessWidget {
  const _HelpCenterStateCard({
    required this.icon,
    required this.title,
    required this.message,
    required this.actionLabel,
    required this.onAction,
    required this.theme,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final colorScheme = theme.colorScheme;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 42, color: colorScheme.primary),
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
                message,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.45,
                ),
              ),
              if (actionLabel != null && onAction != null) ...[
                const SizedBox(height: 20),
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
