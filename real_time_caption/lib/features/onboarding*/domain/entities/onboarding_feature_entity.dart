/*
1. PAGE NAME
   Onboarding Feature Entity

2. PURPOSE
   Defines the domain representation of an onboarding language.

3. DESCRIPTION
   Pure Dart immutable entity used independently of Flutter widgets.

4. UI SECTIONS
   Language selection.

5. NAVIGATION FLOW
   Data model → domain entity → presentation controller.

6. DYNAMIC COMPONENTS
   Language identity and display labels.

7. FUTURE BACKEND INTEGRATION
   Future data mappers can convert remote language records into this entity
   without coupling the UI to infrastructure.

8. TECHNOLOGIES USED
   Pure Dart.

9. REQUIRED DATA MODELS
   OnboardingEntity.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    None specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Native language name supports multilingual comprehension.

17. EDGE CASES
    Long names and multilingual Unicode scripts.

18. VALIDATION RULES
    Code and name must be non-empty.

19. ERROR HANDLING
    Invalid construction is prevented with assertions.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Fully local.

23. SECURITY CONSIDERATIONS
    Contains no sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Immutable final fields.

25. WIDGET TREE OVERVIEW
    Entity → controller → presentation widgets.

26. COMPLETE TESTING CHECKLIST
    Verify valid construction and equality-independent rendering.
*/

class OnboardingEntity {
  const OnboardingEntity({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.icon,
  }) : assert(code != ''),
       assert(name != ''),
       assert(nativeName != '');

  final String code;
  final String name;
  final String nativeName;
  final String icon;
}
