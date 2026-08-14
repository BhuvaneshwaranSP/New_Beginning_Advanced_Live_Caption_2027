/*
1. PAGE NAME
   Translation Domain Entity

2. PURPOSE
   Defines the immutable domain object used by the Translation feature.

3. DESCRIPTION
   Represents a source/target language pair and its translated content without
   Flutter or infrastructure dependencies.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Translation data model → Translation entity → presentation.

6. DYNAMIC COMPONENTS
   Language metadata, source text, translated text, confidence, and status.

7. FUTURE BACKEND INTEGRATION
   Future translation responses will be mapped into this domain representation.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   TranslationModel maps into TranslationEntity.

10. FUTURE API ENDPOINTS
    Not specified by project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified by project documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Entity fields are exposed as semantic-friendly display values.

17. EDGE CASES
    Empty strings are permitted for representing empty UI states.

18. VALIDATION RULES
    Source text is validated by the presentation/controller layer.

19. ERROR HANDLING
    TranslationStatus represents UI-level processing outcomes.

20. LOADING STATE
    Represented by TranslationStatus.processing.

21. EMPTY STATE
    Represented by TranslationStatus.empty.

22. OFFLINE BEHAVIOUR
    Represented by TranslationStatus.offline.

23. SECURITY CONSIDERATIONS
    Contains no credentials or persistent sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Immutable fields and const constructor.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify equality, immutable construction, empty values, and status mapping.
*/

enum TranslationStatus { empty, processing, success, error, offline }

class TranslationEntity {
  const TranslationEntity({
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
}
