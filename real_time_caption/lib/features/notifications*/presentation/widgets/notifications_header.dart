/*
1. PAGE NAME
   Notifications Header

2. PURPOSE
   Displays the Notifications page title, unread count, and read-all action.

3. DESCRIPTION
   Material 3 pinned header designed to remain visible while notification
   content scrolls.

4. UI SECTIONS
   Title, unread count, and mark-all-as-read action.

5. NAVIGATION FLOW
   NotificationsPage → NotificationsHeader.

6. DYNAMIC COMPONENTS
   Unread count and enabled/disabled read-all action.

7. FUTURE BACKEND INTEGRATION
   The supplied callback can later invoke the supported notification
   read-status operation.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   Unread count only.

10. FUTURE API ENDPOINTS
    None defined.

11. DATABASE COLLECTIONS/TABLES
    None defined.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material done-all icon.

14. THEME COLORS
    Uses Material 3 ColorScheme.

15. ANIMATIONS
    Native Material interaction feedback.

16. ACCESSIBILITY
    Tooltip and semantic button label through IconButton.

17. EDGE CASES
    Zero unread notifications and large text.

18. VALIDATION RULES
    Unread count cannot be negative.

19. ERROR HANDLING
    Not applicable.

20. LOADING STATE
    Parent page controls loading.

21. EMPTY STATE
    Parent page controls empty content.

22. OFFLINE BEHAVIOUR
    Parent page controls offline representation.

23. SECURITY CONSIDERATIONS
    No sensitive data.

24. PERFORMANCE OPTIMIZATIONS
    Lightweight StatelessWidget.

25. WIDGET TREE OVERVIEW
    SliverAppBar
      → title
      → unread count
      → mark-all-as-read IconButton.

26. COMPLETE TESTING CHECKLIST
    Zero/positive unread counts, large text, dark mode, screen reader,
    touch target, pinned scrolling, and narrow widths.
*/

import 'package:flutter/material.dart';

class NotificationsHeader extends StatelessWidget {
  const NotificationsHeader({
    super.key,
    required this.unreadCount,
    required this.onMarkAllRead,
  });

  final int unreadCount;
  final VoidCallback onMarkAllRead;

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
          const Text('Notifications'),
          if (unreadCount > 0)
            Text(
              '$unreadCount unread',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
        ],
      ),
      actions: [
        IconButton(
          tooltip: 'Mark all as read',
          onPressed: unreadCount == 0 ? null : onMarkAllRead,
          icon: const Icon(Icons.done_all_rounded),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
