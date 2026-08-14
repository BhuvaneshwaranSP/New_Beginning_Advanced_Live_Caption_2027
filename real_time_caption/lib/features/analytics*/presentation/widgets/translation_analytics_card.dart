/*
1. PAGE NAME
   Translation Analytics Card

2. PURPOSE
   Summarizes translation activity and demonstration confidence.

3. DESCRIPTION
   Shows translated words, segments, average confidence, and
   most active language.

4. UI SECTIONS
   Header, translation statistics, confidence indicator.

5. NAVIGATION FLOW
   AnalyticsPage → TranslationAnalyticsCard.

6. DYNAMIC COMPONENTS
   TranslationAnalyticsEntity.

7. FUTURE BACKEND INTEGRATION
   Values will later be calculated from LinguaLive translation activity.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   TranslationAnalyticsEntity.

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
    Linear progress indicator.

16. ACCESSIBILITY
    Confidence is shown both visually and numerically.

17. EDGE CASES
    Zero words, zero segments, and long language names.

18. VALIDATION RULES
    Confidence is displayed within 0–100%.

19. ERROR HANDLING
    Parent state handles unavailable data.

20. LOADING STATE
    Parent state handles loading.

21. EMPTY STATE
    Parent state handles empty state.

22. OFFLINE BEHAVIOUR
    Parent state handles offline state.

23. SECURITY CONSIDERATIONS
    No transcript content is exposed.

24. PERFORMANCE OPTIMIZATIONS
    Stateless lightweight card.

25. WIDGET TREE OVERVIEW
    Card → heading → statistics → confidence progress.

26. COMPLETE TESTING CHECKLIST
    Zero values, confidence boundaries, long language names,
    dark mode, large text, and semantics.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/analytics_feature_entity.dart';

class TranslationAnalyticsCard extends StatelessWidget {
  const TranslationAnalyticsCard({super.key, required this.analytics});

  final TranslationAnalyticsEntity analytics;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final confidence = (analytics.averageConfidence / 100).clamp(0.0, 1.0);

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Translation quality',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Activity across translated conversation content',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _TranslationStat(
                    label: 'Words',
                    value: _formatNumber(analytics.translatedWords),
                  ),
                ),
                Expanded(
                  child: _TranslationStat(
                    label: 'Segments',
                    value: _formatNumber(analytics.translatedSegments),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Average confidence',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                Text(
                  '${analytics.averageConfidence.toStringAsFixed(1)}%',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 9),
            Semantics(
              label:
                  'Average translation confidence ${analytics.averageConfidence.toStringAsFixed(1)} percent',
              child: LinearProgressIndicator(
                value: confidence,
                minHeight: 9,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(Icons.language_rounded, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Most active language: ${analytics.mostActiveLanguage}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _formatNumber(int value) {
    if (value >= 1000) {
      final thousands = value / 1000;
      return '${thousands.toStringAsFixed(thousands % 1 == 0 ? 0 : 1)}K';
    }
    return '$value';
  }
}

class _TranslationStat extends StatelessWidget {
  const _TranslationStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: theme.textTheme.bodySmall),
      ],
    );
  }
}
