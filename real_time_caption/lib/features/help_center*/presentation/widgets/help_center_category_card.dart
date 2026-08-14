/*
1. PAGE NAME
   Help Center Category Card

2. PURPOSE
   Displays a Help Center category.

3. DESCRIPTION
   Material 3 category card with presentation-owned constant icons.

4. UI SECTIONS
   Icon, category title, and description.

5. NAVIGATION FLOW
   Help Center page → category card.

6. DYNAMIC COMPONENTS
   Category entity.

7. FUTURE BACKEND INTEGRATION
   None directly required.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   HelpCenterCategoryEntity.

10. FUTURE API ENDPOINTS
    Not specified.

11. DATABASE COLLECTIONS/TABLES
    Not specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Application ColorScheme.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Text and semantic content are accessible.

17. EDGE CASES
    Long descriptions and narrow layouts.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    None.

20. LOADING STATE
    Parent page responsibility.

21. EMPTY STATE
    Parent page responsibility.

22. OFFLINE BEHAVIOUR
    Local content remains visible.

23. SECURITY CONSIDERATIONS
    No sensitive data.

24. PERFORMANCE OPTIMIZATIONS
    Stateless widget with const icons.

25. WIDGET TREE OVERVIEW
    Card → Row → Icon → Text.

26. COMPLETE TESTING CHECKLIST
    Verify responsive layout, dark mode, accessibility, and text scaling.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/help_center_feature_entity.dart';

class HelpCenterCategoryCard extends StatelessWidget {
  const HelpCenterCategoryCard({super.key, required this.category});

  final HelpCenterCategoryEntity category;

  IconData _iconForCategory(HelpCenterCategoryType type) {
    switch (type) {
      case HelpCenterCategoryType.gettingStarted:
        return Icons.rocket_launch_rounded;
      case HelpCenterCategoryType.translation:
        return Icons.translate_rounded;
      case HelpCenterCategoryType.liveCommunication:
        return Icons.forum_rounded;
      case HelpCenterCategoryType.privacy:
        return Icons.privacy_tip_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                _iconForCategory(category.type),
                color: colorScheme.onSecondaryContainer,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    category.description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
