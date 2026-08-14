/*
1. PAGE NAME
   Translation Feature Barrel

2. PURPOSE
   Provides the public exports for the LinguaLive Translation feature.

3. DESCRIPTION
   Exposes the Translation page and feature-level presentation entry point.

4. UI SECTIONS
   Translation page, language pair selection, source input, translated result,
   and translation state feedback.

5. NAVIGATION FLOW
   Home/other LinguaLive entry point → Translation page.
   Future translation sessions may continue to history or communication flows.

6. DYNAMIC COMPONENTS
   Translation language pair, source text, translated text, confidence/status,
   and local UI state.

7. FUTURE BACKEND INTEGRATION
   The page will later connect to the translation pipeline documented by the
   project flow. No backend functionality is implemented here.

8. TECHNOLOGIES USED
   Flutter Material 3 and Dart only.

9. REQUIRED DATA MODELS
   TranslationEntity and TranslationModel.

10. FUTURE API ENDPOINTS
    Not specified by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified by the supplied project documentation.

12. REQUIRED ASSETS
    No dedicated assets required by this feature.

13. REQUIRED ICONS
    Material language, swap, translate, clear, microphone, and content-copy icons.

14. THEME COLORS
    Uses the application's Material 3 ColorScheme.

15. ANIMATIONS
    Lightweight implicit transitions for translation result/state changes.

16. ACCESSIBILITY
    Semantic labels, readable contrast, keyboard navigation, and large-text support.

17. EDGE CASES
    Empty source text, long text, unsupported language combinations, processing,
    translation failure, and offline representation.

18. VALIDATION RULES
    Translation requires non-empty source content in the UI demonstration.

19. ERROR HANDLING
    Local dummy error state only.

20. LOADING STATE
    Local processing representation.

21. EMPTY STATE
    Empty translation result before a translation is requested.

22. OFFLINE BEHAVIOUR
    Local offline representation only; no connectivity detection is implemented.

23. SECURITY CONSIDERATIONS
    No network, persistence, authentication, or sensitive-data processing is implemented.

24. PERFORMANCE OPTIMIZATIONS
    Const widgets, local state, lightweight models, and limited rebuild scope.

25. WIDGET TREE OVERVIEW
    TranslationPage
      → AppBar/Header
      → LanguagePairSelector
      → TranslationInputCard
      → TranslationResultCard
      → TranslationStates

26. COMPLETE TESTING CHECKLIST
    See the project-level Translation test checklist supplied with this feature.
*/

export 'data/models/translation_model.dart';
export 'data/data_sources/mock_translation_data_source.dart';
export 'data/dummy/translation_dummy_data.dart';
export 'domain/entities/translation_entity.dart';
export 'presentation/controllers/translation_controller.dart';
export 'presentation/pages/translation_page.dart';
export 'presentation/widgets/language_pair_selector.dart';
export 'presentation/widgets/translation_header.dart';
export 'presentation/widgets/translation_input_card.dart';
export 'presentation/widgets/translation_result_card.dart';
export 'presentation/widgets/translation_states.dart';
