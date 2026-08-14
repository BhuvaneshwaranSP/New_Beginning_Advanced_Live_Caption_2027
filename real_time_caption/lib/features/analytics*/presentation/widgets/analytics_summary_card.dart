/*
1. PAGE NAME
   Analytics Summary Card

2. PURPOSE
   Displays one high-level LinguaLive analytics metric.

3. DESCRIPTION
   Compact Material 3 card with metric value, change indicator,
   and descriptive context.

4. UI SECTIONS
   Icon, label, value, change, description.

5. NAVIGATION FLOW
   AnalyticsPage → AnalyticsSummaryCard.

6. DYNAMIC COMPONENTS
   AnalyticsMetricEntity.

7. FUTURE BACKEND INTEGRATION
   Metric values will later come from validated analytics data.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   AnalyticsMetricEntity.

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
    None.

16. ACCESSIBILITY
    Entire metric is presented as a semantic information group.

17. EDGE CASES
    Long metric labels and large text.

18. VALIDATION RULES
    Value and label should remain meaningful.

19. ERROR HANDLING
    Parent state handles unavailable metrics.

20. LOADING STATE
    Parent state handles loading.

21. EMPTY STATE
    Parent state handles empty data.

22. OFFLINE BEHAVIOUR
    Parent state handles offline mode.

23. SECURITY CONSIDERATIONS
    No sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Stateless widget.

25. WIDGET TREE OVERVIEW
    Card → Column → Icon → Text → Row → description.

26. COMPLETE TESTING CHECKLIST
    Verify four-card layout, narrow widths, dark mode, large text,
    semantic reading order, and long labels.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/analytics_feature_entity.dart';

class AnalyticsSummaryCard extends StatelessWidget {
  const AnalyticsSummaryCard({
    super.key,
    required this.metric,
    required this.icon,
  });

  final AnalyticsMetricEntity metric;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Semantics(
          container: true,
          label:
              '${metric.label}: ${metric.value}. ${metric.changeLabel}. ${metric.description}',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: scheme.primary),
              const SizedBox(height: 18),
              Text(
                metric.label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelLarge,
              ),
              const SizedBox(height: 7),
              Text(
                metric.value,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 7),
              Row(
                children: [
                  Icon(
                    metric.positive
                        ? Icons.trending_up_rounded
                        : Icons.trending_down_rounded,
                    size: 17,
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      metric.changeLabel,
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(metric.description, style: theme.textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
