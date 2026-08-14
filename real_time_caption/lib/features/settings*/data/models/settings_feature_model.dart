/*
1. PAGE NAME
   Settings Feature Data Model

2. PURPOSE
   Defines the data-layer representation of a LinguaLive Settings preference.

3. DESCRIPTION
   Contains immutable local data used by the Settings presentation layer.

4. UI SECTIONS
   Represents individual settings such as language, appearance, captions,
   translation, and connectivity preferences.

5. NAVIGATION FLOW
   Mock data source → model → entity → presentation.

6. DYNAMIC COMPONENTS
   Setting title, description, value, icon identifier, and control type.

7. FUTURE BACKEND INTEGRATION
   Future persistence mapping belongs at the data layer so API or local-storage
   representations remain separate from UI entities.

8. TECHNOLOGIES USED
   Dart.

9. REQUIRED DATA MODELS
   SettingsFeatureModel.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    None specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material icon identifiers are represented by String values.

14. THEME COLORS
    None stored in the model.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Display text remains separate from icon metadata.

17. EDGE CASES
    Empty descriptions and unusual setting values.

18. VALIDATION RULES
    Required display fields should be non-empty.

19. ERROR HANDLING
    No infrastructure errors are handled here.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    An empty model collection is supported by the data source.

22. OFFLINE BEHAVIOUR
    Model can represent locally available settings.

23. SECURITY CONSIDERATIONS
    No sensitive information is stored.

24. PERFORMANCE OPTIMIZATIONS
    Immutable value object.

25. WIDGET TREE OVERVIEW
    Model → mapper → entity → settings tile.

26. COMPLETE TESTING CHECKLIST
    Validate construction, null safety, and unusual display values.
*/

import '../../domain/entities/settings_feature_entity.dart';

enum SettingsControlType { navigation, switchControl, selection, information }

class SettingsFeatureModel {
  const SettingsFeatureModel({
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

  SettingsFeatureEntity toEntity() {
    return SettingsFeatureEntity(
      id: id,
      title: title,
      description: description,
      value: value,
      icon: icon,
      controlType: controlType,
      enabled: enabled,
    );
  }
}
