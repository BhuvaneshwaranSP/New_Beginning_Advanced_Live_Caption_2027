/*
1. PAGE NAME
   Contacts Feature Domain Entity

2. PURPOSE
   Defines the domain-level representation of a LinguaLive contact.

3. DESCRIPTION
   Pure Dart immutable entity with no Flutter or infrastructure dependency.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Data model → domain entity → presentation.

6. DYNAMIC COMPONENTS
   Contact identity, languages, availability, favorite state, and interaction.

7. FUTURE BACKEND INTEGRATION
   A model-to-entity mapper can later populate this entity from the
   application's contacts repository.

8. TECHNOLOGIES USED
   Pure Dart.

9. REQUIRED DATA MODELS
   ContactFeatureEntity.

10. FUTURE API ENDPOINTS
    Not specified.

11. DATABASE COLLECTIONS/TABLES
    Not specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Presentation layer handles accessibility.

17. EDGE CASES
    Optional interaction information.

18. VALIDATION RULES
    Contact ID, name, and initials are required.

19. ERROR HANDLING
    Validation is outside the current UI-only domain scope.

20. LOADING STATE
    Not represented by the entity.

21. EMPTY STATE
    Represented by an empty collection.

22. OFFLINE BEHAVIOUR
    Availability is descriptive UI data only.

23. SECURITY CONSIDERATIONS
    No sensitive information is represented.

24. PERFORMANCE OPTIMIZATIONS
    Immutable final fields.

25. WIDGET TREE OVERVIEW
    Entity → controller → presentation widgets.

26. COMPLETE TESTING CHECKLIST
    Verify conversion and presentation of all entity properties.
*/

class ContactFeatureEntity {
  const ContactFeatureEntity({
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
