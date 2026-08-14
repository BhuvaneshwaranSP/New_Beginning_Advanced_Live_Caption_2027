/*
1. PAGE NAME
   Voice Clone Header

2. PURPOSE
   Presents the page introduction and privacy-focused explanation.

3. DESCRIPTION
   Compact responsive header for the Voice Clone screen.

4. UI SECTIONS
   Icon, title, description, and privacy badge.

5. NAVIGATION FLOW
   Voice Clone page → header.

6. DYNAMIC COMPONENTS
   None.

7. FUTURE BACKEND INTEGRATION
   None.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   None.

10. FUTURE API ENDPOINTS
    None defined.

11. DATABASE COLLECTIONS/TABLES
    None defined.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Icons.graphic_eq, Icons.privacy_tip_outlined.

14. THEME COLORS
    Derived from ColorScheme.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Text hierarchy and semantic icon labels.

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
    Explanation remains available offline.

23. SECURITY CONSIDERATIONS
    Clearly communicates that this screen is privacy-aware.

24. PERFORMANCE OPTIMIZATIONS
    Stateless widget.

25. WIDGET TREE OVERVIEW
    Column → icon container → title → description → privacy badge.

26. COMPLETE TESTING CHECKLIST
    Test dark mode, large text, narrow widths, and screen readers.
*/

import 'package:flutter/material.dart';

class VoiceCloneHeader extends StatelessWidget {
  const VoiceCloneHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.graphic_eq_rounded,
                color: colors.onPrimaryContainer,
                size: 28,
                semanticLabel: 'Voice profile',
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Voice profile',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Prepare a personal voice profile for multilingual communication.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 9,
          ),
          decoration: BoxDecoration(
            color: colors.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                Icons.privacy_tip_outlined,
                size: 18,
                color: colors.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Voice samples are sensitive. Keep consent and privacy in mind.',
                  style: theme.textTheme.labelLarge,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}