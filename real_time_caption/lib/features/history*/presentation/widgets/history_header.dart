/*
1. PAGE NAME
   History Header

2. PURPOSE
   Provides the top app-bar presentation for the History screen.

3. DESCRIPTION
   Presents the screen title, session count, and refresh action.

4. UI SECTIONS
   Title, subtitle, refresh button.

5. NAVIGATION FLOW
   History page header → future history synchronization.

6. DYNAMIC COMPONENTS
   Session count and loading state.

7. FUTURE BACKEND INTEGRATION
   Refresh will later trigger the persisted history synchronization
   represented by the controller callback.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   None.

10. FUTURE API ENDPOINTS
    None implemented.

11. DATABASE COLLECTIONS/TABLES
    None implemented.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    Refresh icon uses standard Material interaction feedback.

16. ACCESSIBILITY
    Tooltip and semantic label on refresh action.

17. EDGE CASES
    Zero-session count and loading state.

18. VALIDATION RULES
    Count is displayed as a non-negative integer.

19. ERROR HANDLING
    Parent handles errors.

20. LOADING STATE
    Refresh action can be disabled while loading.

21. EMPTY STATE
    Count displays zero.

22. OFFLINE BEHAVIOUR
    Parent can expose offline information below the header.

23. SECURITY CONSIDERATIONS
    No sensitive content is shown by the header.

24. PERFORMANCE OPTIMIZATIONS
    Stateless widget and const-compatible structure.

25. WIDGET TREE OVERVIEW
    SliverAppBar → title → subtitle → refresh action.

26. COMPLETE TESTING CHECKLIST
    Verify title, count, refresh semantics, large text, and narrow widths.
*/

import 'package:flutter/material.dart';

class HistoryHeader extends StatelessWidget {
  const HistoryHeader({
    super.key,
    required this.sessionCount,
    required this.isLoading,
    required this.onRefresh,
  });

  final int sessionCount;
  final bool isLoading;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      pinned: true,
      backgroundColor: theme.colorScheme.surface,
      surfaceTintColor: theme.colorScheme.surfaceTint,
      titleSpacing: 20,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'History',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '$sessionCount saved sessions',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          tooltip: isLoading ? 'Loading history' : 'Refresh history',
          onPressed: isLoading ? null : onRefresh,
          icon: const Icon(Icons.refresh_rounded),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
