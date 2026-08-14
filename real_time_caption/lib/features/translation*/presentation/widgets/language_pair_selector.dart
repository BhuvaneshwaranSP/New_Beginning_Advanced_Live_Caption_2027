/*
1. PAGE NAME
   Language Pair Selector

2. PURPOSE
   Allows the user to select source and target languages.

3. DESCRIPTION
   Responsive Material 3 language controls with a central swap action.

4. UI SECTIONS
   Source language, swap control, target language.

5. NAVIGATION FLOW
   TranslationPage → LanguagePairSelector → controller state.

6. DYNAMIC COMPONENTS
   Language names and selected language codes.

7. FUTURE BACKEND INTEGRATION
   Future: populate available languages from the project's supported
   multilingual model configuration rather than this local dummy list.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   TranslationLanguageDummy.

10. FUTURE API ENDPOINTS
    Not specified by source documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified by source documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Icons.swap_horiz_rounded.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    Lightweight AnimatedSwitcher for swap icon feedback.

16. ACCESSIBILITY
    Explicit semantic labels for selectors and swap action.

17. EDGE CASES
    Long language names and narrow screens.

18. VALIDATION RULES
    Source and target languages should normally differ.

19. ERROR HANDLING
    None beyond Flutter dropdown behavior.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Language selection remains locally available.

23. SECURITY CONSIDERATIONS
    No sensitive data.

24. PERFORMANCE OPTIMIZATIONS
    Small immutable language collection.

25. WIDGET TREE OVERVIEW
    Responsive Row/Column → DropdownButtonFormField + swap button.

26. COMPLETE TESTING CHECKLIST
    Verify selection, swap, accessibility, dark mode, and narrow-width behavior.
*/

import 'package:flutter/material.dart';

import '../../data/dummy/translation_dummy_data.dart';

class LanguagePairSelector extends StatelessWidget {
  const LanguagePairSelector({
    super.key,
    required this.sourceLanguageCode,
    required this.targetLanguageCode,
    required this.onSourceChanged,
    required this.onTargetChanged,
    required this.onSwap,
  });

  final String sourceLanguageCode;
  final String targetLanguageCode;
  final ValueChanged<String?> onSourceChanged;
  final ValueChanged<String?> onTargetChanged;
  final VoidCallback onSwap;

  @override
  Widget build(BuildContext context) {
    final _ = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 520;

        final source = _languageField(
          context,
          label: 'From',
          value: sourceLanguageCode,
          onChanged: onSourceChanged,
          excludeCode: targetLanguageCode,
        );

        final target = _languageField(
          context,
          label: 'To',
          value: targetLanguageCode,
          onChanged: onTargetChanged,
          excludeCode: sourceLanguageCode,
        );

        final swap = Semantics(
          button: true,
          label: 'Swap source and target languages',
          child: IconButton.filledTonal(
            tooltip: 'Swap languages',
            onPressed: onSwap,
            icon: const Icon(Icons.swap_horiz_rounded),
          ),
        );

        if (isCompact) {
          return Column(
            children: [
              source,
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: target),
                  const SizedBox(width: 10),
                  swap,
                ],
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: source),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: swap,
            ),
            Expanded(child: target),
          ],
        );
      },
    );
  }

  Widget _languageField(
    BuildContext context, {
    required String label,
    required String value,
    required ValueChanged<String?> onChanged,
    required String excludeCode,
  }) {
    final theme = Theme.of(context);

    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          Icons.language_rounded,
          color: theme.colorScheme.primary,
        ),
      ),
      items: translationLanguages
          .where((language) => language.code != excludeCode)
          .map(
            (language) => DropdownMenuItem<String>(
              value: language.code,
              child: Text(
                '${language.name} · ${language.nativeName}',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
