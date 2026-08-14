/*
1. PAGE NAME
   Transcription Domain Entity

2. PURPOSE
   Defines the domain representation of a transcription segment.

3. DESCRIPTION
   Pure Dart immutable entity independent of Flutter and infrastructure.

4. UI SECTIONS
   Transcript segment content.

5. NAVIGATION FLOW
   Data model → entity → controller → presentation.

6. DYNAMIC COMPONENTS
   Speaker, language, original text, translation, confidence, timestamp.

7. FUTURE BACKEND INTEGRATION
   Future ASR and translation outputs will be represented by this entity.

8. TECHNOLOGIES USED
   Pure Dart.

9. REQUIRED DATA MODELS
   TranscriptionModel converts into this entity.

10. FUTURE API ENDPOINTS
    Not defined.

11. DATABASE COLLECTIONS/TABLES
    Not defined.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    Not applicable.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Text fields remain semantic.

17. EDGE CASES
    Long multilingual strings and confidence variations.

18. VALIDATION RULES
    Confidence is expected between 0 and 1.

19. ERROR HANDLING
    No infrastructure errors.

20. LOADING STATE
    Not represented here.

21. EMPTY STATE
    Represented by an empty entity collection.

22. OFFLINE BEHAVIOUR
    Entity has no connectivity dependency.

23. SECURITY CONSIDERATIONS
    No persistence or raw audio handling.

24. PERFORMANCE OPTIMIZATIONS
    Immutable final fields.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify entity construction with realistic multilingual values.
*/

class TranscriptionEntity {
  const TranscriptionEntity({
    required this.id,
    required this.speakerName,
    required this.languageCode,
    required this.originalText,
    required this.translatedText,
    required this.timestamp,
    required this.confidence,
    required this.isFinal,
  });

  final String id;
  final String speakerName;
  final String languageCode;
  final String originalText;
  final String translatedText;
  final String timestamp;
  final double confidence;
  final bool isFinal;
}
