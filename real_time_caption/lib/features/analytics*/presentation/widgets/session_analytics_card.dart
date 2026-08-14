/*
1. PAGE NAME
   Session Analytics Card

2. PURPOSE
   Summarizes LinguaLive conversation session activity.

3. DESCRIPTION
   Presents total sessions, completed sessions, average duration,
   and most-used language pair.

4. UI SECTIONS
   Header and four session statistics.

5. NAVIGATION FLOW
   AnalyticsPage → SessionAnalyticsCard.

6. DYNAMIC COMPONENTS
   SessionAnalyticsEntity.

7. FUTURE BACKEND INTEGRATION
   Session history analytics will later populate these values.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   SessionAnalyticsEntity.

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
    Text labels accompany every numeric value.

17. EDGE CASES
    Zero sessions and long language-pair names.

18. VALIDATION RULES
    Counts cannot be negative in production data.

19. ERROR HANDLING
    Parent state handles unavailable data.

20. LOADING STATE
    Parent state handles loading.

21. EMPTY STATE
    Parent state handles empty state.

22. OFFLINE BEHAVIOUR
    Parent state handles offline state.

23. SECURITY CONSIDERATIONS
    No personal session content is displayed.

24. PERFORMANCE OPTIMIZATIONS
    Stateless compact layout.

25. WIDGET TREE OVERVIEW
    Card → heading → statistic grid.

26. COMPLETE TESTING CHECKLIST
    Zero counts, long pair names, responsive grid, accessibility,
    dark mode, and large text.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/analytics_feature_entity.dart';

class SessionAnalyticsCard extends StatelessWidget {
  const SessionAnalyticsCard({super.key, required this.analytics});

  final SessionAnalyticsEntity analytics;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Session overview',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            _SessionStat(
              icon: Icons.forum_outlined,
              label: 'Total sessions',
              value: '${analytics.totalSessions}',
            ),
            const Divider(height: 26),
            _SessionStat(
              icon: Icons.check_circle_outline_rounded,
              label: 'Completed',
              value: '${analytics.completedSessions}',
            ),
            const Divider(height: 26),
            _SessionStat(
              icon: Icons.schedule_rounded,
              label: 'Average duration',
              value: '${analytics.averageMinutes} min',
            ),
            const Divider(height: 26),
            _SessionStat(
              icon: Icons.compare_arrows_rounded,
              label: 'Most used pair',
              value: analytics.mostUsedPair,
            ),
          ],
        ),
      ),
    );
  }
}

class _SessionStat extends StatelessWidget {
  const _SessionStat({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(icon, size: 21),
        const SizedBox(width: 12),
        Expanded(child: Text(label, style: theme.textTheme.bodyMedium)),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
