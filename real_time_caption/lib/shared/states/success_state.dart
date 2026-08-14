import 'package:flutter/material.dart';

class SuccessState extends StatelessWidget {
  final String message;
  const SuccessState({super.key, this.message = 'Completed successfully.'});
  @override
  Widget build(BuildContext context) => Center(child: Column(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.check_circle_outline, size: 52), const SizedBox(height: 12), Text(message)]));
}
