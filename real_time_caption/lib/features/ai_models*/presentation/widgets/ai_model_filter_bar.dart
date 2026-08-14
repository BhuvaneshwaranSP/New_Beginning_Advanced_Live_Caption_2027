/*
1. PAGE NAME
   AI Model Filter Bar

2. PURPOSE
   Provides local search and category filtering controls.

3. DESCRIPTION
   Allows the user to visually narrow the local AI model catalog.

4. UI SECTIONS
   Search field and category chips.

5. NAVIGATION FLOW
   AI Models page → search/filter → filtered model cards.

6. DYNAMIC COMPONENTS
   Search text and selected category.

7. FUTURE BACKEND INTEGRATION
   Filtering can later be synchronized with a remotely supplied model catalog.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   AiModelCategory.

10. FUTURE API ENDPOINTS
   None defined.

11. DATABASE COLLECTIONS/TABLES
   None defined.

12. REQUIRED ASSETS
   None.

13. REQUIRED ICONS
   Material Icons.

14. THEME COLORS
   Active Material 3 ColorScheme.

15. ANIMATIONS
   Segmented filter selection uses Material interaction animation.

16. ACCESSIBILITY
   Search semantics and category labels are provided.

17. EDGE CASES
   Empty search and no category selection are supported.

18. VALIDATION RULES
   Search input is optional.

19. ERROR HANDLING
   Not applicable.

20. LOADING STATE
   Parent page handles loading.

21. EMPTY STATE
   Parent page handles empty results.

22. OFFLINE BEHAVIOUR
   Local filtering remains available offline.

23. SECURITY CONSIDERATIONS
   Search text is not persisted or transmitted.

24. PERFORMANCE OPTIMIZATIONS
   Lightweight callbacks and local filtering.

25. WIDGET TREE OVERVIEW
   Column → SearchBar → horizontal category chips.

26. COMPLETE TESTING CHECKLIST
   Verify keyboard behavior, text scaling, chip wrapping, dark mode, and
   accessibility.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/ai_model_entity.dart';

class AiModelFilterBar extends StatelessWidget {
  const AiModelFilterBar({
    super.key,
    required this.searchController,
    required this.selectedCategory,
    required this.onSearchChanged,
    required this.onCategoryChanged,
  });

  final TextEditingController searchController;
  final AiModelCategory? selectedCategory;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<AiModelCategory?> onCategoryChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchBar(
          controller: searchController,
          onChanged: onSearchChanged,
          hintText: 'Search models, capabilities or languages',
          leading: const Icon(Icons.search),
          trailing: [
            if (searchController.text.isNotEmpty)
              IconButton(
                tooltip: 'Clear search',
                onPressed: () {
                  searchController.clear();
                  onSearchChanged('');
                },
                icon: const Icon(Icons.close),
              ),
          ],
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 42,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _FilterChip(
                label: 'All',
                icon: Icons.apps_outlined,
                selected: selectedCategory == null,
                onPressed: () => onCategoryChanged(null),
              ),
              ...AiModelCategory.values.map(
                (category) => Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: _FilterChip(
                    label: _categoryLabel(category),
                    icon: _categoryIcon(category),
                    selected: selectedCategory == category,
                    onPressed: () => onCategoryChanged(category),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _categoryLabel(AiModelCategory category) {
    switch (category) {
      case AiModelCategory.speechRecognition:
        return 'Speech';
      case AiModelCategory.translation:
        return 'Translation';
      case AiModelCategory.contextualLanguage:
        return 'Context';
      case AiModelCategory.textToSpeech:
        return 'Voice';
      case AiModelCategory.runtime:
        return 'Runtime';
      case AiModelCategory.optimization:
        return 'Optimization';
    }
  }

  IconData _categoryIcon(AiModelCategory category) {
    switch (category) {
      case AiModelCategory.speechRecognition:
        return Icons.graphic_eq;
      case AiModelCategory.translation:
        return Icons.translate;
      case AiModelCategory.contextualLanguage:
        return Icons.psychology_outlined;
      case AiModelCategory.textToSpeech:
        return Icons.record_voice_over_outlined;
      case AiModelCategory.runtime:
        return Icons.memory_outlined;
      case AiModelCategory.optimization:
        return Icons.speed_outlined;
    }
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      selected: selected,
      avatar: Icon(icon, size: 18),
      label: Text(label),
      onSelected: (_) => onPressed(),
    );
  }
}
