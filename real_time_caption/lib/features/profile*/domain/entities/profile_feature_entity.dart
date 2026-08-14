/*
1. PAGE NAME
   Profile Feature Domain Entity

2. PURPOSE
   Defines the immutable domain representation of a LinguaLive user profile.

3. DESCRIPTION
   Contains pure Dart data without Flutter or infrastructure dependencies.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Profile presentation → Profile domain entity.

6. DYNAMIC COMPONENTS
   Display name, email, preferred language, target language, and profile status.

7. FUTURE BACKEND INTEGRATION
   A repository implementation can later map persisted account/profile data
   into this entity.

8. TECHNOLOGIES USED
   Pure Dart.

9. REQUIRED DATA MODELS
   ProfileFeatureEntity.

10. FUTURE API ENDPOINTS
    Not specified by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified by the supplied project documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    Not applicable.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Presentation responsibility.

17. EDGE CASES
    Optional values are represented as nullable strings where appropriate.

18. VALIDATION RULES
    No persistence validation is implemented.

19. ERROR HANDLING
    Not applicable.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Represented by null-safe optional values.

22. OFFLINE BEHAVIOUR
    Entity is independent of connectivity.

23. SECURITY CONSIDERATIONS
    No authentication credentials or tokens are represented.

24. PERFORMANCE OPTIMIZATIONS
    Immutable const-compatible entity.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify construction, equality, null handling, and conversion behavior.
*/

class ProfileFeatureEntity {
  const ProfileFeatureEntity({
    required this.displayName,
    required this.email,
    required this.preferredLanguage,
    required this.targetLanguage,
    required this.statusLabel,
    required this.initials,
  });

  final String displayName;
  final String email;
  final String preferredLanguage;
  final String targetLanguage;
  final String statusLabel;
  final String initials;
}
