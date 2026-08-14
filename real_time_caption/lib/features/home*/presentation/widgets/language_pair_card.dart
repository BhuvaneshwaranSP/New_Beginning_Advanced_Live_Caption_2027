/*
1. PAGE NAME
   Language Pair Card

2. PURPOSE
   Allows the user to select the source and target languages before starting
   multilingual communication.

3. DESCRIPTION
   This directly represents the first language-selection step in the project
   flow.

4. UI SECTIONS
   Speaking language, swap control, translation language.

5. NAVIGATION FLOW
   Home → Select languages → Start communication.

6. DYNAMIC COMPONENTS
   Source language, target language, available languages.

7. FUTURE BACKEND INTEGRATION
   Future: pass the selected language pair into the live communication
   pipeline; this card defines the language configuration used by that flow.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   LanguageOptionEntity.

10. FUTURE API ENDPOINTS
    None implemented.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    language, swap_horiz.

14. THEME COLORS
    Active Material 3 ColorScheme.

15. ANIMATIONS
    Native Material interaction feedback.

16. ACCESSIBILITY
    Form labels and tooltip for swap.

17. EDGE CASES
    Narrow layouts and long language names.

18. VALIDATION RULES
    Null dropdown values are ignored.

19. ERROR HANDLING
    No external errors.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Not applicable with the supplied dummy languages.

22. OFFLINE BEHAVIOUR
    Language selection remains local.

23. SECURITY CONSIDERATIONS
    No sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Lightweight widgets and bounded layout.

25. WIDGET TREE OVERVIEW
    Card → responsive Row/Column → dropdowns + swap.

26. COMPLETE TESTING CHECKLIST
    Selection, swap, overflow, large text, dark mode, accessibility,
    portrait/landscape, tablet.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/home_feature_entity.dart';

class LanguagePairCard extends StatelessWidget {
  final LanguageOptionEntity sourceLanguage;
  final LanguageOptionEntity targetLanguage;
  final List<LanguageOptionEntity> languages;
  final ValueChanged<LanguageOptionEntity?> onSourceChanged;
  final ValueChanged<LanguageOptionEntity?> onTargetChanged;
  final VoidCallback onSwap;

  const LanguagePairCard({
    super.key,
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.languages,
    required this.onSourceChanged,
    required this.onTargetChanged,
    required this.onSwap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final bool compact = constraints.maxWidth < 520;

            if (compact) {
              return Column(
                children: <Widget>[
                  _LanguageDropdown(
                    label: 'Speaking in',
                    value: sourceLanguage,
                    languages: languages,
                    onChanged: onSourceChanged,
                  ),
                  const SizedBox(height: 12),
                  _SwapButton(onPressed: onSwap),
                  const SizedBox(height: 12),
                  _LanguageDropdown(
                    label: 'Translate to',
                    value: targetLanguage,
                    languages: languages,
                    onChanged: onTargetChanged,
                  ),
                ],
              );
            }

            return Row(
              children: <Widget>[
                Expanded(
                  child: _LanguageDropdown(
                    label: 'Speaking in',
                    value: sourceLanguage,
                    languages: languages,
                    onChanged: onSourceChanged,
                  ),
                ),
                const SizedBox(width: 12),
                _SwapButton(onPressed: onSwap),
                const SizedBox(width: 12),
                Expanded(
                  child: _LanguageDropdown(
                    label: 'Translate to',
                    value: targetLanguage,
                    languages: languages,
                    onChanged: onTargetChanged,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _LanguageDropdown extends StatelessWidget {
  final String label;
  final LanguageOptionEntity value;
  final List<LanguageOptionEntity> languages;
  final ValueChanged<LanguageOptionEntity?> onChanged;

  const _LanguageDropdown({
    required this.label,
    required this.value,
    required this.languages,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<LanguageOptionEntity>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.language_rounded),
      ),
      items: languages
          .map(
            (LanguageOptionEntity language) =>
                DropdownMenuItem<LanguageOptionEntity>(
                  value: language,
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

class _SwapButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SwapButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      tooltip: 'Swap languages',
      onPressed: onPressed,
      icon: const Icon(Icons.swap_horiz_rounded),
    );
  }
}
