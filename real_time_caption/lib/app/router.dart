import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(path: AppRoutes.home, builder: (_, __) => const _PlaceholderPage(title: 'LinguaLive')),
    GoRoute(path: AppRoutes.settings, builder: (_, __) => const _PlaceholderPage(title: 'Settings')),
    GoRoute(path: AppRoutes.profile, builder: (_, __) => const _PlaceholderPage(title: 'Profile')),
  ],
);

class _PlaceholderPage extends StatelessWidget {
  final String title;
  const _PlaceholderPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title)),
    );
  }
}
