/*
1. PAGE NAME
   Authentication Brand Header

2. PURPOSE
   Presents LinguaLive identity and multilingual communication positioning.

3. DESCRIPTION
   Compact responsive header used above the authentication form.

4. UI SECTIONS
   Brand mark, application name, tagline, and language strip.

5. NAVIGATION FLOW
   AuthenticationPage → AuthenticationBrandHeader.

6. DYNAMIC COMPONENTS
   Application name, tagline, and language samples.

7. FUTURE BACKEND INTEGRATION
   None; this widget is presentation-only.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   AuthenticationFeatureEntity.

10. FUTURE API ENDPOINTS
    None.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Semantic application identity and readable text.

17. EDGE CASES
    Long tagline and narrow screen width.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    None.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Fully local.

23. SECURITY CONSIDERATIONS
    No personal data.

24. PERFORMANCE OPTIMIZATIONS
    Stateless and lightweight.

25. WIDGET TREE OVERVIEW
    Column → brand icon → title → tagline → language chips.

26. COMPLETE TESTING CHECKLIST
    Verify responsiveness, dark mode, large text, and multilingual rendering.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/authentication_feature_entity.dart';

class AuthenticationBrandHeader extends StatelessWidget {
  const AuthenticationBrandHeader({super.key, required this.entity});

  final AuthenticationFeatureEntity entity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          label: '${entity.appName} application',
          child: Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              Icons.translate_rounded,
              size: 30,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          entity.appName,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          entity.tagline,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: entity.supportedLanguages.take(5).map((language) {
            return Chip(
              avatar: const Icon(Icons.language_rounded, size: 16),
              label: Text(language),
              visualDensity: VisualDensity.compact,
            );
          }).toList(),
        ),
      ],
    );
  }
}
