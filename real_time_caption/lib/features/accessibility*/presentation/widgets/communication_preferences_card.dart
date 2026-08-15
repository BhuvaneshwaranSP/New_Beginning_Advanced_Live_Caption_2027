/*
1. PAGE NAME
   Communication Preferences Card

2. PURPOSE
   Lets users choose which communication modalities they prefer.

3. DESCRIPTION
   Reflects LinguaLive's accessibility flow where captions, translation,
   readable text, and optional spoken output complement one another.

4. UI SECTIONS
   Caption, translation, and spoken translation preferences.

5. NAVIGATION FLOW
   AccessibilityPage → Communication Preferences.

6. DYNAMIC COMPONENTS
   Selectable preference rows.

7. FUTURE BACKEND INTEGRATION
   Future: persist selected communication preferences through the project's
   preference repository so live communication screens can use them.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   CommunicationPreferenceEntity.

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
    AnimatedContainer for selection feedback.

16. ACCESSIBILITY
    Selection is communicated by text and icon, not color alone.

17. EDGE CASES
    All preferences disabled.

18. VALIDATION RULES
    A preference can always be individually selected or deselected.

19. ERROR HANDLING
    None required locally.

20. LOADING STATE
    Parent state handles loading.

21. EMPTY STATE
    Parent can display fallback state.

22. OFFLINE BEHAVIOUR
    Local selection remains available.

23. SECURITY CONSIDERATIONS
    No external data.

24. PERFORMANCE OPTIMIZATIONS
    Small immutable list rendering.

25. WIDGET TREE OVERVIEW
    Card → heading → selectable preference rows.

26. COMPLETE TESTING CHECKLIST
    Verify selections, semantics, touch targets, large text, and dark mode.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/accessibility_feature_entity.dart';

class CommunicationPreferencesCard extends StatelessWidget {
  const CommunicationPreferencesCard({
    super.key,
    required this.preferences,
    required this.onToggle,
  });

  final List<CommunicationPreferenceEntity> preferences;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Communication preferences',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Choose how LinguaLive should present multilingual conversations.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 10),
            for (final preference in preferences)
              _PreferenceRow(
                preference: preference,
                onTap: () => onToggle(preference.id),
              ),
          ],
        ),
      ),
    );
  }
}

class _PreferenceRow extends StatelessWidget {
  const _PreferenceRow({required this.preference, required this.onTap});

  final CommunicationPreferenceEntity preference;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      container: true,
      button: true,
      label:
          '${preference.title}. ${preference.description}. '
          '${preference.selected ? 'Selected' : 'Not selected'}',
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: const EdgeInsets.only(bottom: 6),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          decoration: BoxDecoration(
            color: preference.selected
                ? theme.colorScheme.primaryContainer
                : theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: preference.selected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outlineVariant,
            ),
          ),
          child: Row(
            children: [
              Icon(
                preference.icon,
                color: preference.selected
                    ? theme.colorScheme.onPrimaryContainer
                    : theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      preference.title,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 2),
                    Text(preference.description),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                preference.selected
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: preference.selected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
