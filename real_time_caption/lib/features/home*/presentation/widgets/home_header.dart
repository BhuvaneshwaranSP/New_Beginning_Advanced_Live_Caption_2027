/*
1. PAGE NAME
   Home Header

2. PURPOSE
   Displays LinguaLive branding and the current local connection state.

3. DESCRIPTION
   Material 3 responsive header.

4. UI SECTIONS
   Brand, connection status, profile action.

5. NAVIGATION FLOW
   Home page → header actions.

6. DYNAMIC COMPONENTS
   Connection status.

7. FUTURE BACKEND INTEGRATION
   Future: connect the connection indicator to the application's real
   communication/connectivity state; this widget is responsible for displaying
   that state visually.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   HomeConnectionStatus.

10. FUTURE API ENDPOINTS
    None implemented.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    language, wifi, sync, wifi_off, person.

14. THEME COLORS
    Active Material 3 ColorScheme.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Semantic connection and profile labels.

17. EDGE CASES
    Offline and reconnecting states.

18. VALIDATION RULES
    Every status has text and an icon.

19. ERROR HANDLING
    Offline state is visually represented.

20. LOADING STATE
    Reconnecting state acts as a local progress state.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Displays Offline.

23. SECURITY CONSIDERATIONS
    No sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Lightweight stateless widget.

25. WIDGET TREE OVERVIEW
    Row → brand + status + profile.

26. COMPLETE TESTING CHECKLIST
    Status variants, dark mode, large text, semantics, narrow screens.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/home_feature_entity.dart';

class HomeHeader extends StatelessWidget implements PreferredSizeWidget {
  final HomeConnectionStatus connectionStatus;
  final VoidCallback onConnectionPressed;
  final VoidCallback onProfilePressed;

  const HomeHeader({
    super.key,
    required this.connectionStatus,
    required this.onConnectionPressed,
    required this.onProfilePressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 20,
      title: const _BrandMark(),
      actions: <Widget>[
        _ConnectionBadge(
          status: connectionStatus,
          onPressed: onConnectionPressed,
        ),
        const SizedBox(width: 8),
        IconButton(
          tooltip: 'Profile',
          onPressed: onProfilePressed,
          icon: const Icon(Icons.person_outline_rounded),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: colors.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.language_rounded, color: colors.onPrimaryContainer),
        ),
        const SizedBox(width: 10),
        Text(
          'LinguaLive',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}

class _ConnectionBadge extends StatelessWidget {
  final HomeConnectionStatus status;
  final VoidCallback onPressed;

  const _ConnectionBadge({required this.status, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final String label;
    final IconData icon;

    switch (status) {
      case HomeConnectionStatus.connected:
        label = 'Connected';
        icon = Icons.wifi_rounded;
      case HomeConnectionStatus.reconnecting:
        label = 'Reconnecting';
        icon = Icons.sync_rounded;
      case HomeConnectionStatus.offline:
        label = 'Offline';
        icon = Icons.wifi_off_rounded;
    }

    return Semantics(
      button: true,
      label: 'Connection status: $label',
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 16),
              const SizedBox(width: 6),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}
