/*
1. PAGE NAME
   Languages States

2. PURPOSE
   Provides local loading, empty, and offline-preview UI states.

3. DESCRIPTION
   Keeps the Languages screen understandable during non-success UI states.

4. UI SECTIONS
   Loading and offline-preview representations.

5. NAVIGATION FLOW
   LanguagesPage → state widgets.

6. DYNAMIC COMPONENTS
   Loading indicators and offline status.

7. FUTURE BACKEND INTEGRATION
   Future: connect real language-resource availability to the offline
   indicator when offline language support is implemented.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   None.

10. FUTURE API ENDPOINTS
    Not implemented.

11. DATABASE COLLECTIONS/TABLES
    Not implemented.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    language, cloud_off.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    CircularProgressIndicator.

16. ACCESSIBILITY
    Progress indicator has a semantic label.

17. EDGE CASES
    Loading and no-result states.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    No real error state is generated because there is no backend.

20. LOADING STATE
    Circular progress indicator with explanatory text.

21. EMPTY STATE
    Search sections provide empty-state messaging.

22. OFFLINE BEHAVIOUR
    Local preview banner communicates simulated offline availability.

23. SECURITY CONSIDERATIONS
    No sensitive data.

24. PERFORMANCE OPTIMIZATIONS
    Lightweight stateless widgets.

25. WIDGET TREE OVERVIEW
    Center/Card → progress or offline status.

26. COMPLETE TESTING CHECKLIST
    Verify semantics, dark mode, large text, and responsive layout.
*/

import 'package:flutter/material.dart';

class LanguagesLoadingState extends StatelessWidget {
  const LanguagesLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Semantics(
              label: 'Loading languages',
              child: const CircularProgressIndicator(),
            ),
            const SizedBox(height: 16),
            const Text('Preparing your languages…'),
          ],
        ),
      ),
    );
  }
}

class LanguagesOfflineBanner extends StatelessWidget {
  const LanguagesOfflineBanner({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHighest,
      child: ListTile(
        leading: const Icon(Icons.cloud_off_rounded),
        title: const Text('Offline preview'),
        subtitle: const Text(
          'Some language resources may not be available offline.',
        ),
        trailing: IconButton(
          tooltip: 'Hide offline preview',
          onPressed: onPressed,
          icon: const Icon(Icons.close_rounded),
        ),
      ),
    );
  }
}
