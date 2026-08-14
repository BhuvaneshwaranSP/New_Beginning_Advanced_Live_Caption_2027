/*
1. PAGE NAME
   Authentication Feature Entity

2. PURPOSE
   Defines immutable domain-level authentication UI configuration.

3. DESCRIPTION
   Contains pure Dart business-facing data without Flutter dependencies.

4. UI SECTIONS
   Authentication mode and application identity.

5. NAVIGATION FLOW
   Data model → domain entity → presentation controller/page.

6. DYNAMIC COMPONENTS
   Authentication mode and supported languages.

7. FUTURE BACKEND INTEGRATION
   Future authentication results can be represented by additional domain
   entities once the project's authentication contract is formally defined.

8. TECHNOLOGIES USED
   Pure Dart.

9. REQUIRED DATA MODELS
   AuthenticationFeatureEntity.

10. FUTURE API ENDPOINTS
    Not defined by the supplied documentation.

11. DATABASE COLLECTIONS/TABLES
    Not defined by the supplied documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    Not applicable.

15. ANIMATIONS
    Not applicable.

16. ACCESSIBILITY
    Domain values are independent of presentation semantics.

17. EDGE CASES
    Empty supported language collection.

18. VALIDATION RULES
    Entity values are immutable.

19. ERROR HANDLING
    No external errors are handled here.

20. LOADING STATE
    Not represented by this entity.

21. EMPTY STATE
    Not represented by this entity.

22. OFFLINE BEHAVIOUR
    Entity remains usable without connectivity.

23. SECURITY CONSIDERATIONS
    No credential information is stored.

24. PERFORMANCE OPTIMIZATIONS
    Immutable fields and defensive list copying.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify immutable entity creation and defensive collection copying.
*/

import '../../data/models/authentication_feature_model.dart';

class AuthenticationFeatureEntity {
  const AuthenticationFeatureEntity({
    required this.appName,
    required this.tagline,
    required this.supportedLanguages,
    required this.initialMode,
  });

  final String appName;
  final String tagline;
  final List<String> supportedLanguages;
  final AuthenticationMode initialMode;

  factory AuthenticationFeatureEntity.fromModel(
    AuthenticationFeatureModel model,
  ) {
    return AuthenticationFeatureEntity(
      appName: model.appName,
      tagline: model.tagline,
      supportedLanguages: List<String>.unmodifiable(model.supportedLanguages),
      initialMode: model.initialMode,
    );
  }
}
