import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String message;
  const EmptyState({super.key, this.title = 'Nothing here yet', this.message = 'Content will appear here when available.'});
  @override
  Widget build(BuildContext context) => Center(child: Padding(padding: const EdgeInsets.all(32), child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.inbox_outlined, size: 48, semanticLabel: 'Empty'), const SizedBox(height: 12), Text(title, style: Theme.of(context).textTheme.titleMedium), const SizedBox(height: 6), Text(message, textAlign: TextAlign.center)])));
}
