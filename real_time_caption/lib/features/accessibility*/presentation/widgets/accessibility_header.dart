/*
1. PAGE NAME
   Accessibility Header

2. PURPOSE
   Presents the title and introductory explanation for Accessibility.

3. DESCRIPTION
   Provides a calm, readable entry point emphasizing inclusive communication.

4. UI SECTIONS
   Back action, title, subtitle, and accessibility icon.

5. NAVIGATION FLOW
   Parent navigation → AccessibilityPage header.

6. DYNAMIC COMPONENTS
   None.

7. FUTURE BACKEND INTEGRATION
   None.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   None.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    accessibility_new.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Semantic title hierarchy and labelled back button.

17. EDGE CASES
    Long text scale and narrow screens.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    None.

20. LOADING STATE
    None.

21. EMPTY STATE
    None.

22. OFFLINE BEHAVIOUR
    Static UI remains available.

23. SECURITY CONSIDERATIONS
    None.

24. PERFORMANCE OPTIMIZATIONS
    Stateless widget.

25. WIDGET TREE OVERVIEW
    SafeArea → Row → Icon → title/subtitle → back button.

26. COMPLETE TESTING CHECKLIST
    Test large text, dark mode, semantic labels, and narrow layouts.
*/

import 'package:flutter/material.dart';

class AccessibilityHeader extends StatelessWidget {
  const AccessibilityHeader({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          button: true,
          label: 'Back',
          child: IconButton(
            tooltip: 'Back',
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.accessibility_new,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Accessibility',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Shape LinguaLive around the way you communicate best.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
