/*
1. PAGE NAME
   Feedback Category Selector

2. PURPOSE
   Lets the user identify the part of LinguaLive they want to comment on.

3. DESCRIPTION
   Displays feature categories as responsive Material 3 selectable cards.

4. UI SECTIONS
   Section heading and category list.

5. NAVIGATION FLOW
   Category selection → controller → selected state.

6. DYNAMIC COMPONENTS
   Category cards.

7. FUTURE BACKEND INTEGRATION
   None directly; selected category is consumed by the controller.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   FeedbackCategoryEntity.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Category icon metadata.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    AnimatedContainer.

16. ACCESSIBILITY
    Entire cards are semantic buttons with selected state.

17. EDGE CASES
    Empty category list displays a meaningful empty state.

18. VALIDATION RULES
    Selected category must belong to the provided list.

19. ERROR HANDLING
    None directly.

20. LOADING STATE
    None directly.

21. EMPTY STATE
    Built into the widget.

22. OFFLINE BEHAVIOUR
    Categories are local.

23. SECURITY CONSIDERATIONS
    None.

24. PERFORMANCE OPTIMIZATIONS
    Lightweight list rendering.

25. WIDGET TREE OVERVIEW
    Column → heading → responsive category cards.

26. COMPLETE TESTING CHECKLIST
    Test selection, empty list, large text, landscape, tablet, and screen reader.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/feedback_feature_entity.dart';

class FeedbackCategorySelector extends StatelessWidget {
  const FeedbackCategorySelector({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategorySelected,
  });

  final List<FeedbackCategoryEntity> categories;
  final String? selectedCategoryId;
  final ValueChanged<String> onCategorySelected;

  IconData _feedbackIcon(String iconName) {
    switch (iconName) {
      case 'experience':
        return Icons.auto_awesome_rounded;
      case 'translation':
        return Icons.translate_rounded;
      case 'captions':
        return Icons.subtitles_rounded;
      case 'calls':
        return Icons.call_rounded;
      case 'other':
        return Icons.chat_bubble_outline_rounded;
      default:
        return Icons.feedback_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'What would you like to comment on?',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Choose the area that best matches your feedback.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 14),
        if (categories.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'No feedback categories are currently available.',
                style: theme.textTheme.bodyMedium,
              ),
            ),
          )
        else
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final int columns = constraints.maxWidth >= 720 ? 2 : 1;
              final double gap = 12;
              final double width =
                  (constraints.maxWidth - (columns - 1) * gap) / columns;

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: categories.map((FeedbackCategoryEntity category) {
                  final bool selected = category.id == selectedCategoryId;

                  return SizedBox(
                    width: width,
                    child: Semantics(
                      button: true,
                      selected: selected,
                      label: '${category.title}. ${category.subtitle}',
                      child: InkWell(
                        onTap: () => onCategorySelected(category.id),
                        borderRadius: BorderRadius.circular(18),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: selected
                                ? theme.colorScheme.secondaryContainer
                                : theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: selected
                                  ? theme.colorScheme.secondary
                                  : theme.colorScheme.outlineVariant,
                              width: selected ? 1.5 : 1,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                _feedbackIcon(category.iconName),
                                color: selected
                                    ? theme.colorScheme.onSecondaryContainer
                                    : theme.colorScheme.primary,
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      category.title,
                                      style: theme.textTheme.titleSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      category.subtitle,
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                            color: theme
                                                .colorScheme
                                                .onSurfaceVariant,
                                            height: 1.35,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              if (selected)
                                Icon(
                                  Icons.check_circle_rounded,
                                  size: 20,
                                  color: theme.colorScheme.secondary,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
      ],
    );
  }
}
