/*
1. PAGE NAME
   Settings Header

2. PURPOSE
   Presents the primary Settings screen introduction.

3. DESCRIPTION
   Provides a simple LinguaLive-oriented header with title and supporting text.

4. UI SECTIONS
   Settings title and preference overview.

5. NAVIGATION FLOW
   SettingsPage → SettingsHeader.

6. DYNAMIC COMPONENTS
   None required.

7. FUTURE BACKEND INTEGRATION
   None.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   None.

10. FUTURE API ENDPOINTS
    None.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    tune icon.

14. THEME COLORS
    Material 3 color scheme.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Semantic header hierarchy.

17. EDGE CASES
    Large text and narrow screens.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    None.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Header remains visible.

23. SECURITY CONSIDERATIONS
    No sensitive data.

24. PERFORMANCE OPTIMIZATIONS
    Stateless and const-compatible.

25. WIDGET TREE OVERVIEW
    Column → icon container → title → description.

26. COMPLETE TESTING CHECKLIST
    Test text scaling, dark mode, and narrow widths.
*/

import 'package:flutter/material.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      header: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.tune_rounded,
              color: theme.colorScheme.onPrimaryContainer,
              size: 28,
              semanticLabel: 'Settings',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Settings',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Shape how LinguaLive listens, translates, and presents conversations.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
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
