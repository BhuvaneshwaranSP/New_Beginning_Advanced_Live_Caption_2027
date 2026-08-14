/*
1. PAGE NAME
   Help Center Header

2. PURPOSE
   Provides the Help Center page heading and concise support description.

3. DESCRIPTION
   Responsive Material 3 header with a clear visual identity for LinguaLive.

4. UI SECTIONS
   Icon, title, description, and decorative status indicator.

5. NAVIGATION FLOW
   Displayed at the top of Help Center page.

6. DYNAMIC COMPONENTS
   Static local presentation content.

7. FUTURE BACKEND INTEGRATION
   None required by this widget.

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
    Icons.support_agent, Icons.translate.

14. THEME COLORS
    Uses ColorScheme from the current theme.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Uses semantic labels through descriptive text.

17. EDGE CASES
    Responsive width and text wrapping are supported.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    None.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Not applicable.

23. SECURITY CONSIDERATIONS
    No sensitive data.

24. PERFORMANCE OPTIMIZATIONS
    Stateless widget with const-compatible children.

25. WIDGET TREE OVERVIEW
    Column → icon container + title + description.

26. COMPLETE TESTING CHECKLIST
    Verify responsive wrapping, dark mode, large text, and screen reader output.
*/

import 'package:flutter/material.dart';

class HelpCenterHeader extends StatelessWidget {
  const HelpCenterHeader({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Semantics(
      container: true,
      label: 'LinguaLive Help Center',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: compact ? 48 : 56,
            height: compact ? 48 : 56,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              Icons.support_agent_rounded,
              color: colorScheme.onPrimaryContainer,
              size: compact ? 26 : 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Help Center',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Find clear answers for multilingual communication.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
