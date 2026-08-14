import 'package:flutter/material.dart';

class StatusIndicator extends StatelessWidget {
  final String label;
  final bool active;
  const StatusIndicator({super.key, required this.label, required this.active});
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.circle, size: 9, semanticLabel: active ? 'Active' : 'Inactive'), const SizedBox(width: 6), Text(label)]);
}
