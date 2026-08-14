/*
1. PAGE NAME
   Onboarding Header

2. PURPOSE
   Introduces LinguaLive and explains the purpose of selecting languages.

3. DESCRIPTION
   Responsive Material 3 header used at the top of onboarding.

4. UI SECTIONS
   Brand mark, title, supporting description.

5. NAVIGATION FLOW
   Displayed before language selection.

6. DYNAMIC COMPONENTS
   None.

7. FUTURE BACKEND INTEGRATION
   None.

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
    Semantic labels and clear heading hierarchy.

17. EDGE CASES
    Large text and narrow displays.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    None.

20. LOADING STATE
    None.

21. EMPTY STATE
    None.

22. OFFLINE BEHAVIOUR
    Fully available offline.

23. SECURITY CONSIDERATIONS
    None.

24. PERFORMANCE OPTIMIZATIONS
    Const-friendly widgets.

25. WIDGET TREE OVERVIEW
    Column → Icon → Text → Text.

26. COMPLETE TESTING CHECKLIST
    Test large text, dark mode, semantics, and narrow widths.
*/

import 'package:flutter/material.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Semantics(
          label: 'LinguaLive',
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              Icons.translate_rounded,
              size: 30,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Speak freely.\nUnderstand instantly.',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            height: 1.08,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Set your languages first. LinguaLive will use this pair as the starting point for your multilingual conversations.',
          style: theme.textTheme.bodyLarge?.copyWith(
            height: 1.5,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
