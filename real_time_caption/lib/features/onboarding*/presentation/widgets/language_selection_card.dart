/*
1. PAGE NAME
   Language Selection Card

2. PURPOSE
   Provides an accessible Material 3 control for selecting a source or target
   language.

3. DESCRIPTION
   Reusable language card showing language identity and selection state.

4. UI SECTIONS
   Language icon, language name, native name, selection indicator.

5. NAVIGATION FLOW
   User selects language → controller updates local onboarding state.

6. DYNAMIC COMPONENTS
   Language model, title, native name, selected state, and callback.

7. FUTURE BACKEND INTEGRATION
   None at widget level.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   OnboardingEntity.

10. FUTURE API ENDPOINTS
    None.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Icons.check_rounded.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    AnimatedContainer for selection feedback.

16. ACCESSIBILITY
    Full card semantics and selected-state announcement.

17. EDGE CASES
    Long names and large text.

18. VALIDATION RULES
    Selection is controlled by the parent.

19. ERROR HANDLING
    None.

20. LOADING STATE
    None.

21. EMPTY STATE
    None.

22. OFFLINE BEHAVIOUR
    Fully local.

23. SECURITY CONSIDERATIONS
    None.

24. PERFORMANCE OPTIMIZATIONS
    Lightweight implicit animation.

25. WIDGET TREE OVERVIEW
    Semantics → AnimatedContainer → InkWell → Row.

26. COMPLETE TESTING CHECKLIST
    Verify touch target, keyboard focus, semantics, selection animation,
    dark mode, and long multilingual labels.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/onboarding_feature_entity.dart';

class LanguageSelectionCard extends StatelessWidget {
  const LanguageSelectionCard({
    super.key,
    required this.language,
    required this.selected,
    required this.onTap,
  });

  final OnboardingEntity language;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;

    return Semantics(
      button: true,
      selected: selected,
      label: '${language.name}, ${language.nativeName}',
      hint: selected ? 'Selected' : 'Double tap to select',
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: selected ? colors.secondaryContainer : colors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? colors.secondary : colors.outlineVariant,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(18),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 42,
                    height: 42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selected
                          ? colors.secondary
                          : colors.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Text(
                      language.icon,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: selected
                            ? colors.onSecondary
                            : colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          language.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          language.nativeName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 160),
                    child: selected
                        ? Icon(
                            Icons.check_circle_rounded,
                            key: const ValueKey<String>('selected'),
                            color: colors.secondary,
                          )
                        : Icon(
                            Icons.radio_button_unchecked_rounded,
                            key: const ValueKey<String>('unselected'),
                            color: colors.outline,
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
