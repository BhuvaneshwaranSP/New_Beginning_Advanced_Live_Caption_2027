/*
1. PAGE NAME
   Feedback Rating Card

2. PURPOSE
   Allows the user to provide a 1–5 experience rating.

3. DESCRIPTION
   Uses accessible Material buttons with a compact visual rating treatment.

4. UI SECTIONS
   Rating prompt and five selectable rating controls.

5. NAVIGATION FLOW
   User selects a rating → controller updates local state.

6. DYNAMIC COMPONENTS
   Selected/unselected rating buttons.

7. FUTURE BACKEND INTEGRATION
   None in this widget; the controller owns future submission integration.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   Integer rating.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Icons.star_rounded.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    AnimatedContainer for selection feedback.

16. ACCESSIBILITY
    Each rating button has an explicit semantic tooltip.

17. EDGE CASES
    Invalid ratings are ignored by the controller.

18. VALIDATION RULES
    Rating must be between 1 and 5.

19. ERROR HANDLING
    None directly.

20. LOADING STATE
    Rating remains visible during submission.

21. EMPTY STATE
    Zero selected rating is visually supported.

22. OFFLINE BEHAVIOUR
    Selection remains local.

23. SECURITY CONSIDERATIONS
    None.

24. PERFORMANCE OPTIMIZATIONS
    Five lightweight controls only.

25. WIDGET TREE OVERVIEW
    Card → Column → rating prompt → five controls.

26. COMPLETE TESTING CHECKLIST
    Test each rating, keyboard-free operation, semantics, large text, and dark mode.
*/

import 'package:flutter/material.dart';

class FeedbackRatingCard extends StatelessWidget {
  const FeedbackRatingCard({
    super.key,
    required this.rating,
    required this.onRatingSelected,
  });

  final int rating;
  final ValueChanged<int> onRatingSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'How was your experience?',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'A quick rating helps us understand the overall experience.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List<Widget>.generate(5, (int index) {
                final int value = index + 1;
                final bool selected = value <= rating;

                return Semantics(
                  button: true,
                  label: 'Rate $value out of 5',
                  selected: selected,
                  child: Tooltip(
                    message: '$value out of 5',
                    child: InkWell(
                      onTap: () => onRatingSelected(value),
                      borderRadius: BorderRadius.circular(14),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: selected
                              ? theme.colorScheme.primaryContainer
                              : theme.colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: selected
                                ? theme.colorScheme.primary
                                : theme.colorScheme.outlineVariant,
                          ),
                        ),
                        child: Icon(
                          selected
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          color: selected
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
