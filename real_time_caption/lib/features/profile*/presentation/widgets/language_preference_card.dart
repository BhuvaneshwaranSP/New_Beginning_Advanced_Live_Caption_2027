/*
1. PAGE NAME
   Language Preference Card

2. PURPOSE
   Shows the user's selected source and target communication languages.

3. DESCRIPTION
   Presents the language pair used by LinguaLive in a visually clear format.

4. UI SECTIONS
   Source language, translation direction, and target language.

5. NAVIGATION FLOW
   ProfilePage → LanguagePreferenceCard.

6. DYNAMIC COMPONENTS
   Preferred and target language values.

7. FUTURE BACKEND INTEGRATION
   Future language-preference persistence can update the supplied entity/model
   at the data layer; this widget remains presentation-only.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   ProfileFeatureEntity.

10. FUTURE API ENDPOINTS
    Not specified by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified by the supplied project documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    translate_rounded and swap_horiz_rounded.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    None required.

16. ACCESSIBILITY
    Language direction is expressed through text as well as icons.

17. EDGE CASES
    Long language names wrap without overflow.

18. VALIDATION RULES
    No language validation is performed in this UI-only implementation.

19. ERROR HANDLING
    Parent state handles errors.

20. LOADING STATE
    Parent state handles loading.

21. EMPTY STATE
    Parent state handles empty profile data.

22. OFFLINE BEHAVIOUR
    Local language preferences remain visible.

23. SECURITY CONSIDERATIONS
    No sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Stateless and lightweight.

25. WIDGET TREE OVERVIEW
    Card → Header → Language pair row.

26. COMPLETE TESTING CHECKLIST
    Verify multilingual labels, text scaling, RTL compatibility, and overflow.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/profile_feature_entity.dart';

class LanguagePreferenceCard extends StatelessWidget {
  const LanguagePreferenceCard({super.key, required this.profile});

  final ProfileFeatureEntity profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.language_rounded, color: colorScheme.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Communication languages',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            LayoutBuilder(
              builder: (context, constraints) {
                final compact = constraints.maxWidth < 380;

                if (compact) {
                  return Column(
                    children: [
                      _LanguageTile(
                        label: 'Preferred',
                        value: profile.preferredLanguage,
                      ),
                      const SizedBox(height: 12),
                      const Icon(Icons.arrow_downward_rounded),
                      const SizedBox(height: 12),
                      _LanguageTile(
                        label: 'Target',
                        value: profile.targetLanguage,
                      ),
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(
                      child: _LanguageTile(
                        label: 'Preferred',
                        value: profile.preferredLanguage,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: colorScheme.primary,
                        semanticLabel: 'translated to',
                      ),
                    ),
                    Expanded(
                      child: _LanguageTile(
                        label: 'Target',
                        value: profile.targetLanguage,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
