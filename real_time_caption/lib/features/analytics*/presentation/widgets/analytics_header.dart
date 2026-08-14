/*
1. PAGE NAME
   Analytics Header

2. PURPOSE
   Provides the Analytics page title, context, and local time-range selector.

3. DESCRIPTION
   Responsive Material 3 header with accessible range controls.

4. UI SECTIONS
   Title, subtitle, and time-range segmented control.

5. NAVIGATION FLOW
   AnalyticsPage → AnalyticsHeader.

6. DYNAMIC COMPONENTS
   Selected range.

7. FUTURE BACKEND INTEGRATION
   Range selection will later control the analytics query.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   String selectedRange.

10. FUTURE API ENDPOINTS
    None defined.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Icons.insights.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    Material segmented-control transitions.

16. ACCESSIBILITY
    Tooltips and semantic labels.

17. EDGE CASES
    Narrow widths and large text.

18. VALIDATION RULES
    Selected range must match a supplied option.

19. ERROR HANDLING
    None.

20. LOADING STATE
    Parent page handles it.

21. EMPTY STATE
    Parent page handles it.

22. OFFLINE BEHAVIOUR
    Parent page handles it.

23. SECURITY CONSIDERATIONS
    None.

24. PERFORMANCE OPTIMIZATIONS
    Stateless widget.

25. WIDGET TREE OVERVIEW
    Column → Row → Icon/Text → SegmentedButton.

26. COMPLETE TESTING CHECKLIST
    Verify range callbacks, responsive wrapping, large text,
    semantics, dark mode, and tablet layout.
*/

import 'package:flutter/material.dart';

class AnalyticsHeader extends StatelessWidget {
  const AnalyticsHeader({
    super.key,
    required this.selectedRange,
    required this.onRangeChanged,
    required this.onRefreshPressed,
  });

  final String selectedRange;
  final ValueChanged<String> onRangeChanged;
  final VoidCallback onRefreshPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Semantics(
                header: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Analytics',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'A clearer view of your multilingual conversations.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              tooltip: 'Refresh analytics',
              onPressed: onRefreshPressed,
              icon: const Icon(Icons.refresh_rounded),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SegmentedButton<String>(
            segments: const [
              ButtonSegment<String>(value: '7D', label: Text('7 days')),
              ButtonSegment<String>(value: '30D', label: Text('30 days')),
              ButtonSegment<String>(value: '90D', label: Text('90 days')),
            ],
            selected: {selectedRange},
            onSelectionChanged: (values) {
              if (values.isNotEmpty) {
                onRangeChanged(values.first);
              }
            },
          ),
        ),
      ],
    );
  }
}
