/*
1. PAGE NAME
   Contacts States

2. PURPOSE
   Provides reusable local loading, empty, error, and offline representations.

3. DESCRIPTION
   These states make the Contacts screen visually complete without implementing
   real networking or connectivity.

4. UI SECTIONS
   Centered state content.

5. NAVIGATION FLOW
   ContactsPage → ContactsStates.

6. DYNAMIC COMPONENTS
   State icon, title, description, and retry action.

7. FUTURE BACKEND INTEGRATION
   Real repository failures and connectivity states can later map into these
   presentation states.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   None.

10. FUTURE API ENDPOINTS
    Not specified.

11. DATABASE COLLECTIONS/TABLES
    Not specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    CircularProgressIndicator for loading.

16. ACCESSIBILITY
    State titles and descriptions are readable by screen readers.

17. EDGE CASES
    Empty contacts and empty search results.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    Error state includes retry.

20. LOADING STATE
    Circular progress indicator.

21. EMPTY STATE
    Dedicated empty and no-results representations.

22. OFFLINE BEHAVIOUR
    Dedicated offline representation.

23. SECURITY CONSIDERATIONS
    No data access.

24. PERFORMANCE OPTIMIZATIONS
    Stateless widgets.

25. WIDGET TREE OVERVIEW
    Center → Icon / ProgressIndicator → Text → optional button.

26. COMPLETE TESTING CHECKLIST
    Verify each state with small and large text and accessibility tools.
*/

import 'package:flutter/material.dart';

class ContactsLoadingState extends StatelessWidget {
  const ContactsLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ContactsStateLayout(
      icon: CircularProgressIndicator(),
      title: 'Loading contacts',
      message: 'Preparing your multilingual contact list.',
    );
  }
}

class ContactsEmptyState extends StatelessWidget {
  const ContactsEmptyState({super.key, required this.onAddContact});

  final VoidCallback onAddContact;

  @override
  Widget build(BuildContext context) {
    return _ContactsStateLayout(
      icon: const Icon(Icons.people_outline_rounded, size: 48),
      title: 'No contacts yet',
      message: 'Your multilingual connections will appear here.',
      action: FilledButton.icon(
        onPressed: onAddContact,
        icon: const Icon(Icons.person_add_alt_1_rounded),
        label: const Text('Add contact'),
      ),
    );
  }
}

class ContactsNoResultsState extends StatelessWidget {
  const ContactsNoResultsState({super.key, required this.onClearSearch});

  final VoidCallback onClearSearch;

  @override
  Widget build(BuildContext context) {
    return _ContactsStateLayout(
      icon: const Icon(Icons.search_off_rounded, size: 48),
      title: 'No matches found',
      message: 'Try another name or language.',
      action: OutlinedButton(
        onPressed: onClearSearch,
        child: const Text('Clear search'),
      ),
    );
  }
}

class ContactsErrorState extends StatelessWidget {
  const ContactsErrorState({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return _ContactsStateLayout(
      icon: const Icon(Icons.error_outline_rounded, size: 48),
      title: 'Contacts unavailable',
      message: 'The local demo source reported an error.',
      action: FilledButton.icon(
        onPressed: onRetry,
        icon: const Icon(Icons.refresh_rounded),
        label: const Text('Retry'),
      ),
    );
  }
}

class ContactsOfflineState extends StatelessWidget {
  const ContactsOfflineState({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return _ContactsStateLayout(
      icon: const Icon(Icons.cloud_off_rounded, size: 48),
      title: 'Offline mode',
      message: 'Only locally available contact information is shown.',
      action: OutlinedButton.icon(
        onPressed: onRetry,
        icon: const Icon(Icons.refresh_rounded),
        label: const Text('Refresh'),
      ),
    );
  }
}

class _ContactsStateLayout extends StatelessWidget {
  const _ContactsStateLayout({
    required this.icon,
    required this.title,
    required this.message,
    this.action,
  });

  final Widget icon;
  final String title;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconTheme(
                data: IconThemeData(color: colors.primary),
                child: icon,
              ),
              const SizedBox(height: 18),
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
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
              if (action != null) ...<Widget>[
                const SizedBox(height: 20),
                action!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
