import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;
  const AppLogo({super.key, this.size = 48});
  @override
  Widget build(BuildContext context) => Semantics(label: 'LinguaLive logo', child: CircleAvatar(radius: size / 2, child: const Icon(Icons.translate)));
}
