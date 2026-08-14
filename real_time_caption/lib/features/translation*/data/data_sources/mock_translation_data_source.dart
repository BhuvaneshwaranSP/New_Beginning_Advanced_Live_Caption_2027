/*
1. PAGE NAME
   Mock Translation Data Source

2. PURPOSE
   Provides local-only translation data for UI development.

3. DESCRIPTION
   Simulates a translation data source without networking, APIs, Firebase,
   persistence, or real AI inference.

4. UI SECTIONS
   Translation result and local processing demonstration.

5. NAVIGATION FLOW
   Translation controller → MockTranslationDataSource → TranslationModel.

6. DYNAMIC COMPONENTS
   Source/target languages, translated text, confidence, and status.

7. FUTURE BACKEND INTEGRATION
   Future: replace this local source with the project's translation pipeline,
   using NLLB-200 Distilled followed by Gemma contextual/grammar correction.

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
    Returned text is presented through accessible UI widgets.

17. EDGE CASES
    Unknown language pair and unknown source text.

18. VALIDATION RULES
    Empty source input produces an empty result.

19. ERROR HANDLING
    Unknown demonstration text produces a local error model.

20. LOADING STATE
    Loading is controlled by the presentation controller.

21. EMPTY STATE
    Empty model is available.

22. OFFLINE BEHAVIOUR
    No actual connectivity is checked.

23. SECURITY CONSIDERATIONS
    No external data transmission.

24. PERFORMANCE OPTIMIZATIONS
    Synchronous local lookup with small immutable collections.

25. WIDGET TREE OVERVIEW
    Controller → data source → model → entity → result widget.

26. COMPLETE TESTING CHECKLIST
    Verify known pairs, unknown pairs, empty input, and fallback handling.
*/

import '../dummy/translation_dummy_data.dart';
import '../models/translation_model.dart';
import '../../domain/entities/translation_entity.dart';

class MockTranslationDataSource {
  const MockTranslationDataSource();

  TranslationModel translate({
    required String sourceLanguageCode,
    required String targetLanguageCode,
    required String sourceText,
  }) {
    final normalizedText = sourceText.trim();

    if (normalizedText.isEmpty) {
      return const TranslationModel(
        sourceLanguageCode: 'en',
        sourceLanguageName: 'English',
        targetLanguageCode: 'ta',
        targetLanguageName: 'Tamil',
        sourceText: '',
        translatedText: '',
        status: TranslationStatus.empty,
        confidence: 0,
      );
    }

    final sourceLanguage = translationLanguages.firstWhere(
      (language) => language.code == sourceLanguageCode,
      orElse: () => translationLanguages.first,
    );

    final targetLanguage = translationLanguages.firstWhere(
      (language) => language.code == targetLanguageCode,
      orElse: () => translationLanguages[1],
    );

    final pair = translationExamples[sourceLanguageCode];
    final knownTranslation = pair?[targetLanguageCode];

    if (knownTranslation == null) {
      return TranslationModel(
        sourceLanguageCode: sourceLanguage.code,
        sourceLanguageName: sourceLanguage.name,
        targetLanguageCode: targetLanguage.code,
        targetLanguageName: targetLanguage.name,
        sourceText: normalizedText,
        translatedText: 'Demo translation unavailable for this language pair.',
        status: TranslationStatus.error,
        confidence: 0,
      );
    }

    return TranslationModel(
      sourceLanguageCode: sourceLanguage.code,
      sourceLanguageName: sourceLanguage.name,
      targetLanguageCode: targetLanguage.code,
      targetLanguageName: targetLanguage.name,
      sourceText: normalizedText,
      translatedText: knownTranslation,
      status: TranslationStatus.success,
      confidence: 0.94,
    );
  }
}