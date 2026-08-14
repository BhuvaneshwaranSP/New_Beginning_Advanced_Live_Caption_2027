/*
1. PAGE NAME
   Onboarding Feature

2. PURPOSE
   Public entry point for the LinguaLive onboarding feature.

3. DESCRIPTION
   Exposes the onboarding presentation page and its supporting feature-layer
   components through a single feature barrel file.

4. UI SECTIONS
   The feature contains the onboarding page, language-selection content,
   progress indicators, and onboarding action controls.

5. NAVIGATION FLOW
   Application start → Onboarding → Source & Target Language Selection →
   next application flow.

6. DYNAMIC COMPONENTS
   Onboarding slides, source language, target language, language cards,
   selection state, and progress indicator.

7. FUTURE BACKEND INTEGRATION
   The selected language preferences can later be connected to the intended
   application initialization/session configuration flow.

8. TECHNOLOGIES USED
   Dart and Flutter Material 3.

9. REQUIRED DATA MODELS
   OnboardingLanguageModel and OnboardingEntity.

10. FUTURE API ENDPOINTS
    None specified by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    None specified by the supplied project documentation.

12. REQUIRED ASSETS
    No mandatory asset is required by this UI implementation.

13. REQUIRED ICONS
    Material language, translate, swap, and navigation icons.

14. THEME COLORS
    Uses the application's Material 3 ColorScheme.

15. ANIMATIONS
    Lightweight page transitions and selection animations.

16. ACCESSIBILITY
    Semantic labels, readable text, adequate touch targets, and color-independent
    selection indicators.

17. EDGE CASES
    Long language names, small displays, large text, and identical language
    selections.

18. VALIDATION RULES
    Source and target languages must be different before continuing.

19. ERROR HANDLING
    Invalid local selection is represented through inline validation messaging.

20. LOADING STATE
    Not required for the UI-only implementation.

21. EMPTY STATE
    Not required because the screen uses a local supported-language list.

22. OFFLINE BEHAVIOUR
    The onboarding UI remains usable because all displayed data is local.

23. SECURITY CONSIDERATIONS
    No credentials, personal data, or network data are handled.

24. PERFORMANCE OPTIMIZATIONS
    Const widgets, local immutable dummy data, and lightweight implicit animations.

25. WIDGET TREE OVERVIEW
    OnboardingPage
      └── SafeArea
          └── LayoutBuilder
              └── CustomScrollView
                  ├── Header
                  ├── Page indicator
                  ├── Language selection cards
                  ├── Swap control
                  └── Continue button

26. COMPLETE TESTING CHECKLIST
    Validate responsiveness, accessibility, language selection, validation,
    theme behavior, text scaling, navigation callbacks, and analyzer cleanliness.
*/

export 'presentation/pages/onboarding_page.dart';
export 'presentation/controllers/onboarding_controller.dart';
export 'presentation/widgets/onboarding_header.dart';
export 'presentation/widgets/language_selection_card.dart';
export 'presentation/widgets/onboarding_progress.dart';
export 'presentation/widgets/onboarding_states.dart';
