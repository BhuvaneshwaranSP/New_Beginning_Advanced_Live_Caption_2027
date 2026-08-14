import 'package:flutter/material.dart';

class OfflineState extends StatelessWidget {
  final VoidCallback? onRetry;
  const OfflineState({super.key, this.onRetry});
  @override
  Widget build(BuildContext context) => MaterialBanner(content: const Text('You are offline.'), leading: const Icon(Icons.cloud_off_outlined), actions: [TextButton(onPressed: onRetry, child: const Text('Retry'))]);
}
