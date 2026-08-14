/*
1. PAGE NAME
   Settings Feature Domain Entity

2. PURPOSE
   Defines the pure domain representation of a LinguaLive Settings item.

3. DESCRIPTION
   Provides immutable business-level data without Flutter dependencies.

4. UI SECTIONS
   Language, translation, speech/caption, connectivity, appearance,
   and informational preferences.

5. NAVIGATION FLOW
   Data model → domain entity → Settings presentation.

6. DYNAMIC COMPONENTS
   Setting identity, label, description, value, icon metadata,
   control type, and enabled state.

7. FUTURE BACKEND INTEGRATION
   Future repositories can supply these entities without coupling
   the domain layer to a specific storage or API implementation.

8. TECHNOLOGIES USED
   Pure Dart.

9. REQUIRED DATA MODELS
   SettingsFeatureEntity.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    None specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Icon identifiers are retained as presentation metadata.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Text content is kept available independently from visual icons.

17. EDGE CASES
    Empty collections and disabled settings.

18. VALIDATION RULES
    IDs and display titles should remain stable and non-empty.

19. ERROR HANDLING
    No infrastructure error handling.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Supported through an empty entity collection.

22. OFFLINE BEHAVIOUR
    Entities can represent local settings while offline.

23. SECURITY CONSIDERATIONS
    No sensitive information is represented.

24. PERFORMANCE OPTIMIZATIONS
    Immutable entity with const constructor.

25. WIDGET TREE OVERVIEW
    Entity → SettingsTile.

26. COMPLETE TESTING CHECKLIST
    Validate immutability, enum mapping, and display values.
*/

import '../../data/models/settings_feature_model.dart';

class SettingsFeatureEntity {
  const SettingsFeatureEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.value,
    required this.icon,
    required this.controlType,
    this.enabled = true,
  });

  final String id;
  final String title;
  final String description;
  final String value;
  final String icon;
  final SettingsControlType controlType;
  final bool enabled;
}
