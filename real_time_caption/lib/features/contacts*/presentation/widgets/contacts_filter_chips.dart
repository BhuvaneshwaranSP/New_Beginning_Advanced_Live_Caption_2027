/*
1. PAGE NAME
   Contacts Filter Chips

2. PURPOSE
   Provides quick local filtering for all, favorite, and online contacts.

3. DESCRIPTION
   Uses Material 3 FilterChip widgets.

4. UI SECTIONS
   Contact filter controls.

5. NAVIGATION FLOW
   ContactsPage → ContactsFilterChips → ContactsController.

6. DYNAMIC COMPONENTS
   Selected filter.

7. FUTURE BACKEND INTEGRATION
   Filters can later be combined with repository-backed contact data.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   ContactsFilter.

10. FUTURE API ENDPOINTS
    Not specified.

11. DATABASE COLLECTIONS/TABLES
    Not specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Favorite, online, and people Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    Material chip selection animation.

16. ACCESSIBILITY
    Filter labels communicate the selected state.

17. EDGE CASES
    Zero favorites or zero online contacts.

18. VALIDATION RULES
    Exactly one filter is active.

19. ERROR HANDLING
    Not applicable.

20. LOADING STATE
    Page may disable visual emphasis while loading.

21. EMPTY STATE
    Page handles zero results.

22. OFFLINE BEHAVIOUR
    Online filter represents dummy availability only.

23. SECURITY CONSIDERATIONS
    No external data access.

24. PERFORMANCE OPTIMIZATIONS
    Small stateless widget.

25. WIDGET TREE OVERVIEW
    Wrap → FilterChip widgets.

26. COMPLETE TESTING CHECKLIST
    Verify selection, touch targets, overflow, and screen-reader labels.
*/

import 'package:flutter/material.dart';

import '../controllers/contacts_controller.dart';

class ContactsFilterChips extends StatelessWidget {
  const ContactsFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onSelected,
  });

  final ContactsFilter selectedFilter;
  final ValueChanged<ContactsFilter> onSelected;

  @override
  Widget build(BuildContext context) {
    final List<_FilterOption> options = <_FilterOption>[
      const _FilterOption(
        filter: ContactsFilter.all,
        label: 'All',
        icon: Icons.people_alt_outlined,
      ),
      const _FilterOption(
        filter: ContactsFilter.favorites,
        label: 'Favorites',
        icon: Icons.star_outline_rounded,
      ),
      const _FilterOption(
        filter: ContactsFilter.online,
        label: 'Online',
        icon: Icons.circle,
      ),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options
          .map((option) {
            return FilterChip(
              selected: selectedFilter == option.filter,
              avatar: Icon(option.icon, size: 18),
              label: Text(option.label),
              onSelected: (_) => onSelected(option.filter),
            );
          })
          .toList(growable: false),
    );
  }
}

class _FilterOption {
  const _FilterOption({
    required this.filter,
    required this.label,
    required this.icon,
  });

  final ContactsFilter filter;
  final String label;
  final IconData icon;
}
