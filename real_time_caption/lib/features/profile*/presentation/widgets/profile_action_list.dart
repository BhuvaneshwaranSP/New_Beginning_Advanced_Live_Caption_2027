/*
1. PAGE NAME
   Profile Action List

2. PURPOSE
   Provides clear entry points for profile-related UI actions.

3. DESCRIPTION
   Displays local UI actions without implementing navigation, persistence,
   authentication, or account-management functionality.

4. UI SECTIONS
   Edit profile, language preferences, privacy, and sign-out presentation.

5. NAVIGATION FLOW
   ProfilePage → ProfileActionList.

6. DYNAMIC COMPONENTS
   Action rows.

7. FUTURE BACKEND INTEGRATION
   Action callbacks are intentional UI integration points. Future navigation
   and account operations belong at these callbacks according to the application
   routing and authentication architecture.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   None beyond action metadata.

10. FUTURE API ENDPOINTS
    Not specified by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified by the supplied project documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    None required.

16. ACCESSIBILITY
    Each action has a semantic label and adequate touch target.

17. EDGE CASES
    Works with large text and narrow screens.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    No real action is executed.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Actions remain visually available but do not perform remote work.

23. SECURITY CONSIDERATIONS
    Sign-out is only represented visually; no credentials are handled.

24. PERFORMANCE OPTIMIZATIONS
    Static action metadata.

25. WIDGET TREE OVERVIEW
    Card → ListView of action tiles.

26. COMPLETE TESTING CHECKLIST
    Verify touch targets, screen readers, large text, and narrow layouts.
*/

import 'package:flutter/material.dart';

class ProfileActionList extends StatelessWidget {
  const ProfileActionList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      child: Column(
        children: [
          _ProfileActionTile(
            icon: Icons.edit_outlined,
            title: 'Edit profile',
            subtitle: 'Update your display information',
            onPressed: () {},
          ),
          const Divider(height: 1),
          _ProfileActionTile(
            icon: Icons.language_rounded,
            title: 'Language preferences',
            subtitle: 'Choose your communication languages',
            onPressed: () {},
          ),
          const Divider(height: 1),
          _ProfileActionTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy',
            subtitle: 'Review profile and communication privacy',
            onPressed: () {},
          ),
          const Divider(height: 1),
          _ProfileActionTile(
            icon: Icons.logout_rounded,
            title: 'Sign out',
            subtitle: 'Leave this LinguaLive session',
            iconColor: colorScheme.error,
            titleColor: colorScheme.error,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _ProfileActionTile extends StatelessWidget {
  const _ProfileActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onPressed,
    this.iconColor,
    this.titleColor,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;
  final Color? iconColor;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '$title. $subtitle',
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        leading: Icon(icon, color: iconColor),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: titleColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onPressed,
      ),
    );
  }
}
