/*
1. PAGE NAME
   Conversations Header

2. PURPOSE
   Displays the primary Conversations page identity and supporting context.

3. DESCRIPTION
   Provides a clean LinguaLive header with history context and a local action
   menu for UI demonstration.

4. UI SECTIONS
   Title, subtitle, refresh action, and overflow menu.

5. NAVIGATION FLOW
   Conversations page → header.

6. DYNAMIC COMPONENTS
   Refresh callback and menu callback.

7. FUTURE BACKEND INTEGRATION
   Refresh will later trigger Session History synchronization at the page
   controller boundary.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   None.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    Future session-history storage.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Icons.history, Icons.refresh_rounded, Icons.more_horiz.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Tooltips and semantic button labels.

17. EDGE CASES
    Large text and narrow widths.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    Delegated through callbacks.

20. LOADING STATE
    Parent controls loading representation.

21. EMPTY STATE
    Parent controls empty representation.

22. OFFLINE BEHAVIOUR
    Parent controls offline representation.

23. SECURITY CONSIDERATIONS
    No data access.

24. PERFORMANCE OPTIMIZATIONS
    Stateless widget and const-compatible children.

25. WIDGET TREE OVERVIEW
    Row → icon → title/subtitle → actions.

26. COMPLETE TESTING CHECKLIST
    Test narrow widths, large text, semantic labels, and button targets.
*/

import 'package:flutter/material.dart';

class ConversationsHeader extends StatelessWidget {
  const ConversationsHeader({
    super.key,
    required this.onRefreshPressed,
    required this.onMorePressed,
  });

  final VoidCallback onRefreshPressed;
  final VoidCallback onMorePressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            Icons.history_rounded,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(width: 14),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Conversations',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 3),
              Text(
                'Your multilingual session history',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: 'Refresh conversations',
          onPressed: onRefreshPressed,
          icon: const Icon(Icons.refresh_rounded),
        ),
        IconButton(
          tooltip: 'More conversation options',
          onPressed: onMorePressed,
          icon: const Icon(Icons.more_horiz_rounded),
        ),
      ],
    );
  }
}
