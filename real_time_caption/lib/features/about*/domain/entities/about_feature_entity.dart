/*
1. PAGE NAME
   About Feature Domain Entity

2. PURPOSE
   Defines the immutable domain-level information displayed by the LinguaLive
   About feature.

3. DESCRIPTION
   Contains pure Dart entities without Flutter or infrastructure dependencies.

4. UI SECTIONS
   About identity, application capabilities, communication modes,
   technology information, and project information.

5. NAVIGATION FLOW
   About presentation → domain entity.

6. DYNAMIC COMPONENTS
   Application information, feature descriptions, technology descriptions,
   communication modes.

7. FUTURE BACKEND INTEGRATION
   Domain entities can later receive information mapped from data models if
   application metadata becomes remotely configurable.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   AboutFeatureEntity, AboutTechnologyEntity, AboutModeEntity.

10. FUTURE API ENDPOINTS
    None required by the current UI-only implementation.

11. DATABASE COLLECTIONS/TABLES
    None required by the current UI-only implementation.

12. REQUIRED ASSETS
    No external assets are required by this entity layer.

13. REQUIRED ICONS
    None; icon selection belongs to presentation.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Accessibility is handled by presentation widgets.

17. EDGE CASES
    Empty descriptions, long technology names, zero feature items,
    multilingual strings.

18. VALIDATION RULES
    Identifiers and titles should be meaningful non-empty values.

19. ERROR HANDLING
    Handled by presentation/data layers.

20. LOADING STATE
    Not represented in the domain entity.

21. EMPTY STATE
    Represented by an empty collection when applicable.

22. OFFLINE BEHAVIOUR
    About information remains locally available.

23. SECURITY CONSIDERATIONS
    No user credentials, private content, or sensitive information
    is represented here.

24. PERFORMANCE OPTIMIZATIONS
    Immutable const-compatible objects.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Entity construction, multilingual strings, empty collections,
    long descriptions, and immutable values.
*/

class AboutFeatureEntity {
  final String appName;
  final String version;
  final String description;
  final String mission;
  final List<AboutCapabilityEntity> capabilities;
  final List<AboutModeEntity> communicationModes;
  final List<AboutTechnologyEntity> technologies;

  const AboutFeatureEntity({
    required this.appName,
    required this.version,
    required this.description,
    required this.mission,
    required this.capabilities,
    required this.communicationModes,
    required this.technologies,
  });
}

class AboutCapabilityEntity {
  final String title;
  final String description;

  const AboutCapabilityEntity({required this.title, required this.description});
}

class AboutModeEntity {
  final String title;
  final String description;

  const AboutModeEntity({required this.title, required this.description});
}

class AboutTechnologyEntity {
  final String name;
  final String role;

  const AboutTechnologyEntity({required this.name, required this.role});
}
