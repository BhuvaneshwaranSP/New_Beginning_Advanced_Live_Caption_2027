/*
1. PAGE NAME
   Transcription Language Pair Card

2. PURPOSE
   Shows the selected source and target languages.

3. DESCRIPTION
   Provides clear language context for the displayed transcription.

4. UI SECTIONS
   Source language, direction indicator, target language.

5. NAVIGATION FLOW
   TranscriptionPage → LanguagePairCard.

6. DYNAMIC COMPONENTS
   Source and target language labels.

7. FUTURE BACKEND INTEGRATION
   Future: bind the selected languages to the transcription pipeline;
   this card communicates the language pair used by speech processing.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   None.

10. FUTURE API ENDPOINTS
    None defined.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    None required.

16. ACCESSIBILITY
    Language labels are rendered as readable text.

17. EDGE CASES
    Long language names.

18. VALIDATION RULES
    Source and target are non-empty dummy values.

19. ERROR HANDLING
    Not applicable.

20. LOADING STATE
    Parent controls loading state.

21. EMPTY STATE
    Parent controls empty state.

22. OFFLINE BEHAVIOUR
    Language pair remains visible.

23. SECURITY CONSIDERATIONS
    No sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Stateless widget.

25. WIDGET TREE OVERVIEW
    Card → two language columns → direction icon.

26. COMPLETE TESTING CHECKLIST
    Verify narrow phone, tablet, landscape, dark mode, and large text.
*/

import 'package:flutter/material.dart';

class LanguagePairCard extends StatelessWidget {
  const LanguagePairCard({
    super.key,
    required this.sourceLanguage,
    required this.targetLanguage,
  });

  final String sourceLanguage;
  final String targetLanguage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Expanded(
              child: _LanguageItem(
                label: 'Speaking',
                language: sourceLanguage,
                icon: Icons.graphic_eq_rounded,
              ),
            ),
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward_rounded,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            Expanded(
              child: _LanguageItem(
                label: 'Translated',
                language: targetLanguage,
                icon: Icons.translate_rounded,
                alignment: CrossAxisAlignment.end,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageItem extends StatelessWidget {
  const _LanguageItem({
    required this.label,
    required this.language,
    required this.icon,
    this.alignment = CrossAxisAlignment.start,
  });

  final String label;
  final String language;
  final IconData icon;
  final CrossAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Icon(icon, size: 19),
        const SizedBox(height: 7),
        Text(
          label,
          style: theme.textTheme.labelMedium,
        ),
        const SizedBox(height: 2),
        Text(
          language,
          textAlign: alignment == CrossAxisAlignment.end
              ? TextAlign.end
              : TextAlign.start,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}