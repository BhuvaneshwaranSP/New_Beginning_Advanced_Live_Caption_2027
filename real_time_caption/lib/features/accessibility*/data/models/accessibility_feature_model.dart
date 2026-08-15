/*
1. PAGE NAME
   Accessibility Feature Model

2. PURPOSE
   Represents local data used by the Accessibility feature.

3. DESCRIPTION
   Contains immutable UI-supporting models for accessibility settings and
   communication preferences.

4. UI SECTIONS
   Accessibility controls and communication preferences.

5. NAVIGATION FLOW
   Dummy data → data source → controller → presentation.

6. DYNAMIC COMPONENTS
   Accessibility settings, scale controls, and communication preferences.

7. FUTURE BACKEND INTEGRATION
   A future preference repository can map persisted accessibility settings
   into these models.

8. TECHNOLOGIES USED
   Dart and Flutter Material Icons.

9. REQUIRED DATA MODELS
   AccessibilitySettingModel and CommunicationPreferenceModel.

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
    Models provide descriptive labels for accessible controls.

17. EDGE CASES
    Optional scale values support both switch and slider controls.

18. VALIDATION RULES
    Scale values are bounded by the controller.

19. ERROR HANDLING
    Presentation layer handles user-facing states.

20. LOADING STATE
    Presentation-only.

21. EMPTY STATE
    Presentation-only.

22. OFFLINE BEHAVIOUR
    Models contain no external dependencies.

23. SECURITY CONSIDERATIONS
    No sensitive information is stored.

24. PERFORMANCE OPTIMIZATIONS
    Immutable model objects.

25. WIDGET TREE OVERVIEW
    Model → Entity → Controller → Widget.

26. COMPLETE TESTING CHECKLIST
    Validate model mapping, const construction, icon rendering, and state
    transitions.
*/

import 'package:flutter/material.dart';

class AccessibilitySettingModel {
  const AccessibilitySettingModel({
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

class CommunicationPreferenceModel {
  const CommunicationPreferenceModel({
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
