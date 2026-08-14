/*
1. PAGE NAME
   About Feature Data Model

2. PURPOSE
   Provides a data-layer representation of About screen information.

3. DESCRIPTION
   The model mirrors the domain entity while keeping the data layer
   independent from Flutter widgets.

4. UI SECTIONS
   Application identity, capabilities, communication modes,
   and technology overview.

5. NAVIGATION FLOW
   Dummy data → data model → mapper → domain entity → presentation.

6. DYNAMIC COMPONENTS
   About metadata, capabilities, modes, and technology descriptions.

7. FUTURE BACKEND INTEGRATION
   This model can later represent structured About metadata received from
   an approved application configuration source.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   AboutFeatureModel, AboutCapabilityModel, AboutModeModel,
   AboutTechnologyModel.

10. FUTURE API ENDPOINTS
    None at this UI-only stage.

11. DATABASE COLLECTIONS/TABLES
    None at this UI-only stage.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Handled by presentation.

17. EDGE CASES
    Empty lists, long text, multilingual text, and unusual Unicode
    characters.

18. VALIDATION RULES
    Required display values should contain meaningful text.

19. ERROR HANDLING
    No external data errors are handled at this stage.

20. LOADING STATE
    Not applicable to the local dummy model.

21. EMPTY STATE
    Empty collections can be safely mapped to empty presentation lists.

22. OFFLINE BEHAVIOUR
    Local dummy information is available without connectivity.

23. SECURITY CONSIDERATIONS
    No private or authentication-related data is represented.

24. PERFORMANCE OPTIMIZATIONS
    Immutable model instances and const constructors.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Model construction, nested collections, multilingual strings,
    empty collections, and mapper compatibility.
*/

class AboutFeatureModel {
  final String appName;
  final String version;
  final String description;
  final String mission;
  final List<AboutCapabilityModel> capabilities;
  final List<AboutModeModel> communicationModes;
  final List<AboutTechnologyModel> technologies;

  const AboutFeatureModel({
    required this.appName,
    required this.version,
    required this.description,
    required this.mission,
    required this.capabilities,
    required this.communicationModes,
    required this.technologies,
  });
}

class AboutCapabilityModel {
  final String title;
  final String description;

  const AboutCapabilityModel({required this.title, required this.description});
}

class AboutModeModel {
  final String title;
  final String description;

  const AboutModeModel({required this.title, required this.description});
}

class AboutTechnologyModel {
  final String name;
  final String role;

  const AboutTechnologyModel({required this.name, required this.role});
}
