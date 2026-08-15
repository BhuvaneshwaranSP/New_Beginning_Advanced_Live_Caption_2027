/*
1. PAGE NAME
   Accessibility Feature Domain Entities

2. PURPOSE
   Defines immutable domain-level accessibility entities.

3. DESCRIPTION
   Keeps accessibility concepts independent from infrastructure and
   presentation implementation details.

4. UI SECTIONS
   Accessibility settings and communication preferences.

5. NAVIGATION FLOW
   Data models → domain entities → controller → presentation.

6. DYNAMIC COMPONENTS
   Accessibility values and preference selections.

7. FUTURE BACKEND INTEGRATION
   Future repositories can map persisted settings into these entities.

8. TECHNOLOGIES USED
   Dart and Flutter Material Icons.

9. REQUIRED DATA MODELS
   AccessibilitySettingEntity and CommunicationPreferenceEntity.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    None specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Entities preserve descriptive accessibility metadata.

17. EDGE CASES
    Optional values support different control types.

18. VALIDATION RULES
    Scale validation occurs in the controller.

19. ERROR HANDLING
    Presentation handles user-facing states.

20. LOADING STATE
    Not represented in domain entities.

21. EMPTY STATE
    Empty collections are valid.

22. OFFLINE BEHAVIOUR
    Entities have no external dependencies.

23. SECURITY CONSIDERATIONS
    No sensitive data.

24. PERFORMANCE OPTIMIZATIONS
    Immutable objects.

25. WIDGET TREE OVERVIEW
    Entity → Controller → Widget.

26. COMPLETE TESTING CHECKLIST
    Verify entity mapping and icon rendering.
*/

import 'package:flutter/material.dart';

class AccessibilitySettingEntity {
  const AccessibilitySettingEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.enabled,
    this.value,
    this.valueLabel,
  });

  final String id;
  final String title;
  final String description;
  final IconData icon;
  final bool enabled;
  final double? value;
  final String? valueLabel;
}

class CommunicationPreferenceEntity {
  const CommunicationPreferenceEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.selected,
  });

  final String id;
  final String title;
  final String description;
  final IconData icon;
  final bool selected;
}
