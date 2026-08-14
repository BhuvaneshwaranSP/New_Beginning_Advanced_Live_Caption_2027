/*
1. PAGE NAME
   Help Center Search

2. PURPOSE
   Provides local FAQ search input.

3. DESCRIPTION
   Material 3 search field with clear action and accessible labeling.

4. UI SECTIONS
   Search field and clear button.

5. NAVIGATION FLOW
   Search input → controller → filtered FAQ list.

6. DYNAMIC COMPONENTS
   Search query and clear action.

7. FUTURE BACKEND INTEGRATION
   Future: connect remote Help Center search here if a supported search
   service is introduced; this widget currently performs local UI filtering.

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
    Icons.search, Icons.close.

14. THEME COLORS
    Application ColorScheme.

15. ANIMATIONS
    Native SearchBar interaction.

16. ACCESSIBILITY
    Search hint and semantic tooltip are provided.

17. EDGE CASES
    Empty and long search queries are supported.

18. VALIDATION RULES
    No minimum query length.

19. ERROR HANDLING
    No external errors.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Filtered article list handles empty results.

22. OFFLINE BEHAVIOUR
    Local search remains available offline.

23. SECURITY CONSIDERATIONS
    Search text is not persisted or transmitted.

24. PERFORMANCE OPTIMIZATIONS
    Query updates are passed directly to the local controller.

25. WIDGET TREE OVERVIEW
    SearchBar.

26. COMPLETE TESTING CHECKLIST
    Verify keyboard, clear action, long text, focus, dark mode, and large text.
*/

import 'package:flutter/material.dart';

class HelpCenterSearch extends StatelessWidget {
  const HelpCenterSearch({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SearchBar(
      controller: controller,
      hintText: 'Search help topics',
      leading: const Icon(Icons.search_rounded),
      trailing: [
        if (controller.text.isNotEmpty)
          IconButton(
            onPressed: onClear,
            tooltip: 'Clear search',
            icon: const Icon(Icons.close_rounded),
          ),
      ],
      onChanged: onChanged,
      elevation: const WidgetStatePropertyAll<double>(0),
      backgroundColor: WidgetStatePropertyAll<Color>(
        theme.colorScheme.surfaceContainerHighest,
      ),
      padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
        EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
