/*
1. PAGE NAME
   Downloads Filter Bar

2. PURPOSE
   Provides local search and category filtering.

3. DESCRIPTION
   Material 3 search field and filter chips for the Downloads screen.

4. UI SECTIONS
   Search and filter controls.

5. NAVIGATION FLOW
   User input → controller → filtered Downloads list.

6. DYNAMIC COMPONENTS
   Search query and selected filter.

7. FUTURE BACKEND INTEGRATION
   Future: search and filtering can be backed by the application's persisted
   download inventory; this widget remains presentation-only.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   DownloadsFilter.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    None specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    Native chip state transitions.

16. ACCESSIBILITY
    Labels and touch-friendly filter controls.

17. EDGE CASES
    Long search queries and no matching results.

18. VALIDATION RULES
    No restrictive validation; search is optional.

19. ERROR HANDLING
    No network error handled here.

20. LOADING STATE
    Page-level loading state.

21. EMPTY STATE
    Page-level empty-search state.

22. OFFLINE BEHAVIOUR
    Search remains locally available.

23. SECURITY CONSIDERATIONS
    Search text is not transmitted.

24. PERFORMANCE OPTIMIZATIONS
    Controller performs lightweight local filtering.

25. WIDGET TREE OVERVIEW
    SearchBar → filter chips.

26. COMPLETE TESTING CHECKLIST
    Keyboard, large text, horizontal overflow, accessibility, and filtering.
*/

import 'package:flutter/material.dart';

import '../controllers/downloads_controller.dart';

class DownloadsFilterBar extends StatelessWidget {
  const DownloadsFilterBar({super.key, required this.controller});

  final DownloadsController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBar(
          leading: const Icon(Icons.search_rounded),
          hintText: 'Search downloads',
          onChanged: controller.setQuery,
          trailing: [
            Semantics(
              label: 'Clear search',
              button: true,
              child: IconButton(
                tooltip: 'Clear search',
                onPressed: () => controller.setQuery(''),
                icon: const Icon(Icons.close_rounded),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _FilterChip(
                label: 'All',
                selected: controller.filter == DownloadsFilter.all,
                onSelected: () {
                  controller.setFilter(DownloadsFilter.all);
                },
              ),
              _FilterChip(
                label: 'Ready',
                selected: controller.filter == DownloadsFilter.completed,
                onSelected: () {
                  controller.setFilter(DownloadsFilter.completed);
                },
              ),
              _FilterChip(
                label: 'In progress',
                selected: controller.filter == DownloadsFilter.inProgress,
                onSelected: () {
                  controller.setFilter(DownloadsFilter.inProgress);
                },
              ),
              _FilterChip(
                label: 'Failed',
                selected: controller.filter == DownloadsFilter.failed,
                onSelected: () {
                  controller.setFilter(DownloadsFilter.failed);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onSelected(),
      ),
    );
  }
}
