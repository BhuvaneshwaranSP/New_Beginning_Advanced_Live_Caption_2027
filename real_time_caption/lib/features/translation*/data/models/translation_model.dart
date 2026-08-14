/*
1. PAGE NAME
   Translation Data Model

2. PURPOSE
   Represents translation data used by the mock data source and presentation layer.

3. DESCRIPTION
   Provides a lightweight data model that can be converted into a domain entity.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Mock source → TranslationModel → TranslationEntity → Translation UI.

6. DYNAMIC COMPONENTS
   Source language, target language, source text, translated text, confidence,
   and translation status.

7. FUTURE BACKEND INTEGRATION
   Future translation service responses can be mapped into this model.

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
    Data is exposed through descriptive text fields.

17. EDGE CASES
    Empty source or translated text.

18. VALIDATION RULES
    Presentation layer handles source text validation.

19. ERROR HANDLING
    TranslationStatus supports local UI error representation.

20. LOADING STATE
    TranslationStatus.processing.

21. EMPTY STATE
    TranslationStatus.empty.

22. OFFLINE BEHAVIOUR
    TranslationStatus.offline.

23. SECURITY CONSIDERATIONS
    Dummy data only.

24. PERFORMANCE OPTIMIZATIONS
    Immutable model and simple conversion.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify model construction and entity conversion for every status.
*/

import '../../domain/entities/translation_entity.dart';

class TranslationModel {
  const TranslationModel({
    required this.sourceLanguageCode,
    required this.sourceLanguageName,
    required this.targetLanguageCode,
    required this.targetLanguageName,
    required this.sourceText,
    required this.translatedText,
    required this.status,
    required this.confidence,
  });

  final String sourceLanguageCode;
  final String sourceLanguageName;
  final String targetLanguageCode;
  final String targetLanguageName;
  final String sourceText;
  final String translatedText;
  final TranslationStatus status;
  final double confidence;

  TranslationEntity toEntity() {
    return TranslationEntity(
      sourceLanguageCode: sourceLanguageCode,
      sourceLanguageName: sourceLanguageName,
      targetLanguageCode: targetLanguageCode,
      targetLanguageName: targetLanguageName,
      sourceText: sourceText,
      translatedText: translatedText,
      status: status,
      confidence: confidence,
    );
  }
}
