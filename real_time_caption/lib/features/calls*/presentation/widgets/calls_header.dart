/*
1. PAGE NAME
   Calls Header

2. PURPOSE
   Provides the visual introduction and search control for Calls.

3. DESCRIPTION
   Material 3 header with concise LinguaLive call context.

4. UI SECTIONS
   Title, subtitle, and search field.

5. NAVIGATION FLOW
   Calls page header → call list.

6. DYNAMIC COMPONENTS
   Search query.

7. FUTURE BACKEND INTEGRATION
   No backend behavior belongs here. Search results are supplied by the
   local CallsController.

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
    search.

14. THEME COLORS
    Active ColorScheme.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Search field has an explicit semantic label.

17. EDGE CASES
    Very long search text.

18. VALIDATION RULES
    No validation required.

19. ERROR HANDLING
    None.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Not applicable.

23. SECURITY CONSIDERATIONS
    No sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Stateless widget.

25. WIDGET TREE OVERVIEW
    Column → heading → search field.

26. COMPLETE TESTING CHECKLIST
    Test large text, long search text, keyboard behavior, and dark mode.
*/

import 'package:flutter/material.dart';

class CallsHeader extends StatelessWidget {
  const CallsHeader({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
    required this.onClearSearch,
  });

  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onClearSearch;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Calls',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Stay connected across languages.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 20),
        SearchBar(
          controller: searchController,
          onChanged: onSearchChanged,
          hintText: 'Search people or languages',
          leading: const Icon(Icons.search),
          trailing: <Widget>[
            if (searchController.text.isNotEmpty)
              IconButton(
                tooltip: 'Clear search',
                onPressed: onClearSearch,
                icon: const Icon(Icons.close),
              ),
          ],
        ),
      ],
    );
  }
}
