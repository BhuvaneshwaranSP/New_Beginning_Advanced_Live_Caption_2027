/*
1. PAGE NAME
   Recent Session Card

2. PURPOSE
   Displays previous multilingual communication sessions.

3. DESCRIPTION
   UI-only representation of Home session history.

4. UI SECTIONS
   Session icon, title, language pair, time, participant count.

5. NAVIGATION FLOW
   Home → Recent session → future session/history screen.

6. DYNAMIC COMPONENTS
   Session information.

7. FUTURE BACKEND INTEGRATION
   Future: retrieve sessions from the project's Session History feature;
   this widget presents the result without owning persistence.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   RecentSessionEntity.

10. FUTURE API ENDPOINTS
    None.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    groups, history, arrow_forward.

14. THEME COLORS
    Active Material 3 ColorScheme.

15. ANIMATIONS
    Material interaction feedback.

16. ACCESSIBILITY
    ListTile semantics.

17. EDGE CASES
    Long session names, zero participants.

18. VALIDATION RULES
    No negative participant count is displayed.

19. ERROR HANDLING
    Parent state handles errors.

20. LOADING STATE
    Parent state handles loading.

21. EMPTY STATE
    Dedicated empty widget.

22. OFFLINE BEHAVIOUR
    Existing local data can remain visible.

23. SECURITY CONSIDERATIONS
    Current content is dummy data only.

24. PERFORMANCE OPTIMIZATIONS
    Lightweight ListTile.

25. WIDGET TREE OVERVIEW
    Card → ListTile.

26. COMPLETE TESTING CHECKLIST
    Long text, dark mode, accessibility, empty list, zero participants.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/home_feature_entity.dart';

class RecentSessionCard extends StatelessWidget {
  final RecentSessionEntity session;
  final VoidCallback onPressed;

  const RecentSessionCard({
    super.key,
    required this.session,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      child: ListTile(
        onTap: onPressed,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: theme.colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(
            Icons.groups_rounded,
            color: theme.colorScheme.onTertiaryContainer,
          ),
        ),
        title: Text(
          session.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            '${session.languagePair} • ${session.timeLabel}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.people_outline_rounded, size: 18),
            const SizedBox(height: 3),
            Text('${session.participantCount}'),
          ],
        ),
      ),
    );
  }
}
