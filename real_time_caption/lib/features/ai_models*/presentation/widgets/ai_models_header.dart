/*
1. PAGE NAME
   AI Models Header

2. PURPOSE
   Displays the introductory header for the LinguaLive AI Models screen.

3. DESCRIPTION
   Provides a concise explanation of the model catalog and the role of
   different AI components in multilingual communication.

4. UI SECTIONS
   Title, description, and model-count indicator.

5. NAVIGATION FLOW
   AiModelsPage → AiModelsHeader.

6. DYNAMIC COMPONENTS
   Model count.

7. FUTURE BACKEND INTEGRATION
   The count will later reflect the available model catalog.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   Integer model count.

10. FUTURE API ENDPOINTS
   None defined.

11. DATABASE COLLECTIONS/TABLES
   None defined.

12. REQUIRED ASSETS
   None.

13. REQUIRED ICONS
   Icons.auto_awesome.

14. THEME COLORS
   Active Material 3 ColorScheme.

15. ANIMATIONS
   None.

16. ACCESSIBILITY
   Semantic text hierarchy and readable labels.

17. EDGE CASES
   Zero model count is supported.

18. VALIDATION RULES
   Model count is non-negative.

19. ERROR HANDLING
   Not applicable.

20. LOADING STATE
   Parent page handles loading.

21. EMPTY STATE
   Parent page handles empty catalog.

22. OFFLINE BEHAVIOUR
   Header remains usable offline.

23. SECURITY CONSIDERATIONS
   No sensitive information.

24. PERFORMANCE OPTIMIZATIONS
   Stateless and const-friendly.

25. WIDGET TREE OVERVIEW
   Column → icon/title → description → count badge.

26. COMPLETE TESTING CHECKLIST
   Verify text scaling, dark mode, narrow widths, and semantics.
*/

import 'package:flutter/material.dart';

class AiModelsHeader extends StatelessWidget {
  const AiModelsHeader({super.key, required this.modelCount});

  final int modelCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.auto_awesome,
                color: theme.colorScheme.onPrimaryContainer,
                semanticLabel: 'AI models',
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI Models',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '$modelCount pipeline components',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          'Explore the AI components behind LinguaLive’s multilingual '
          'speech, translation, context, and voice pipeline.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}
