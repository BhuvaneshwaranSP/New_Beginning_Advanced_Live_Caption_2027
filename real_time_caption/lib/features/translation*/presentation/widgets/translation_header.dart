/*
1. PAGE NAME
   Translation Header

2. PURPOSE
   Provides the primary visual identity and context for the Translation screen.

3. DESCRIPTION
   Compact Material 3 header introducing multilingual translation.

4. UI SECTIONS
   Icon, title, subtitle, and optional status indicator.

5. NAVIGATION FLOW
   Rendered at the top of TranslationPage.

6. DYNAMIC COMPONENTS
   None.

7. FUTURE BACKEND INTEGRATION
   No backend functionality belongs in this static presentation widget.

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
    Icons.translate.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Descriptive text and tooltip-friendly iconography.

17. EDGE CASES
    Large text scaling.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    Not applicable.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Not applicable.

23. SECURITY CONSIDERATIONS
    Static presentation only.

24. PERFORMANCE OPTIMIZATIONS
    Const widgets.

25. WIDGET TREE OVERVIEW
    Row → icon + text column.

26. COMPLETE TESTING CHECKLIST
    Verify wrapping under large text and narrow widths.
*/

import 'package:flutter/material.dart';

class TranslationHeader extends StatelessWidget {
  const TranslationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      header: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.translate_rounded,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Translation',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Turn everyday words into clear multilingual conversations.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
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
