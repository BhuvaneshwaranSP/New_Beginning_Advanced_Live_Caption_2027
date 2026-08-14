/*
1. PAGE NAME
   Contacts Feature Data Model

2. PURPOSE
   Defines the local data representation used by the Contacts feature.

3. DESCRIPTION
   Contains an immutable model suitable for dummy data and future mapping
   into the domain layer.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Mock data source → ContactFeatureModel → presentation.

6. DYNAMIC COMPONENTS
   Contact name, initials, languages, availability, favorite state, and
   recent interaction information.

7. FUTURE BACKEND INTEGRATION
   A remote/local DTO can later populate this model at the data-source layer.

8. TECHNOLOGIES USED
   Pure Dart.

9. REQUIRED DATA MODELS
   ContactFeatureModel.

10. FUTURE API ENDPOINTS
    Not specified in the supplied documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified in the supplied documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Presentation layer converts model values into semantic labels.

17. EDGE CASES
    Empty language list and optional last interaction text.

18. VALIDATION RULES
    Name and initials are required; other display metadata can be optional.

19. ERROR HANDLING
    Invalid backend mapping is outside the current UI-only scope.

20. LOADING STATE
    Represented by the presentation layer.

21. EMPTY STATE
    Represented by the presentation layer.

22. OFFLINE BEHAVIOUR
    Availability is dummy presentation data only.

23. SECURITY CONSIDERATIONS
    Contains only non-sensitive demo data.

24. PERFORMANCE OPTIMIZATIONS
    Immutable const-friendly model.

25. WIDGET TREE OVERVIEW
    Model → ContactFeatureEntity → ContactListTile.

26. COMPLETE TESTING CHECKLIST
    Verify long names, empty metadata, multilingual labels, and status text.
*/

class ContactFeatureModel {
  const ContactFeatureModel({
    required this.id,
    required this.name,
    required this.initials,
    required this.primaryLanguage,
    required this.secondaryLanguage,
    required this.isOnline,
    required this.isFavorite,
    this.lastInteraction,
  });

  final String id;
  final String name;
  final String initials;
  final String primaryLanguage;
  final String secondaryLanguage;
  final bool isOnline;
  final bool isFavorite;
  final String? lastInteraction;
}
