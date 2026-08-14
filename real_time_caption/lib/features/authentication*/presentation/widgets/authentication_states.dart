/*
1. PAGE NAME
   Authentication States

2. PURPOSE
   Presents local loading, error, and success feedback for authentication UI.

3. DESCRIPTION
   Keeps transient feedback visually consistent and accessible.

4. UI SECTIONS
   Loading indicator, error message, and success message.

5. NAVIGATION FLOW
   AuthenticationController → AuthenticationStates.

6. DYNAMIC COMPONENTS
   Loading/error/success status.

7. FUTURE BACKEND INTEGRATION
   Future authentication responses can be mapped to these presentation states
   once the project's authentication contract is defined.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   Authentication controller state values.

10. FUTURE API ENDPOINTS
    Not defined.

11. DATABASE COLLECTIONS/TABLES
    Not defined.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    AnimatedSwitcher.

16. ACCESSIBILITY
    Status text is exposed through live semantic content.

17. EDGE CASES
    Very long messages.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    Displays local controller messages.

20. LOADING STATE
    CircularProgressIndicator with status text.

21. EMPTY STATE
    No widget is rendered when no state exists.

22. OFFLINE BEHAVIOUR
    No connectivity is checked.

23. SECURITY CONSIDERATIONS
    Does not expose credential values.

24. PERFORMANCE OPTIMIZATIONS
    AnimatedSwitcher changes only when status changes.

25. WIDGET TREE OVERVIEW
    AnimatedSwitcher → Card → status row.

26. COMPLETE TESTING CHECKLIST
    Verify all status modes, dark mode, large text, and long messages.
*/

import 'package:flutter/material.dart';

class AuthenticationStates extends StatelessWidget {
  const AuthenticationStates({
    super.key,
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
  });

  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Widget? content;

    if (isLoading) {
      content = Row(
        key: const ValueKey<String>('loading'),
        children: [
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2.2,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(child: Text('Preparing your secure session…')),
        ],
      );
    } else if (errorMessage != null) {
      content = Row(
        key: const ValueKey<String>('error'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline_rounded, color: colorScheme.error),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              errorMessage!,
              style: TextStyle(color: colorScheme.onErrorContainer),
            ),
          ),
        ],
      );
    } else if (successMessage != null) {
      content = Row(
        key: const ValueKey<String>('success'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_outline_rounded, color: colorScheme.primary),
          const SizedBox(width: 10),
          Expanded(child: Text(successMessage!)),
        ],
      );
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      child: content == null
          ? const SizedBox.shrink()
          : Semantics(
              liveRegion: true,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: errorMessage != null
                      ? colorScheme.errorContainer
                      : colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: content,
              ),
            ),
    );
  }
}
