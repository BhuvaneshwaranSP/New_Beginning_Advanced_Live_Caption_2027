/*
1. PAGE NAME
   Profile States

2. PURPOSE
   Provides reusable loading, empty, error, and offline representations for
   the Profile screen.

3. DESCRIPTION
   These are local UI states only and do not perform connectivity detection
   or backend retry operations.

4. UI SECTIONS
   State card with icon, title, description, and optional action.

5. NAVIGATION FLOW
   ProfilePage → ProfileStates.

6. DYNAMIC COMPONENTS
   ProfileUiState.

7. FUTURE BACKEND INTEGRATION
   Future profile loading and connectivity results can map into these existing
   UI states without placing networking logic inside the widgets.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   ProfileUiState.

10. FUTURE API ENDPOINTS
    Not specified by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified by the supplied project documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    Parent page uses AnimatedSwitcher.

16. ACCESSIBILITY
    State information is communicated through text and icons.

17. EDGE CASES
    Offline, empty, and error states remain understandable without color.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    Error is represented locally.

20. LOADING STATE
    CircularProgressIndicator.

21. EMPTY STATE
    Profile unavailable message.

22. OFFLINE BEHAVIOUR
    Offline demonstration message.

23. SECURITY CONSIDERATIONS
    No sensitive information is exposed.

24. PERFORMANCE OPTIMIZATIONS
    Small stateless widgets.

25. WIDGET TREE OVERVIEW
    Card → Icon → Text → Optional button.

26. COMPLETE TESTING CHECKLIST
    Verify all state variants with large text and screen readers.
*/

import 'package:flutter/material.dart';

import '../controllers/profile_controller.dart';

class ProfileStateView extends StatelessWidget {
  const ProfileStateView({
    super.key,
    required this.state,
    required this.onRetry,
  });

  final ProfileUiState state;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case ProfileUiState.loading:
        return const _StateCard(
          icon: Icons.person_search_rounded,
          title: 'Loading profile',
          description: 'Preparing your LinguaLive profile.',
          child: Padding(
            padding: EdgeInsets.only(top: 18),
            child: CircularProgressIndicator(),
          ),
        );
      case ProfileUiState.empty:
        return _StateCard(
          icon: Icons.person_off_outlined,
          title: 'Profile unavailable',
          description: 'There is no profile information to display yet.',
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try again'),
            ),
          ),
        );
      case ProfileUiState.error:
        return _StateCard(
          icon: Icons.cloud_off_rounded,
          title: 'Could not load profile',
          description: 'The profile could not be prepared in this demo state.',
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
            ),
          ),
        );
      case ProfileUiState.offline:
        return _StateCard(
          icon: Icons.wifi_off_rounded,
          title: 'Offline profile view',
          description:
              'Showing locally available profile information without a live connection.',
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: OutlinedButton(
              onPressed: onRetry,
              child: const Text('Return to profile'),
            ),
          ),
        );
      case ProfileUiState.success:
        return const SizedBox.shrink();
    }
  }
}

class _StateCard extends StatelessWidget {
  const _StateCard({
    required this.icon,
    required this.title,
    required this.description,
    this.child,
  });

  final IconData icon;
  final String title;
  final String description;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 42,
                color: colorScheme.primary,
                semanticLabel: title,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              if (child != null) child!,
            ],
          ),
        ),
      ),
    );
  }
}
