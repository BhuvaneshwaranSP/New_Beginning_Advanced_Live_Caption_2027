/*
1. PAGE NAME
   Profile Header

2. PURPOSE
   Displays the user's profile identity in a compact LinguaLive presentation.

3. DESCRIPTION
   Shows initials, display name, email, and current communication status.

4. UI SECTIONS
   Avatar, identity, email, and status.

5. NAVIGATION FLOW
   ProfilePage → ProfileHeader.

6. DYNAMIC COMPONENTS
   ProfileFeatureEntity.

7. FUTURE BACKEND INTEGRATION
   Future profile/avatar data can be supplied to this widget through the
   profile entity without changing the visual responsibility of the widget.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   ProfileFeatureEntity.

10. FUTURE API ENDPOINTS
    Not specified by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified by the supplied project documentation.

12. REQUIRED ASSETS
    No mandatory image asset; initials are used as a local fallback.

13. REQUIRED ICONS
    person_outline and verified-style status iconography.

14. THEME COLORS
    Uses ColorScheme from the application theme.

15. ANIMATIONS
    Lightweight AnimatedContainer.

16. ACCESSIBILITY
    Semantic labels describe the profile identity and status.

17. EDGE CASES
    Long names and email addresses wrap safely.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    Missing values use safe fallback text.

20. LOADING STATE
    Managed by parent state widgets.

21. EMPTY STATE
    Managed by parent state widgets.

22. OFFLINE BEHAVIOUR
    Local entity remains displayable.

23. SECURITY CONSIDERATIONS
    No credentials displayed.

24. PERFORMANCE OPTIMIZATIONS
    Stateless reusable widget.

25. WIDGET TREE OVERVIEW
    Card → Row → Avatar + Column.

26. COMPLETE TESTING CHECKLIST
    Verify long multilingual names, semantics, and text scaling.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/profile_feature_entity.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.profile});

  final ProfileFeatureEntity profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Semantics(
              label: 'Profile picture for ${profile.displayName}',
              child: CircleAvatar(
                radius: 34,
                backgroundColor: colorScheme.primaryContainer,
                child: Text(
                  profile.initials,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.displayName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profile.email,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.translate_rounded,
                          size: 16,
                          color: colorScheme.onSecondaryContainer,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            profile.statusLabel,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: colorScheme.onSecondaryContainer,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
