/*
1. PAGE NAME
   Mock Authentication Data Source

2. PURPOSE
   Supplies local dummy configuration for the authentication UI.

3. DESCRIPTION
   Replaces future remote authentication configuration during UI development.

4. UI SECTIONS
   Branding and authentication mode configuration.

5. NAVIGATION FLOW
   Mock source → AuthenticationFeatureModel → authentication page.

6. DYNAMIC COMPONENTS
   Initial authentication mode and multilingual application metadata.

7. FUTURE BACKEND INTEGRATION
   Replace this local source with the authentication service/configuration
   source when the project's authentication architecture is defined.

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
    Provides readable multilingual labels.

17. EDGE CASES
    Empty language configuration.

18. VALIDATION RULES
    No credential validation occurs here.

19. ERROR HANDLING
    No external errors are possible in this local source.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Dummy configuration is available without connectivity.

23. SECURITY CONSIDERATIONS
    No real credentials or authentication tokens are included.

24. PERFORMANCE OPTIMIZATIONS
    Static local data avoids unnecessary allocations.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify dummy configuration loads without external dependencies.
*/

import '../models/authentication_feature_model.dart';

class MockAuthenticationDataSource {
  const MockAuthenticationDataSource();

  AuthenticationFeatureModel loadConfiguration() {
    return const AuthenticationFeatureModel(
      appName: 'LinguaLive',
      tagline: 'Connect across languages. Communicate naturally.',
      supportedLanguages: <String>[
        'English',
        'தமிழ்',
        'తెలుగు',
        'हिन्दी',
        'മലയാളം',
      ],
      initialMode: AuthenticationMode.signIn,
    );
  }
}
