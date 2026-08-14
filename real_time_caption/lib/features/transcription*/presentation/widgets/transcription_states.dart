/*
1. PAGE NAME
   Transcription States

2. PURPOSE
   Provides reusable loading, empty, error, and offline UI states.

3. DESCRIPTION
   Keeps non-success states visually consistent across the transcription page.

4. UI SECTIONS
   State icon, title, description, optional action.

5. NAVIGATION FLOW
   TranscriptionPage → state widget.

6. DYNAMIC COMPONENTS
   State title, description, icon, and retry action.

7. FUTURE BACKEND INTEGRATION
   Future: map actual streaming/service failures into these presentation
   states without coupling the widgets to backend implementation details.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   None.

10. FUTURE API ENDPOINTS
    Not defined.

11. DATABASE COLLECTIONS/TABLES
    Not defined.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    None required.

16. ACCESSIBILITY
    State information is text-based and semantic.

17. EDGE CASES
    Very large accessibility text.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    Visual error state with retry callback.

20. LOADING STATE
    CircularProgressIndicator.

21. EMPTY STATE
    Informative empty message.

22. OFFLINE BEHAVIOUR
    Explicit offline message.

23. SECURITY CONSIDERATIONS
    No data exposure.

24. PERFORMANCE OPTIMIZATIONS
    Stateless widgets.

25. WIDGET TREE OVERVIEW
    Center → Icon → Text → optional Button.

26. COMPLETE TESTING CHECKLIST
    Test each state with large text and dark theme.
*/

import 'package:flutter/material.dart';

class TranscriptionLoadingState extends StatelessWidget {
  const TranscriptionLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const _StateContent(
      icon: Icons.graphic_eq_rounded,
      title: 'Preparing transcription',
      description: 'Loading the local conversation preview.',
      showProgress: true,
    );
  }
}

class TranscriptionEmptyState extends StatelessWidget {
  const TranscriptionEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const _StateContent(
      icon: Icons.notes_rounded,
      title: 'No transcript yet',
      description: 'Start a conversation to see speech converted into text.',
    );
  }
}

class TranscriptionOfflineState extends StatelessWidget {
  const TranscriptionOfflineState({super.key});

  @override
  Widget build(BuildContext context) {
    return const _StateContent(
      icon: Icons.cloud_off_rounded,
      title: 'Offline preview',
      description:
          'Live transcription is unavailable in this preview, but existing text remains visible.',
    );
  }
}

class TranscriptionErrorState extends StatelessWidget {
  const TranscriptionErrorState({
    super.key,
    required this.onRetry,
  });

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return _StateContent(
      icon: Icons.error_outline_rounded,
      title: 'Transcription unavailable',
      description: 'Something went wrong while preparing the local preview.',
      action: FilledButton.icon(
        onPressed: onRetry,
        icon: const Icon(Icons.refresh_rounded),
        label: const Text('Retry'),
      ),
    );
  }
}

class _StateContent extends StatelessWidget {
  const _StateContent({
    required this.icon,
    required this.title,
    required this.description,
    this.showProgress = false,
    this.action,
  });

  final IconData icon;
  final String title;
  final String description;
  final bool showProgress;
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 48,
                color: theme.colorScheme.primary,
              ),
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
                description,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
              if (showProgress) ...[
                const SizedBox(height: 22),
                const SizedBox(
                  width: 26,
                  height: 26,
                  child: CircularProgressIndicator(strokeWidth: 2.5),
                ),
              ],
              if (action != null) ...[
                const SizedBox(height: 22),
                action!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}