/*
1. PAGE NAME
   Authentication Feature Model

2. PURPOSE
   Represents local authentication UI data.

3. DESCRIPTION
   A Flutter-independent data model used by the authentication dummy data source.

4. UI SECTIONS
   Branding and authentication form configuration.

5. NAVIGATION FLOW
   Data source → model → entity/controller → authentication presentation.

6. DYNAMIC COMPONENTS
   Application name, tagline, supported languages, and initial authentication mode.

7. FUTURE BACKEND INTEGRATION
   A real authentication response model can later be mapped into the feature
   domain layer without changing the presentation model contract.

8. TECHNOLOGIES USED
   Pure Dart.

9. REQUIRED DATA MODELS
   AuthenticationFeatureModel.

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
    Text values remain compatible with scalable Flutter typography.

17. EDGE CASES
    Empty language lists and long application/tagline text.

18. VALIDATION RULES
    Model values are immutable.

19. ERROR HANDLING
    No external errors are handled by this model.

20. LOADING STATE
    Not represented here.

21. EMPTY STATE
    An empty language list is allowed.

22. OFFLINE BEHAVIOUR
    Dummy data remains locally available.

23. SECURITY CONSIDERATIONS
    No credentials are represented.

24. PERFORMANCE OPTIMIZATIONS
    Immutable const-compatible data where practical.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify model construction with normal, empty, and long text values.
*/

class AuthenticationFeatureModel {
  const AuthenticationFeatureModel({
    required this.appName,
    required this.tagline,
    required this.supportedLanguages,
    required this.initialMode,
  });

  final String appName;
  final String tagline;
  final List<String> supportedLanguages;
  final AuthenticationMode initialMode;

  AuthenticationFeatureModel copyWith({
    String? appName,
    String? tagline,
    List<String>? supportedLanguages,
    AuthenticationMode? initialMode,
  }) {
    return AuthenticationFeatureModel(
      appName: appName ?? this.appName,
      tagline: tagline ?? this.tagline,
      supportedLanguages:
          supportedLanguages ?? List<String>.of(this.supportedLanguages),
      initialMode: initialMode ?? this.initialMode,
    );
  }
}

enum AuthenticationMode { signIn, createAccount }
