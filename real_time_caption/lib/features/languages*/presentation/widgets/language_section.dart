/*
1. PAGE NAME
   Language Section

2. PURPOSE
   Groups languages into the central categories defined by the
   LinguaLive project flow.

3. DESCRIPTION
   Reusable section for My Languages, Preferred Languages, Recent Languages,
   and All Supported Languages.

4. UI SECTIONS
   Section heading and language tiles.

5. NAVIGATION FLOW
   LanguagesPage → LanguageSection → LanguageTile.

6. DYNAMIC COMPONENTS
   Filtered language list.

7. FUTURE BACKEND INTEGRATION
   None directly; selection callbacks belong to the controller boundary.

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
    section-specific Material icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Section headings use semantic header semantics.

17. EDGE CASES
    Empty section and long language lists.

18. VALIDATION RULES
    Only valid language entities are rendered.

19. ERROR HANDLING
    Empty section uses a meaningful local state.

20. LOADING STATE
    Parent page handles loading.

21. EMPTY STATE
    Local empty representation.

22. OFFLINE BEHAVIOUR
    Individual availability is shown by LanguageTile.

23. SECURITY CONSIDERATIONS
    No sensitive data.

24. PERFORMANCE OPTIMIZATIONS
    ListView.builder for larger language groups.

25. WIDGET TREE OVERVIEW
    Column → heading → list → LanguageTile.

26. COMPLETE TESTING CHECKLIST
    Test empty section, long lists, scrolling, semantics, and large text.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/languages_feature_entity.dart';
import 'language_tile.dart';

class LanguageSection extends StatelessWidget {
  const LanguageSection({
    super.key,
    required this.title,
    required this.icon,
    required this.languages,
    required this.selectedLanguageId,
    required this.onLanguageSelected,
  });

  final String title;
  final IconData icon;
  final List<LanguageFeatureEntity> languages;
  final String? selectedLanguageId;
  final ValueChanged<String> onLanguageSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (languages.isEmpty) {
      return _EmptyLanguageSection(
        title: title,
        icon: icon,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          header: true,
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                '${languages.length}',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ...languages.map(
          (language) => LanguageTile(
            language: language,
            selected: language.id == selectedLanguageId,
            onTap: () => onLanguageSelected(language.id),
          ),
        ),
      ],
    );
  }
}

class _EmptyLanguageSection extends StatelessWidget {
  const _EmptyLanguageSection({
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Icon(
              icon,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'No $title languages match your search.',
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}