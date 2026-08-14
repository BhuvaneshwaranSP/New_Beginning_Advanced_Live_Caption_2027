/*
1. PAGE NAME
   Settings Section

2. PURPOSE
   Groups related Settings tiles into a clear visual section.

3. DESCRIPTION
   Provides reusable Material 3 section structure.

4. UI SECTIONS
   Any Settings category.

5. NAVIGATION FLOW
   SettingsPage → SettingsSection → SettingsTile.

6. DYNAMIC COMPONENTS
   Section title and child settings.

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
    None.

14. THEME COLORS
    Material 3 surface and outline colors.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Section heading is exposed semantically.

17. EDGE CASES
    Empty child lists and large text.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    None.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Child content may be empty.

22. OFFLINE BEHAVIOUR
    Section remains usable.

23. SECURITY CONSIDERATIONS
    None.

24. PERFORMANCE OPTIMIZATIONS
    Lightweight reusable widget.

25. WIDGET TREE OVERVIEW
    Column → section heading → child list.

26. COMPLETE TESTING CHECKLIST
    Verify section spacing, overflow, accessibility, and dark mode.
*/

import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 4,
            bottom: 10,
          ),
          child: Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.colorScheme.outlineVariant,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              children: children,
            ),
          ),
        ),
      ],
    );
  }
}