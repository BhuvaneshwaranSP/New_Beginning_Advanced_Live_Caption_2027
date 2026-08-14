/*
1. PAGE NAME
   Onboarding Feature Model

2. PURPOSE
   Defines the data model used by the onboarding presentation layer.

3. DESCRIPTION
   Represents a supported language shown during the UI-only onboarding flow.

4. UI SECTIONS
   Language selection.

5. NAVIGATION FLOW
   Model → onboarding data source → controller → onboarding page.

6. DYNAMIC COMPONENTS
   Language name, native name, language code, and display icon.

7. FUTURE BACKEND INTEGRATION
   This model can later map to supported-language configuration supplied by
   the application's language service.

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
    Material language icon.

14. THEME COLORS
    None embedded in the model.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Native language names provide additional linguistic context.

17. EDGE CASES
    Long language names and missing optional display metadata.

18. VALIDATION RULES
    Language code must identify a non-empty supported language.

19. ERROR HANDLING
    Invalid records are excluded from the dummy source.

20. LOADING STATE
    Not represented by this model.

21. EMPTY STATE
    Not represented by this model.

22. OFFLINE BEHAVIOUR
    Model is local and does not require connectivity.

23. SECURITY CONSIDERATIONS
    No personal information.

24. PERFORMANCE OPTIMIZATIONS
    Immutable final fields.

25. WIDGET TREE OVERVIEW
    Consumed by language-selection widgets.

26. COMPLETE TESTING CHECKLIST
    Verify immutable data and safe rendering of all supported language names.
*/

class OnboardingLanguageModel {
  const OnboardingLanguageModel({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.icon,
  });

  final String code;
  final String name;
  final String nativeName;
  final String icon;
}
