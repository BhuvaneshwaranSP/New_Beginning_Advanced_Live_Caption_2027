/*
1. PAGE NAME
   Downloads Header

2. PURPOSE
   Displays the title and concise status summary for Downloads.

3. DESCRIPTION
   Responsive Material 3 header used above the Downloads content.

4. UI SECTIONS
   Title, summary, and offline indicator.

5. NAVIGATION FLOW
   Downloads page → Downloads header.

6. DYNAMIC COMPONENTS
   Total and completed download counts.

7. FUTURE BACKEND INTEGRATION
   Future: replace dummy counts with the application's persisted download
   inventory; the header summarizes resource availability.

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
    Theme ColorScheme.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Clear heading and status semantics.

17. EDGE CASES
    Zero downloads and offline state.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    Delegated to page state.

20. LOADING STATE
    Delegated to page state.

21. EMPTY STATE
    Delegated to page state.

22. OFFLINE BEHAVIOUR
    Displays non-color-only offline status.

23. SECURITY CONSIDERATIONS
    No sensitive data.

24. PERFORMANCE OPTIMIZATIONS
    Small const-capable widget.

25. WIDGET TREE OVERVIEW
    Column → title + summary.

26. COMPLETE TESTING CHECKLIST
    Test large text, dark mode, zero counts, and offline status.
*/

import 'package:flutter/material.dart';

class DownloadsHeader extends StatelessWidget {
  const DownloadsHeader({
    super.key,
    required this.totalCount,
    required this.completedCount,
    required this.isOffline,
  });

  final int totalCount;
  final int completedCount;
  final bool isOffline;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Downloads',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '$completedCount of $totalCount resources ready for offline use',
          style: theme.textTheme.bodyMedium,
        ),
        if (isOffline) ...[
          const SizedBox(height: 12),
          Semantics(
            label: 'Offline mode. Downloaded resources remain available.',
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.cloud_off_outlined,
                    size: 19,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Offline mode · downloaded resources stay available',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
