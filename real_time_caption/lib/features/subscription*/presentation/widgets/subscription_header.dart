/*
1. PAGE NAME
   Subscription Header

2. PURPOSE
   Introduces the LinguaLive subscription experience.

3. DESCRIPTION
   Presents concise messaging focused on multilingual communication rather than
   generic payment-oriented UI.

4. UI SECTIONS
   Icon, title, subtitle.

5. NAVIGATION FLOW
   SubscriptionPage → SubscriptionHeader.

6. DYNAMIC COMPONENTS
   None.

7. FUTURE BACKEND INTEGRATION
   Future: personalized subscription status can be displayed near this header
   after account/subscription services are integrated.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   None.

10. FUTURE API ENDPOINTS
    Not specified.

11. DATABASE COLLECTIONS/TABLES
    Not specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Icons.translate.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Header semantics use meaningful text.

17. EDGE CASES
    Large text scaling.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    None.

20. LOADING STATE
    None.

21. EMPTY STATE
    None.

22. OFFLINE BEHAVIOUR
    Header remains available.

23. SECURITY CONSIDERATIONS
    No sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Stateless widget.

25. WIDGET TREE OVERVIEW
    Column → icon → title → description.

26. COMPLETE TESTING CHECKLIST
    Test text scaling and narrow widths.
*/

import 'package:flutter/material.dart';

class SubscriptionHeader extends StatelessWidget {
  const SubscriptionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      header: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.translate_rounded,
              color: theme.colorScheme.onPrimaryContainer,
              size: 27,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Choose the way you communicate',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Unlock more multilingual conversations, captions, and translation experiences with LinguaLive.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}