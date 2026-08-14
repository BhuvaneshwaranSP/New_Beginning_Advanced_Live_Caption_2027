/*
1. PAGE NAME
   Home States

2. PURPOSE
   Provides reusable loading, empty, error, and offline representations.

3. DESCRIPTION
   These are UI-only states for the Home screen. They do not perform real
   connectivity or retry operations.

4. UI SECTIONS
   Loading, empty, error, offline.

5. NAVIGATION FLOW
   Home → state representation.

6. DYNAMIC COMPONENTS
   Error message and retry callback.

7. FUTURE BACKEND INTEGRATION
   Future: connect retry to the appropriate Home repository operation;
   the state widget only presents the result.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   None.

10. FUTURE API ENDPOINTS
    None.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    cloud_off, history, error_outline.

14. THEME COLORS
    Active Material 3 ColorScheme.

15. ANIMATIONS
    CircularProgressIndicator.

16. ACCESSIBILITY
    Text and icons communicate state.

17. EDGE CASES
    Long error messages.

18. VALIDATION RULES
    Retry callback is always supplied.

19. ERROR HANDLING
    Visual error representation only.

20. LOADING STATE
    Circular progress indicator.

21. EMPTY STATE
    No recent sessions.

22. OFFLINE BEHAVIOUR
    Offline banner/card.

23. SECURITY CONSIDERATIONS
    No sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Small stateless widgets.

25. WIDGET TREE OVERVIEW
    Center → Card → icon/text/action.

26. COMPLETE TESTING CHECKLIST
    Loading, empty, error, offline, dark mode, large text, accessibility.
*/

import 'package:flutter/material.dart';

class HomeLoadingState extends StatelessWidget {
  const HomeLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class HomeEmptyState extends StatelessWidget {
  final String message;

  const HomeEmptyState({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: <Widget>[
            const Icon(Icons.history_rounded, size: 40),
            const SizedBox(height: 10),
            Text(
              'No recent sessions',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 5),
            Text(message, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class HomeErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const HomeErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: <Widget>[
            const Icon(Icons.error_outline_rounded, size: 40),
            const SizedBox(height: 10),
            Text(
              'Something went wrong',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 5),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 14),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeOfflineState extends StatelessWidget {
  const HomeOfflineState({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      child: ListTile(
        leading: const Icon(Icons.cloud_off_rounded),
        title: const Text('Offline mode'),
        subtitle: const Text(
          'Some real-time communication features may be unavailable.',
        ),
      ),
    );
  }
}
