import 'package:flutter/material.dart';

class LoadingState extends StatelessWidget {
  final String label;
  const LoadingState({super.key, this.label = 'Loading'});
  @override
  Widget build(BuildContext context) => Center(child: Column(mainAxisSize: MainAxisSize.min, children: [const CircularProgressIndicator(), const SizedBox(height: 12), Text(label)]));
}
