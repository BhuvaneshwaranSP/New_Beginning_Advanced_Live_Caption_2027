import 'package:flutter/material.dart';

class SessionSummaryCard extends StatelessWidget {
  const SessionSummaryCard({
    required this.liveCount,
    required this.scheduledCount,
    required this.completedCount,
    super.key,
  });

  final int liveCount;
  final int scheduledCount;
  final int completedCount;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final bool compact = constraints.maxWidth < 430;

            final List<Widget> items = <Widget>[
              _SummaryItem(
                icon: Icons.radio_button_checked_rounded,
                label: 'Live',
                value: '$liveCount',
              ),
              _SummaryItem(
                icon: Icons.schedule_rounded,
                label: 'Upcoming',
                value: '$scheduledCount',
              ),
              _SummaryItem(
                icon: Icons.history_rounded,
                label: 'Completed',
                value: '$completedCount',
              ),
            ];

            if (compact) {
              return Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(child: items[0]),
                      Expanded(child: items[1]),
                    ],
                  ),
                  const SizedBox(height: 16),
                  items[2],
                ],
              );
            }

            return Row(
              children: <Widget>[
                Expanded(child: items[0]),
                Container(
                  width: 1,
                  height: 44,
                  color: theme.colorScheme.outlineVariant,
                ),
                Expanded(child: items[1]),
                Container(
                  width: 1,
                  height: 44,
                  color: theme.colorScheme.outlineVariant,
                ),
                Expanded(child: items[2]),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 22,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }
}