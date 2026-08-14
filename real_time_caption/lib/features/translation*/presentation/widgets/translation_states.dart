/*
1. PAGE NAME
   Translation States

2. PURPOSE
   Provides empty, processing, error, and offline UI representations.

3. DESCRIPTION
   Keeps state-specific presentation separate from the primary Translation page.

4. UI SECTIONS
   Empty prompt, processing indicator, error message, and offline message.

5. NAVIGATION FLOW
   TranslationPage → TranslationStates.

6. DYNAMIC COMPONENTS
   Current TranslationEntity status.

7. FUTURE BACKEND INTEGRATION
   Future: processing and failure states will reflect the project's
   translation pipeline and online/offline runtime state.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   TranslationEntity.

10. FUTURE API ENDPOINTS
    Not specified by source documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified by source documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    translate, cloud_off, error, and progress indicators.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    AnimatedSwitcher for state changes.

16. ACCESSIBILITY
    State messages use visible text and semantic live-region-style labels.

17. EDGE CASES
    Null result and unknown state.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    Local presentation only.

20. LOADING STATE
    CircularProgressIndicator.

21. EMPTY STATE
    Initial translation prompt.

22. OFFLINE BEHAVIOUR
    Explicit offline status messaging.

23. SECURITY CONSIDERATIONS
    No network state is actually detected.

24. PERFORMANCE OPTIMIZATIONS
    Small stateless widget.

25. WIDGET TREE OVERVIEW
    AnimatedSwitcher → Card → icon + message.

26. COMPLETE TESTING CHECKLIST
    Verify each state, accessibility, dark mode, and large text.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/translation_entity.dart';

class TranslationStates extends StatelessWidget {
  const TranslationStates({
    super.key,
    required this.translation,
    required this.isProcessing,
  });

  final TranslationEntity? translation;
  final bool isProcessing;

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (isProcessing) {
      child = const _StateMessage(
        key: ValueKey('processing'),
        icon: Icons.sync_rounded,
        title: 'Preparing your translation',
        message: 'Your message is being processed locally for this preview.',
        showProgress: true,
      );
    } else if (translation == null) {
      child = const _StateMessage(
        key: ValueKey('empty'),
        icon: Icons.forum_outlined,
        title: 'Your translation will appear here',
        message:
            'Choose a language pair, enter a message, and select Translate.',
      );
    } else if (translation!.status == TranslationStatus.offline) {
      child = const _StateMessage(
        key: ValueKey('offline'),
        icon: Icons.cloud_off_rounded,
        title: 'Offline mode',
        message:
            'Connectivity is represented locally in this UI preview. No network service is active.',
      );
    } else if (translation!.status == TranslationStatus.error) {
      child = const _StateMessage(
        key: ValueKey('error'),
        icon: Icons.error_outline_rounded,
        title: 'We could not create this preview',
        message:
            'The selected language pair does not have a local demonstration result.',
      );
    } else {
      child = const SizedBox.shrink(
        key: ValueKey('success'),
      );
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 240),
      child: child,
    );
  }
}

class _StateMessage extends StatelessWidget {
  const _StateMessage({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.showProgress = false,
  });

  final IconData icon;
  final String title;
  final String message;
  final bool showProgress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      liveRegion: true,
      label: '$title. $message',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: showProgress
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2.5),
                      )
                    : Icon(
                        icon,
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      message,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}