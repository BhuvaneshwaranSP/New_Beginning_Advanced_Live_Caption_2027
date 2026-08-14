/*
1. PAGE NAME
   Translation Result Card

2. PURPOSE
   Displays the translated result and its contextual status.

3. DESCRIPTION
   Presents source/target information, translated text, and local confidence
   feedback without performing real translation.

4. UI SECTIONS
   Result header, translated text, confidence indicator, and utility actions.

5. NAVIGATION FLOW
   TranslationController → TranslationEntity → TranslationResultCard.

6. DYNAMIC COMPONENTS
   Translated text, confidence, status, and language labels.

7. FUTURE BACKEND INTEGRATION
   Future: display the final output produced by NLLB-200 Distilled followed by
   the project's contextual/grammar correction stage.

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
    Icons.auto_awesome, content_copy, and verified.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    AnimatedSwitcher for result changes.

16. ACCESSIBILITY
    Semantic translation result and status labels.

17. EDGE CASES
    Empty, processing, error, offline, and long translated content.

18. VALIDATION RULES
    Result is displayed only when supplied by the controller.

19. ERROR HANDLING
    Local error presentation.

20. LOADING STATE
    Processing is handled by TranslationStates.

21. EMPTY STATE
    TranslationStates handles absent results.

22. OFFLINE BEHAVIOUR
    Offline status is visually and textually communicated.

23. SECURITY CONSIDERATIONS
    No persistence or network transmission.

24. PERFORMANCE OPTIMIZATIONS
    AnimatedSwitcher only around the changing result content.

25. WIDGET TREE OVERVIEW
    Card → header → result text → confidence → utility row.

26. COMPLETE TESTING CHECKLIST
    Verify long translations, status semantics, dark mode, and large text.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/translation_entity.dart';

class TranslationResultCard extends StatelessWidget {
  const TranslationResultCard({
    super.key,
    required this.translation,
  });

  final TranslationEntity translation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isSuccess = translation.status == TranslationStatus.success;
    final isOffline = translation.status == TranslationStatus.offline;
    final isError = translation.status == TranslationStatus.error;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isSuccess
                      ? Icons.auto_awesome_rounded
                      : Icons.info_outline_rounded,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    isOffline
                        ? 'Offline preview'
                        : isError
                            ? 'Translation unavailable'
                            : 'Translated result',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (isSuccess)
                  Semantics(
                    label:
                        'Translation confidence ${(translation.confidence * 100).round()} percent',
                    child: Chip(
                      avatar: const Icon(
                        Icons.verified_rounded,
                        size: 16,
                      ),
                      label: Text(
                        '${(translation.confidence * 100).round()}%',
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              translation.targetLanguageName,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              child: SelectableText(
                translation.translatedText.isEmpty
                    ? 'No translated text yet.'
                    : translation.translatedText,
                key: ValueKey(translation.translatedText),
                style: theme.textTheme.headlineSmall?.copyWith(
                  height: 1.35,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (isError)
              Text(
                'Try another language pair or a different sentence.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.error,
                ),
              )
            else
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${translation.sourceLanguageName} → ${translation.targetLanguageName}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  if (isSuccess)
                    IconButton(
                      tooltip: 'Copy translation',
                      onPressed: () {},
                      icon: const Icon(Icons.content_copy_rounded),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}