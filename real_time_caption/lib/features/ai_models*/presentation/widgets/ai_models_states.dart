/*
1. PAGE NAME
   AI Models States

2. PURPOSE
   Provides reusable loading, error, empty, and offline representations for
   the AI Models screen.

3. DESCRIPTION
   Keeps state-specific UI separate from the main page layout.

4. UI SECTIONS
   Loading skeletons, error retry panel, empty-search panel, and offline panel.

5. NAVIGATION FLOW
   AiModelsPage → state widget when the corresponding local state is active.

6. DYNAMIC COMPONENTS
   Error message and retry callback.

7. FUTURE BACKEND INTEGRATION
   Future model availability failures can map into these same UI states.

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
   Material Icons.

14. THEME COLORS
   Active Material 3 ColorScheme.

15. ANIMATIONS
   Lightweight opacity transition for loading placeholders.

16. ACCESSIBILITY
   State titles and explanations use normal semantic text.

17. EDGE CASES
   Long error messages are constrained by flexible layout.

18. VALIDATION RULES
   None.

19. ERROR HANDLING
   Retry callback is exposed to the parent.

20. LOADING STATE
   AiModelsLoadingState.

21. EMPTY STATE
   AiModelsEmptyState.

22. OFFLINE BEHAVIOUR
   AiModelsOfflineState.

23. SECURITY CONSIDERATIONS
   Error text must not contain credentials or sensitive backend information.

24. PERFORMANCE OPTIMIZATIONS
   Small reusable stateless widgets.

25. WIDGET TREE OVERVIEW
   State card → icon → title → message → optional action.

26. COMPLETE TESTING CHECKLIST
   Verify all states in light/dark themes, large text, narrow widths, and
   screen-reader navigation.
*/

import 'package:flutter/material.dart';

class AiModelsLoadingState extends StatelessWidget {
  const AiModelsLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _LoadingCard(index: index),
        ),
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return AnimatedOpacity(
      opacity: 0.55 + ((index % 2) * 0.15),
      duration: const Duration(milliseconds: 500),
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}

class AiModelsErrorState extends StatelessWidget {
  const AiModelsErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return _StateCard(
      icon: Icons.cloud_off_outlined,
      title: 'Models could not be loaded',
      message: message,
      action: FilledButton.icon(
        onPressed: onRetry,
        icon: const Icon(Icons.refresh),
        label: const Text('Retry'),
      ),
    );
  }
}

class AiModelsEmptyState extends StatelessWidget {
  const AiModelsEmptyState({
    super.key,
    required this.isFiltered,
    required this.onClearFilters,
  });

  final bool isFiltered;
  final VoidCallback onClearFilters;

  @override
  Widget build(BuildContext context) {
    return _StateCard(
      icon: isFiltered ? Icons.search_off : Icons.auto_awesome_mosaic_outlined,
      title: isFiltered ? 'No models found' : 'No AI models available',
      message: isFiltered
          ? 'Try another model name, language, or category.'
          : 'The AI model catalog is currently empty.',
      action: isFiltered
          ? OutlinedButton.icon(
              onPressed: onClearFilters,
              icon: const Icon(Icons.clear_all),
              label: const Text('Clear filters'),
            )
          : null,
    );
  }
}

class AiModelsOfflineState extends StatelessWidget {
  const AiModelsOfflineState({super.key});

  @override
  Widget build(BuildContext context) {
    return _StateCard(
      icon: Icons.cloud_off_outlined,
      title: 'Offline model availability',
      message:
          'Some LinguaLive components can be prepared for offline inference. '
          'This screen is currently showing local demonstration data only.',
      action: null,
    );
  }
}

class _StateCard extends StatelessWidget {
  const _StateCard({
    required this.icon,
    required this.title,
    required this.message,
    required this.action,
  });

  final IconData icon;
  final String title;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        children: [
          Icon(icon, size: 42, color: scheme.primary, semanticLabel: title),
          const SizedBox(height: 14),
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
              color: scheme.onSurfaceVariant,
              height: 1.45,
            ),
          ),
          if (action != null) ...[const SizedBox(height: 18), action!],
        ],
      ),
    );
  }
}
