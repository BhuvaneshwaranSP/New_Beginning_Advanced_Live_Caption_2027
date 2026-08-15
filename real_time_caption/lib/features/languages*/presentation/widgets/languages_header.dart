/*
1. PAGE NAME
   Languages Header

2. PURPOSE
   Presents the title, supporting message, and search control.

3. DESCRIPTION
   Establishes Languages as the central language-control experience.

4. UI SECTIONS
   Header and search.

5. NAVIGATION FLOW
   LanguagesPage → LanguagesHeader.

6. DYNAMIC COMPONENTS
   Search field.

7. FUTURE BACKEND INTEGRATION
   None required directly.

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
    search, language.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Search field has an explicit semantic label.

17. EDGE CASES
    Large text and long search queries.

18. VALIDATION RULES
    Search accepts normal text.

19. ERROR HANDLING
    No validation errors required.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Handled by language sections.

22. OFFLINE BEHAVIOUR
    Not applicable.

23. SECURITY CONSIDERATIONS
    Search text remains local.

24. PERFORMANCE OPTIMIZATIONS
    Stateless presentation widget.

25. WIDGET TREE OVERVIEW
    Column → title → description → SearchBar.

26. COMPLETE TESTING CHECKLIST
    Test keyboard, large text, dark mode, semantics, and search.
*/

import 'package:flutter/material.dart';

class LanguagesHeader extends StatelessWidget {
  const LanguagesHeader({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.language_rounded,
              color: theme.colorScheme.primary,
              size: 30,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Languages',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Keep your preferred languages ready for every conversation.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 20),
        SearchBar(
          controller: controller,
          onChanged: onChanged,
          leading: const Icon(Icons.search_rounded),
          hintText: 'Search languages',
          trailing: [
            if (controller.text.isNotEmpty)
              IconButton(
                tooltip: 'Clear search',
                onPressed: () {
                  controller.clear();
                  onChanged('');
                },
                icon: const Icon(Icons.clear_rounded),
              ),
          ],
        ),
      ],
    );
  }
}
