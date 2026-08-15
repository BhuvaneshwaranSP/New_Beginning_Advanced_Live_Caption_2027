/*
1. PAGE NAME
   Language Tile

2. PURPOSE
   Displays one selectable language.

3. DESCRIPTION
   Shows language name, native name, code, region, and availability.

4. UI SECTIONS
   Language list sections.

5. NAVIGATION FLOW
   Language tile → local source/target selection.

6. DYNAMIC COMPONENTS
   Selected state and availability state.

7. FUTURE BACKEND INTEGRATION
   Future: connect language availability to actual downloadable/model
   availability at this selection boundary.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   LanguageFeatureEntity.

10. FUTURE API ENDPOINTS
    Not implemented.

11. DATABASE COLLECTIONS/TABLES
    Not implemented.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    language, check, cloud_off.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    AnimatedContainer selection transition.

16. ACCESSIBILITY
    Entire tile exposes language, selection, and availability.

17. EDGE CASES
    Long native names and unavailable resources.

18. VALIDATION RULES
    Unavailable languages remain visible but cannot be selected.

19. ERROR HANDLING
    Unavailable status is shown without throwing errors.

20. LOADING STATE
    Parent page handles loading.

21. EMPTY STATE
    Parent section handles empty results.

22. OFFLINE BEHAVIOUR
    Availability indicator can show unavailable resources.

23. SECURITY CONSIDERATIONS
    No sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Stateless reusable tile.

25. WIDGET TREE OVERVIEW
    Semantics → InkWell → AnimatedContainer → ListTile content.

26. COMPLETE TESTING CHECKLIST
    Test selected/unselected, available/unavailable, large text,
    semantics, touch target, and dark mode.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/languages_feature_entity.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({
    super.key,
    required this.language,
    required this.selected,
    required this.onTap,
  });

  final LanguageFeatureEntity language;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final background = selected
        ? colorScheme.secondaryContainer
        : colorScheme.surfaceContainerLow;

    final icon = selected
        ? Icons.check_circle_rounded
        : language.available
            ? Icons.language_rounded
            : Icons.cloud_off_rounded;

    return Semantics(
      button: true,
      selected: selected,
      label:
          '${language.name}, ${language.nativeName}, '
          '${language.available ? 'available' : 'currently unavailable'}'
          '${selected ? ', selected' : ''}',
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected
                  ? colorScheme.primary
                  : colorScheme.outlineVariant,
            ),
          ),
          child: ListTile(
            onTap: language.available ? onTap : null,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            leading: CircleAvatar(
              backgroundColor: selected
                  ? colorScheme.primary
                  : colorScheme.surfaceContainerHighest,
              foregroundColor: selected
                  ? colorScheme.onPrimary
                  : colorScheme.onSurfaceVariant,
              child: Icon(icon),
            ),
            title: Text(
              language.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            subtitle: Text(
              '${language.nativeName} • ${language.code}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: language.available
                ? Icon(
                    selected
                        ? Icons.radio_button_checked_rounded
                        : Icons.radio_button_unchecked_rounded,
                    color: selected
                        ? colorScheme.primary
                        : colorScheme.outline,
                  )
                : const Chip(
                    label: Text('Unavailable'),
                  ),
          ),
        ),
      ),
    );
  }
}