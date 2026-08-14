/*
1. PAGE NAME
   Help Center Article Tile

2. PURPOSE
   Displays an expandable Help Center FAQ article.

3. DESCRIPTION
   Uses a lightweight AnimatedCrossFade to reveal the local answer.

4. UI SECTIONS
   Question, category label, expansion control, and answer.

5. NAVIGATION FLOW
   Help Center page → FAQ article expansion.

6. DYNAMIC COMPONENTS
   Expanded/collapsed article state.

7. FUTURE BACKEND INTEGRATION
   Future: load article detail from the supported Help Center content source
   at this expansion point; the current implementation remains local.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   HelpCenterArticleEntity.

10. FUTURE API ENDPOINTS
    Not specified.

11. DATABASE COLLECTIONS/TABLES
    Not specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Icons.help_outline, Icons.expand_more.

14. THEME COLORS
    Application ColorScheme.

15. ANIMATIONS
    AnimatedCrossFade and rotation-free expansion.

16. ACCESSIBILITY
    Expansion is exposed through a semantic button.

17. EDGE CASES
    Long answers and titles wrap naturally.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    Not applicable.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Parent page handles empty results.

22. OFFLINE BEHAVIOUR
    Local article content remains available.

23. SECURITY CONSIDERATIONS
    No private data.

24. PERFORMANCE OPTIMIZATIONS
    Lightweight implicit animation and local data.

25. WIDGET TREE OVERVIEW
    Card → InkWell → question row → AnimatedCrossFade.

26. COMPLETE TESTING CHECKLIST
    Verify expansion, keyboard dismissal, screen reader semantics, long text,
    dark mode, and large text.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/help_center_feature_entity.dart';

class HelpCenterArticleTile extends StatelessWidget {
  const HelpCenterArticleTile({
    super.key,
    required this.article,
    required this.expanded,
    required this.categoryTitle,
    required this.onPressed,
  });

  final HelpCenterArticleEntity article;
  final bool expanded;
  final String categoryTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      color: colorScheme.surfaceContainerLow,
      child: Column(
        children: [
          Semantics(
            button: true,
            expanded: expanded,
            label: article.title,
            child: InkWell(
              onTap: onPressed,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 15, 12, 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.help_outline_rounded,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            categoryTitle,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            article.title,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    AnimatedRotation(
                      turns: expanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 180),
                      child: const Icon(Icons.expand_more_rounded),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 180),
            crossFadeState: expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const SizedBox.shrink(),
            secondChild: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(52, 0, 16, 18),
              child: Text(
                article.description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
