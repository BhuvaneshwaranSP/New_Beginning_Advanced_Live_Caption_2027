/*
1. PAGE NAME
   Downloads States

2. PURPOSE
   Provides reusable loading, empty, and error representations.

3. DESCRIPTION
   Local UI states for the Downloads screen. No actual service operation occurs.

4. UI SECTIONS
   Loading, empty, error, and offline presentation.

5. NAVIGATION FLOW
   Downloads page → state widget.

6. DYNAMIC COMPONENTS
   Error retry callback and contextual empty message.

7. FUTURE BACKEND INTEGRATION
   Future: map actual storage/download failures to these presentation states;
   the widgets keep service details outside the UI.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   None.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    None specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Explicit explanatory text and labeled retry action.

17. EDGE CASES
    No downloads and no search matches.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    Retry callback is provided by parent.

20. LOADING STATE
    Circular progress indicator with explanatory text.

21. EMPTY STATE
    Dedicated icon, title, and description.

22. OFFLINE BEHAVIOUR
    Dedicated offline message.

23. SECURITY CONSIDERATIONS
    No sensitive data.

24. PERFORMANCE OPTIMIZATIONS
    Stateless widgets.

25. WIDGET TREE OVERVIEW
    Center → icon → text → optional action.

26. COMPLETE TESTING CHECKLIST
    Verify states with large text, screen reader, dark mode, and narrow screens.
*/

import 'package:flutter/material.dart';

class DownloadsLoadingState extends StatelessWidget {
  const DownloadsLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const _StatePanel(
      icon: Icons.downloading_rounded,
      title: 'Preparing downloads',
      message: 'Loading your offline resources.',
      child: CircularProgressIndicator(),
    );
  }
}

class DownloadsEmptyState extends StatelessWidget {
  const DownloadsEmptyState({super.key, this.isSearchResult = false});

  final bool isSearchResult;

  @override
  Widget build(BuildContext context) {
    return _StatePanel(
      icon: isSearchResult
          ? Icons.search_off_rounded
          : Icons.download_for_offline_outlined,
      title: isSearchResult ? 'No matching downloads' : 'No downloads yet',
      message: isSearchResult
          ? 'Try another language, resource name, or filter.'
          : 'Downloaded language resources and conversations will appear here.',
    );
  }
}

class DownloadsErrorState extends StatelessWidget {
  const DownloadsErrorState({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return _StatePanel(
      icon: Icons.error_outline_rounded,
      title: 'Downloads could not be loaded',
      message: 'The local demo state reported an error.',
      child: FilledButton.icon(
        onPressed: onRetry,
        icon: const Icon(Icons.refresh_rounded),
        label: const Text('Retry'),
      ),
    );
  }
}

class DownloadsOfflineState extends StatelessWidget {
  const DownloadsOfflineState({super.key});

  @override
  Widget build(BuildContext context) {
    return const _StatePanel(
      icon: Icons.cloud_off_outlined,
      title: 'You are offline',
      message: 'Previously downloaded resources remain available.',
    );
  }
}

class _StatePanel extends StatelessWidget {
  const _StatePanel({
    required this.icon,
    required this.title,
    required this.message,
    this.child,
  });

  final IconData icon;
  final String title;
  final String message;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, semanticLabel: title),
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
              if (child != null) ...[const SizedBox(height: 20), child!],
            ],
          ),
        ),
      ),
    );
  }
}
