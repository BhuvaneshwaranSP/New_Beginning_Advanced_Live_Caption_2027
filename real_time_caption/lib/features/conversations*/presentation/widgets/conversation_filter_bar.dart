/*
1. PAGE NAME
   Conversation Filter Bar

2. PURPOSE
   Provides search, category filtering, and sorting controls.

3. DESCRIPTION
   Allows users to narrow the locally displayed conversation history.

4. UI SECTIONS
   Search field, filter chips, and sort control.

5. NAVIGATION FLOW
   Conversations page → filter bar → controller.

6. DYNAMIC COMPONENTS
   Search query, selected filter, and selected sort.

7. FUTURE BACKEND INTEGRATION
   Filtering can later operate over synchronized Session History data.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   ConversationsController filter and sort enums.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    Future session-history storage.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material filter and sort icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    SegmentedButton provides native Material interaction feedback.

16. ACCESSIBILITY
    Search label, clear button, and filter labels.

17. EDGE CASES
    Very large text, long search queries, and narrow screens.

18. VALIDATION RULES
    Search remains plain text.

19. ERROR HANDLING
    Not applicable.

20. LOADING STATE
    Parent can disable interactions if necessary.

21. EMPTY STATE
    Parent displays search-empty state.

22. OFFLINE BEHAVIOUR
    Local filtering remains usable.

23. SECURITY CONSIDERATIONS
    Search text is not transmitted.

24. PERFORMANCE OPTIMIZATIONS
    Uses local controller filtering.

25. WIDGET TREE OVERVIEW
    SearchBar → horizontal filter chips → sort button.

26. COMPLETE TESTING CHECKLIST
    Test typing, clearing, filtering, sorting, keyboard interaction,
    screen readers, narrow layouts, and large text.
*/

import 'package:flutter/material.dart';

import '../controllers/conversations_controller.dart';

class ConversationFilterBar extends StatelessWidget {
  const ConversationFilterBar({super.key, required this.controller});

  final ConversationsController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SearchBar(
          hintText: 'Search conversations, people, or languages',
          leading: const Icon(Icons.search_rounded),
          trailing: controller.searchQuery.isEmpty
              ? null
              : <Widget>[
                  IconButton(
                    tooltip: 'Clear search',
                    onPressed: controller.clearSearch,
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
          onChanged: controller.updateSearch,
          elevation: const WidgetStatePropertyAll<double>(0),
        ),
        const SizedBox(height: 12),
        Row(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    _FilterChip(
                      label: 'All',
                      selected: controller.filter == ConversationFilter.all,
                      onSelected: (_) =>
                          controller.updateFilter(ConversationFilter.all),
                    ),
                    _FilterChip(
                      label: 'Meetings',
                      selected:
                          controller.filter == ConversationFilter.meetings,
                      onSelected: (_) =>
                          controller.updateFilter(ConversationFilter.meetings),
                    ),
                    _FilterChip(
                      label: 'Classes',
                      selected:
                          controller.filter == ConversationFilter.classrooms,
                      onSelected: (_) => controller.updateFilter(
                        ConversationFilter.classrooms,
                      ),
                    ),
                    _FilterChip(
                      label: 'Pinned',
                      selected: controller.filter == ConversationFilter.pinned,
                      onSelected: (_) =>
                          controller.updateFilter(ConversationFilter.pinned),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            PopupMenuButton<ConversationSort>(
              tooltip: 'Sort conversations',
              initialValue: controller.sort,
              onSelected: controller.updateSort,
              itemBuilder: (BuildContext context) =>
                  const <PopupMenuEntry<ConversationSort>>[
                    PopupMenuItem<ConversationSort>(
                      value: ConversationSort.recent,
                      child: Text('Recent'),
                    ),
                    PopupMenuItem<ConversationSort>(
                      value: ConversationSort.alphabetical,
                      child: Text('A–Z'),
                    ),
                  ],
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.sort_rounded),
              ),
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
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: onSelected,
        showCheckmark: true,
      ),
    );
  }
}
