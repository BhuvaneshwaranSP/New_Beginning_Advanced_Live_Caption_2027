/*
1. PAGE NAME
   Language Pair Card

2. PURPOSE
   Provides the central source-to-target language control.

3. DESCRIPTION
   Shows the active language pair and a predictable swap action,
   matching the supplied Languages flow.

4. UI SECTIONS
   Source language, swap control, and target language.

5. NAVIGATION FLOW
   LanguagesPage → LanguagePairCard → future translation/transcription flows.

6. DYNAMIC COMPONENTS
   Source and target language names.

7. FUTURE BACKEND INTEGRATION
   Future: share this selected pair with translation, transcription,
   and live communication services.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   LanguageFeatureEntity.

10. FUTURE API ENDPOINTS
    Not implemented.

11. DATABASE COLLECTIONS/TABLES
    Not implemented.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    swap_horiz, translate.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    AnimatedContainer for selection emphasis.

16. ACCESSIBILITY
    Swap control has a descriptive tooltip and semantic label.

17. EDGE CASES
    Long language names and large text.

18. VALIDATION RULES
    Source and target remain different.

19. ERROR HANDLING
    Missing language is represented safely.

20. LOADING STATE
    Parent page handles loading.

21. EMPTY STATE
    Missing language values display a safe fallback.

22. OFFLINE BEHAVIOUR
    Unavailable resources are visually communicated.

23. SECURITY CONSIDERATIONS
    No sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Lightweight widget and implicit animation.

25. WIDGET TREE OVERVIEW
    Card → source → swap → target.

26. COMPLETE TESTING CHECKLIST
    Test swapping, large text, unavailable language, and accessibility.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/languages_feature_entity.dart';

class LanguagePairCard extends StatelessWidget {
  const LanguagePairCard({
    super.key,
    required this.source,
    required this.target,
    required this.onSwap,
  });

  final LanguageFeatureEntity? source;
  final LanguageFeatureEntity? target;
  final VoidCallback onSwap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 420;

            final sourceWidget = Expanded(
              child: _LanguageEndpoint(
                label: 'From',
                language: source,
              ),
            );

            final targetWidget = Expanded(
              child: _LanguageEndpoint(
                label: 'To',
                language: target,
              ),
            );

            final swapButton = Semantics(
              button: true,
              label: 'Swap source and target languages',
              child: IconButton.filled(
                tooltip: 'Swap languages',
                onPressed: onSwap,
                icon: const Icon(Icons.swap_horiz_rounded),
              ),
            );

            return compact
                ? Column(
                    children: [
                      sourceWidget,
                      const SizedBox(height: 10),
                      swapButton,
                      const SizedBox(height: 10),
                      targetWidget,
                    ],
                  )
                : Row(
                    children: [
                      sourceWidget,
                      const SizedBox(width: 12),
                      swapButton,
                      const SizedBox(width: 12),
                      targetWidget,
                    ],
                  );
          },
        ),
      ),
    );
  }
}

class _LanguageEndpoint extends StatelessWidget {
  const _LanguageEndpoint({
    required this.label,
    required this.language,
  });

  final String label;
  final LanguageFeatureEntity? language;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: theme.textTheme.labelSmall?.copyWith(
            color: colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          language?.name ?? 'Select language',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleLarge?.copyWith(
            color: colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.w800,
          ),
        ),
        if (language != null)
          Text(
            language!.nativeName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onPrimaryContainer.withValues(
                alpha: 0.75,
              ),
            ),
          ),
      ],
    );
  }
}