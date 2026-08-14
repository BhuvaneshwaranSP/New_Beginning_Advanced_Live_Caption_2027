/*
1. PAGE NAME
   Feedback Header

2. PURPOSE
   Provides the page title and concise introduction.

3. DESCRIPTION
   Premium, minimal Material 3 header for LinguaLive feedback.

4. UI SECTIONS
   Back action, title, subtitle.

5. NAVIGATION FLOW
   Back action returns to the previous screen through the supplied callback.

6. DYNAMIC COMPONENTS
   None.

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
    Icons.arrow_back_rounded.

14. THEME COLORS
    Uses Material 3 ColorScheme.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Back button includes a semantic tooltip.

17. EDGE CASES
    Long titles are avoided through fixed localized copy.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    None.

20. LOADING STATE
    None.

21. EMPTY STATE
    None.

22. OFFLINE BEHAVIOUR
    None.

23. SECURITY CONSIDERATIONS
    None.

24. PERFORMANCE OPTIMIZATIONS
    Stateless widget with const-compatible construction.

25. WIDGET TREE OVERVIEW
    SafeArea → Row → BackButton → title block.

26. COMPLETE TESTING CHECKLIST
    Verify back callback, text scaling, dark mode, and narrow layouts.
*/

import 'package:flutter/material.dart';

class FeedbackHeader extends StatelessWidget {
  const FeedbackHeader({super.key, required this.onBackPressed});

  final VoidCallback onBackPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        IconButton(
          onPressed: onBackPressed,
          tooltip: 'Back',
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Share your feedback',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Help us make multilingual communication feel clearer, '
                  'faster, and more natural.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
