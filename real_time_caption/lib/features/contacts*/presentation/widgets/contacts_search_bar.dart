/*
1. PAGE NAME
   Contacts Search Bar

2. PURPOSE
   Provides local contact search for the Contacts page.

3. DESCRIPTION
   Material 3 search field with clear support.

4. UI SECTIONS
   Search input.

5. NAVIGATION FLOW
   ContactsPage → ContactsSearchBar → ContactsController.

6. DYNAMIC COMPONENTS
   Search query and clear action.

7. FUTURE BACKEND INTEGRATION
   Search remains local UI behavior; remote search may later be integrated
   at the controller/data layer if supported by the final application design.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   Search string.

10. FUTURE API ENDPOINTS
    Not specified.

11. DATABASE COLLECTIONS/TABLES
    Not specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Search and clear Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    Native Material input behavior.

16. ACCESSIBILITY
    Search hint and clear tooltip.

17. EDGE CASES
    Empty search, long text, and multilingual input.

18. VALIDATION RULES
    No restrictive validation.

19. ERROR HANDLING
    Not applicable.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Page displays no-result state.

22. OFFLINE BEHAVIOUR
    Local search remains available.

23. SECURITY CONSIDERATIONS
    Search text is not persisted.

24. PERFORMANCE OPTIMIZATIONS
    Stateless input shell with callback-driven updates.

25. WIDGET TREE OVERVIEW
    SearchBar.

26. COMPLETE TESTING CHECKLIST
    Verify keyboard, clear action, multilingual input, and large text.
*/

import 'package:flutter/material.dart';

class ContactsSearchBar extends StatelessWidget {
  const ContactsSearchBar({
    super.key,
    required this.query,
    required this.onChanged,
    required this.onClear,
  });

  final String query;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: 'Search people or languages',
      leading: const Icon(Icons.search_rounded),
      trailing: query.isEmpty
          ? null
          : <Widget>[
              IconButton(
                tooltip: 'Clear search',
                onPressed: onClear,
                icon: const Icon(Icons.close_rounded),
              ),
            ],
      onChanged: onChanged,
    );
  }
}
