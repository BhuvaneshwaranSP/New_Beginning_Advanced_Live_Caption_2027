/*
1. PAGE NAME
   Translation Dummy Data

2. PURPOSE
   Supplies realistic multilingual local data for the Translation UI.

3. DESCRIPTION
   Contains supported demonstration languages and sample translation content.
   No external service is accessed.

4. UI SECTIONS
   Language selector and translation source/result cards.

5. NAVIGATION FLOW
   Dummy data → Mock data source → Translation controller → Translation page.

6. DYNAMIC COMPONENTS
   Language options and demonstration translation result.

7. FUTURE BACKEND INTEGRATION
   Replace local demonstration results with the project's documented
   NLLB-200 Distilled translation pipeline and contextual correction stage.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   TranslationModel.

10. FUTURE API ENDPOINTS
    Not specified by source documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified by source documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Language names and codes are text-based rather than color-dependent.

17. EDGE CASES
    Empty input, long input, and unsupported language pair representation.

18. VALIDATION RULES
    Demonstration translation requires non-empty input.

19. ERROR HANDLING
    Mock error content is available through the controller.

20. LOADING STATE
    Controller creates a local processing state.

21. EMPTY STATE
    Initial empty state.

22. OFFLINE BEHAVIOUR
    Local demonstration can represent offline availability without real detection.

23. SECURITY CONSIDERATIONS
    No personal or sensitive data.

24. PERFORMANCE OPTIMIZATIONS
    Small immutable constant collections.

25. WIDGET TREE OVERVIEW
    LanguagePairSelector → TranslationInputCard → TranslationResultCard.

26. COMPLETE TESTING CHECKLIST
    Verify all languages render and long language names do not overflow.
*/

class TranslationLanguageDummy {
  const TranslationLanguageDummy({
    required this.code,
    required this.name,
    required this.nativeName,
  });

  final String code;
  final String name;
  final String nativeName;
}

const List<TranslationLanguageDummy> translationLanguages = [
  TranslationLanguageDummy(code: 'en', name: 'English', nativeName: 'English'),
  TranslationLanguageDummy(code: 'ta', name: 'Tamil', nativeName: 'தமிழ்'),
  TranslationLanguageDummy(code: 'te', name: 'Telugu', nativeName: 'తెలుగు'),
  TranslationLanguageDummy(code: 'hi', name: 'Hindi', nativeName: 'हिन्दी'),
  TranslationLanguageDummy(code: 'ml', name: 'Malayalam', nativeName: 'മലയാളം'),
  TranslationLanguageDummy(code: 'es', name: 'Spanish', nativeName: 'Español'),
  TranslationLanguageDummy(code: 'fr', name: 'French', nativeName: 'Français'),
  TranslationLanguageDummy(code: 'de', name: 'German', nativeName: 'Deutsch'),
];

const Map<String, Map<String, String>> translationExamples = {
  'en': {
    'ta': 'வணக்கம்! இன்று எப்படி இருக்கிறீர்கள்?',
    'te': 'నమస్కారం! ఈ రోజు మీరు ఎలా ఉన్నారు?',
    'hi': 'नमस्ते! आज आप कैसे हैं?',
    'ml': 'നമസ്കാരം! ഇന്ന് എങ്ങനെയുണ്ട്?',
    'es': '¡Hola! ¿Cómo estás hoy?',
    'fr': 'Bonjour ! Comment allez-vous aujourd’hui?',
    'de': 'Hallo! Wie geht es Ihnen heute?',
  },
  'ta': {'en': 'Hello! How are you today?'},
  'te': {'en': 'Hello! How are you today?'},
  'hi': {'en': 'Hello! How are you today?'},
  'ml': {'en': 'Hello! How are you today?'},
  'es': {'en': 'Hello! How are you today?'},
  'fr': {'en': 'Hello! How are you today?'},
  'de': {'en': 'Hello! How are you today?'},
};

const String defaultTranslationInput = 'Hello! How are you today?';
