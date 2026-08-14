/*
1. PAGE NAME
   History Filter Bar

2. PURPOSE
   Provides search, session-type filtering, and sorting controls.

3. DESCRIPTION
   Gives users a compact way to find historical multilingual sessions.

4. UI SECTIONS
   Search field, filter chips, sort action.

5. NAVIGATION FLOW
   History page → filter/search → selected history result.

6. DYNAMIC COMPONENTS
   Search query, selected filter, and selected sort order.

7. FUTURE BACKEND INTEGRATION
   Search and filtering will later operate over persisted history records.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   HistoryFilter and HistorySort.

10. FUTURE API ENDPOINTS
    None implemented.

11. DATABASE COLLECTIONS/TABLES
    None implemented.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    Material chip selection transitions.

16. ACCESSIBILITY
    Search label, chip labels, and sort tooltip.

17. EDGE CASES
    Empty query and long filter labels.

18. VALIDATION RULES
    No validation is required for search text.

19. ERROR HANDLING
    No external operation is performed.

20. LOADING STATE
    Search remains available while local data is loading.

21. EMPTY STATE
    Parent displays no-results state.

22. OFFLINE BEHAVIOUR
    Filters operate on available local history.

23. SECURITY CONSIDERATIONS
    Search remains local and does not transmit entered text.

24. PERFORMANCE OPTIMIZATIONS
    Stateless presentation controlled by the parent controller.

25. WIDGET TREE OVERVIEW
    SearchBar → filter chips → sort menu.

26. COMPLETE TESTING CHECKLIST
    Verify search input, chip selection, sort menu, keyboard dismissal,
    large text, and horizontal responsiveness.
*/

import 'package:flutter/material.dart';

import '../controllers/history_controller.dart';

class HistoryFilterBar extends StatelessWidget {
  const HistoryFilterBar({
    super.key,
    required this.searchController,
    required this.filter,
    required this.sort,
    required this.onSearchChanged,
    required this.onClearSearch,
    required this.onFilterChanged,
    required this.onSortChanged,
  });

  final TextEditingController searchController;
  final HistoryFilter filter;
  final HistorySort sort;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onClearSearch;
  final ValueChanged<HistoryFilter> onFilterChanged;
  final ValueChanged<HistorySort> onSortChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchBar(
          controller: searchController,
          hintText: 'Search sessions, languages, or phrases',
          leading: const Icon(Icons.search_rounded),
          trailing: [
            if (searchController.text.isNotEmpty)
              IconButton(
                tooltip: 'Clear search',
                onPressed: onClearSearch,
                icon: const Icon(Icons.clear_rounded),
              ),
          ],
          onChanged: onSearchChanged,
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _FilterChip(
                      label: 'All',
                      selected: filter == HistoryFilter.all,
                      onSelected: () => onFilterChanged(HistoryFilter.all),
                    ),
                    const SizedBox(width: 8),
                    _FilterChip(
                      label: 'Live speech',
                      selected: filter == HistoryFilter.liveSpeech,
                      onSelected: () =>
                          onFilterChanged(HistoryFilter.liveSpeech),
                    ),
                    const SizedBox(width: 8),
                    _FilterChip(
                      label: 'Calls',
                      selected: filter == HistoryFilter.calls,
                      onSelected: () => onFilterChanged(HistoryFilter.calls),
                    ),
                    const SizedBox(width: 8),
                    _FilterChip(
                      label: 'Conversations',
                      selected: filter == HistoryFilter.conversations,
                      onSelected: () =>
                          onFilterChanged(HistoryFilter.conversations),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            PopupMenuButton<HistorySort>(
              tooltip: 'Sort history',
              initialValue: sort,
              onSelected: onSortChanged,
              icon: const Icon(Icons.swap_vert_rounded),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: HistorySort.newest,
                  child: Row(
                    children: [
                      const Icon(Icons.schedule_rounded),
                      const SizedBox(width: 12),
                      Text(
                        'Newest first',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: HistorySort.oldest,
                  child: Row(
                    children: [
                      const Icon(Icons.history_rounded),
                      const SizedBox(width: 12),
                      Text(
                        'Oldest first',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
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
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelected(),
      showCheckmark: true,
    );
  }
}