/*
1. PAGE NAME
   Voice Clone States

2. PURPOSE
   Provides reusable loading, empty, error, offline, and information states.

3. DESCRIPTION
   Local visual states for robust UI testing.

4. UI SECTIONS
   State icon, title, message, and optional action.

5. NAVIGATION FLOW
   Voice Clone page → state widget.

6. DYNAMIC COMPONENTS
   State-specific copy and callback.

7. FUTURE BACKEND INTEGRATION
   Future service status can map into these presentation states.

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
    Material status icons.

14. THEME COLORS
    ColorScheme.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    State titles and messages are exposed as normal semantic text.

17. EDGE CASES
    Long error messages.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    Error state includes retry callback.

20. LOADING STATE
    CircularProgressIndicator.

21. EMPTY STATE
    Dedicated empty presentation.

22. OFFLINE BEHAVIOUR
    Dedicated offline presentation.

23. SECURITY CONSIDERATIONS
    No sensitive voice data appears in state messages.

24. PERFORMANCE OPTIMIZATIONS
    Stateless widgets.

25. WIDGET TREE OVERVIEW
    Center → icon → title → message → optional action.

26. COMPLETE TESTING CHECKLIST
    Verify every state at small widths, large text, dark mode, and screen readers.
*/

import 'package:flutter/material.dart';

class VoiceCloneLoadingState extends StatelessWidget {
  const VoiceCloneLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const _VoiceCloneStateCard(
      icon: Icons.graphic_eq_rounded,
      title: 'Preparing voice profiles',
      message: 'Loading local demonstration data.',
      child: CircularProgressIndicator(),
    );
  }
}

class VoiceCloneEmptyState extends StatelessWidget {
  const VoiceCloneEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const _VoiceCloneStateCard(
      icon: Icons.record_voice_over_outlined,
      title: 'No voice profiles yet',
      message: 'A voice profile can be added when the supported workflow is integrated.',
    );
  }
}

class VoiceCloneErrorState extends StatelessWidget {
  const VoiceCloneErrorState({
    super.key,
    required this.onRetry,
  });

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return _VoiceCloneStateCard(
      icon: Icons.error_outline_rounded,
      title: 'Something needs attention',
      message: 'The local demonstration state could not be prepared.',
      child: FilledButton.tonal(
        onPressed: onRetry,
        child: const Text('Retry'),
      ),
    );
  }
}

class VoiceCloneOfflineState extends StatelessWidget {
  const VoiceCloneOfflineState({super.key});

  @override
  Widget build(BuildContext context) {
    return const _VoiceCloneStateCard(
      icon: Icons.cloud_off_rounded,
      title: 'Offline-ready view',
      message: 'This screen does not connect to a service. Real voice processing is not available in this UI-only build.',
    );
  }
}

class _VoiceCloneStateCard extends StatelessWidget {
  const _VoiceCloneStateCard({
    required this.icon,
    required this.title,
    required this.message,
    this.child,
  });

  final IconData icon;
  final String title;
  final String message;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 42,
            color: colors.primary,
          ),
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
              color: colors.onSurfaceVariant,
              height: 1.45,
            ),
          ),
          if (child != null) ...[
            const SizedBox(height: 18),
            child!,
          ],
        ],
      ),
    );
  }
}