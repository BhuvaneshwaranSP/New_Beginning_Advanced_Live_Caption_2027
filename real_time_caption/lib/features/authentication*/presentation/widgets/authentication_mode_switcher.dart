/*
1. PAGE NAME
   Authentication Mode Switcher

2. PURPOSE
   Allows the user to move between sign-in and account-creation UI modes.

3. DESCRIPTION
   Uses Material 3 SegmentedButton for a compact, accessible mode selector.

4. UI SECTIONS
   Sign in and Create account options.

5. NAVIGATION FLOW
   AuthenticationPage → AuthenticationModeSwitcher → controller.

6. DYNAMIC COMPONENTS
   Selected AuthenticationMode.

7. FUTURE BACKEND INTEGRATION
   None; mode selection only controls local presentation.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   AuthenticationMode.

10. FUTURE API ENDPOINTS
    None defined.

11. DATABASE COLLECTIONS/TABLES
    None defined.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    Native Material selection animation.

16. ACCESSIBILITY
    SegmentedButton provides semantic selection state.

17. EDGE CASES
    Large text and narrow layouts.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    None.

20. LOADING STATE
    Disabled while submission is processing.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Fully local.

23. SECURITY CONSIDERATIONS
    No credential processing.

24. PERFORMANCE OPTIMIZATIONS
    Stateless widget.

25. WIDGET TREE OVERVIEW
    SegmentedButton<AuthenticationMode>.

26. COMPLETE TESTING CHECKLIST
    Verify keyboard/screen-reader navigation, selection state, and responsiveness.
*/

import 'package:flutter/material.dart';

import '../../data/models/authentication_feature_model.dart';

class AuthenticationModeSwitcher extends StatelessWidget {
  const AuthenticationModeSwitcher({
    super.key,
    required this.mode,
    required this.onChanged,
    required this.enabled,
  });

  final AuthenticationMode mode;
  final ValueChanged<AuthenticationMode> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<AuthenticationMode>(
      segments: const [
        ButtonSegment<AuthenticationMode>(
          value: AuthenticationMode.signIn,
          icon: Icon(Icons.login_rounded),
          label: Text('Sign in'),
        ),
        ButtonSegment<AuthenticationMode>(
          value: AuthenticationMode.createAccount,
          icon: Icon(Icons.person_add_alt_1_rounded),
          label: Text('Create account'),
        ),
      ],
      selected: <AuthenticationMode>{mode},
      onSelectionChanged: enabled
          ? (selection) {
              if (selection.isNotEmpty) {
                onChanged(selection.first);
              }
            }
          : null,
      expandedInsets: EdgeInsets.zero,
    );
  }
}
