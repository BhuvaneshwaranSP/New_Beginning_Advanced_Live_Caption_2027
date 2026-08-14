/*
1. PAGE NAME
   Language Usage Card

2. PURPOSE
   Shows which languages contribute most to conversation usage.

3. DESCRIPTION
   Displays multilingual usage with percentage and session count.

4. UI SECTIONS
   Heading, language rows, progress indicators.

5. NAVIGATION FLOW
   AnalyticsPage → LanguageUsageCard.

6. DYNAMIC COMPONENTS
   LanguageUsageEntity list.

7. FUTURE BACKEND INTEGRATION
   Language usage will later be derived from persisted session analytics.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   LanguageUsageEntity.

10. FUTURE API ENDPOINTS
    None defined.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Icons.language.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    Progress indicators may animate naturally.

16. ACCESSIBILITY
    Progress values are accompanied by textual percentages.

17. EDGE CASES
    Empty languages, zero percentage, long native names.

18. VALIDATION RULES
    Percentages are clamped between 0 and 100.

19. ERROR HANDLING
    Parent state handles errors.

20. LOADING STATE
    Parent state handles loading.

21. EMPTY STATE
    Parent state handles empty state.

22. OFFLINE BEHAVIOUR
    Parent state handles offline state.

23. SECURITY CONSIDERATIONS
    No sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Small stateless list rendering.

25. WIDGET TREE OVERVIEW
    Card → heading → language rows → progress bars.

26. COMPLETE TESTING CHECKLIST
    Multilingual text, percentages, empty list, long native names,
    dark mode, large text, and screen-reader output.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/analytics_feature_entity.dart';

class LanguageUsageCard extends StatelessWidget {
  const LanguageUsageCard({super.key, required this.languages});

  final List<LanguageUsageEntity> languages;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Language mix',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Languages used across your sessions',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 18),
            if (languages.isEmpty)
              const Text('No language activity yet.')
            else
              ...languages.map(
                (language) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _LanguageRow(language: language),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _LanguageRow extends StatelessWidget {
  const _LanguageRow({required this.language});

  final LanguageUsageEntity language;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final percentage = (language.percentage / 100).clamp(0.0, 1.0);

    return Semantics(
      label:
          '${language.languageName}, ${language.nativeName}, ${language.percentage.toStringAsFixed(0)} percent, ${language.sessions} sessions',
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                child: Text(
                  language.languageCode,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${language.languageName} · ${language.nativeName}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${language.sessions} sessions',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${language.percentage.toStringAsFixed(0)}%',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          LinearProgressIndicator(
            value: percentage,
            minHeight: 7,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }
}
