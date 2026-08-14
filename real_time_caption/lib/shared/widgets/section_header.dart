import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onAction;
  final String? actionLabel;
  const SectionHeader({super.key, required this.title, this.onAction, this.actionLabel});
  @override
  Widget build(BuildContext context) => Row(children: [Expanded(child: Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700))), if (onAction != null) TextButton(onPressed: onAction, child: Text(actionLabel ?? 'View all'))]);
}
