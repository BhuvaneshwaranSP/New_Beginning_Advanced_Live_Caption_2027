/*
1. PAGE NAME
   Authentication Dummy Data

2. PURPOSE
   Contains realistic local data used to preview the authentication experience.

3. DESCRIPTION
   Keeps sample multilingual content separate from widgets.

4. UI SECTIONS
   Authentication branding and supporting language information.

5. NAVIGATION FLOW
   Dummy data → mock data source → authentication presentation.

6. DYNAMIC COMPONENTS
   Application language examples and supporting copy.

7. FUTURE BACKEND INTEGRATION
   No backend integration belongs in this file.

8. TECHNOLOGIES USED
   Pure Dart.

9. REQUIRED DATA MODELS
   List<String>.

10. FUTURE API ENDPOINTS
    None defined.

11. DATABASE COLLECTIONS/TABLES
    None defined.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    Not applicable.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Language names use their native scripts where appropriate.

17. EDGE CASES
    Empty or extended language lists.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    None.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Fully local.

23. SECURITY CONSIDERATIONS
    Contains no personal or credential data.

24. PERFORMANCE OPTIMIZATIONS
    Compile-time constant data.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify multilingual strings render correctly under large text settings.
*/

const List<String> authenticationLanguageSamples = <String>[
  'English',
  'தமிழ்',
  'తెలుగు',
  'हिन्दी',
  'മലയാളം',
];

const String authenticationWelcomeTitle = 'Welcome to LinguaLive';

const String authenticationWelcomeDescription =
    'One place for clearer multilingual communication.';
