/*
1. PAGE NAME
   Onboarding Dummy Data

2. PURPOSE
   Supplies deterministic local language data for the onboarding UI.

3. DESCRIPTION
   Contains realistic multilingual language choices aligned with LinguaLive's
   multilingual communication purpose.

4. UI SECTIONS
   Source and target language selection.

5. NAVIGATION FLOW
   Dummy data → mock data source → controller → onboarding page.

6. DYNAMIC COMPONENTS
   Language selection list.

7. FUTURE BACKEND INTEGRATION
   Replace this local source with the project's supported-language configuration
   when the application data layer is connected.

8. TECHNOLOGIES USED
   Pure Dart.

9. REQUIRED DATA MODELS
   OnboardingLanguageModel.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    None specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Unicode language symbols are used as lightweight local display markers.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Each item contains an English and native-language label.

17. EDGE CASES
    Long native names and multilingual scripts.

18. VALIDATION RULES
    Every language contains a non-empty code and display name.

19. ERROR HANDLING
    Invalid data is not included.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Data remains available offline.

23. SECURITY CONSIDERATIONS
    No user information.

24. PERFORMANCE OPTIMIZATIONS
    Compile-time constant list.

25. WIDGET TREE OVERVIEW
    LanguageSelectionCard consumes each model.

26. COMPLETE TESTING CHECKLIST
    Verify all languages render correctly under supported text scaling.
*/

import '../models/onboarding_feature_model.dart';

const List<OnboardingLanguageModel> onboardingLanguages =
    <OnboardingLanguageModel>[
      OnboardingLanguageModel(
        code: 'en',
        name: 'English',
        nativeName: 'English',
        icon: 'A',
      ),
      OnboardingLanguageModel(
        code: 'ta',
        name: 'Tamil',
        nativeName: 'தமிழ்',
        icon: 'அ',
      ),
      OnboardingLanguageModel(
        code: 'te',
        name: 'Telugu',
        nativeName: 'తెలుగు',
        icon: 'తె',
      ),
      OnboardingLanguageModel(
        code: 'hi',
        name: 'Hindi',
        nativeName: 'हिन्दी',
        icon: 'हि',
      ),
      OnboardingLanguageModel(
        code: 'ml',
        name: 'Malayalam',
        nativeName: 'മലയാളം',
        icon: 'മ',
      ),
      OnboardingLanguageModel(
        code: 'es',
        name: 'Spanish',
        nativeName: 'Español',
        icon: 'Ñ',
      ),
      OnboardingLanguageModel(
        code: 'fr',
        name: 'French',
        nativeName: 'Français',
        icon: 'F',
      ),
      OnboardingLanguageModel(
        code: 'de',
        name: 'German',
        nativeName: 'Deutsch',
        icon: 'D',
      ),
    ];
