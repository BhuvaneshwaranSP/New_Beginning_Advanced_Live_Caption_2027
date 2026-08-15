import 'package:flutter/material.dart';

import '../controllers/sessions_controller.dart';

class SessionFilterBar extends StatelessWidget {
  const SessionFilterBar({
    required this.selectedFilter,
    required this.onChanged,
    super.key,
  });

  final SessionFilter selectedFilter;
  final ValueChanged<SessionFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SegmentedButton<SessionFilter>(
        segments: const <ButtonSegment<SessionFilter>>[
          ButtonSegment<SessionFilter>(
            value: SessionFilter.all,
            label: Text('All'),
            icon: Icon(Icons.view_list_rounded),
          ),
          ButtonSegment<SessionFilter>(
            value: SessionFilter.live,
            label: Text('Live'),
            icon: Icon(Icons.wifi_tethering_rounded),
          ),
          ButtonSegment<SessionFilter>(
            value: SessionFilter.scheduled,
            label: Text('Upcoming'),
            icon: Icon(Icons.schedule_rounded),
          ),
          ButtonSegment<SessionFilter>(
            value: SessionFilter.completed,
            label: Text('Completed'),
            icon: Icon(Icons.check_circle_outline_rounded),
          ),
          ButtonSegment<SessionFilter>(
            value: SessionFilter.offline,
            label: Text('Offline'),
            icon: Icon(Icons.cloud_off_rounded),
          ),
        ],
        selected: <SessionFilter>{selectedFilter},
        onSelectionChanged: (Set<SessionFilter> values) {
          if (values.isNotEmpty) {
            onChanged(values.first);
          }
        },
        showSelectedIcon: false,
      ),
    );
  }
}