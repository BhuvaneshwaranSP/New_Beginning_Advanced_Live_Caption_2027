/*
1. PAGE NAME
   Transcription Data Model

2. PURPOSE
   Represents transcription data at the data layer.

3. DESCRIPTION
   Maps transcription records into the domain entity used by the UI.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Mock data source → TranscriptionModel → TranscriptionEntity → UI.

6. DYNAMIC COMPONENTS
   Transcript segments and session metadata.

7. FUTURE BACKEND INTEGRATION
   Future speech-recognition and streaming responses can be mapped here.

8. TECHNOLOGIES USED
   Pure Dart.

9. REQUIRED DATA MODELS
   TranscriptionEntity.

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
    Text data remains plain and semantic.

17. EDGE CASES
    Empty text and optional confidence values.

18. VALIDATION RULES
    Immutable non-null required fields.

19. ERROR HANDLING
    No external errors are handled here.

20. LOADING STATE
    Managed by presentation/controller layers.

21. EMPTY STATE
    Managed by presentation/controller layers.

22. OFFLINE BEHAVIOUR
    Data source remains local during UI-only development.

23. SECURITY CONSIDERATIONS
    No persistent or sensitive data storage.

24. PERFORMANCE OPTIMIZATIONS
    Immutable model and direct entity conversion.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Validate entity conversion and null-safe values.
*/

import '../../domain/entities/transcription_entity.dart';

class TranscriptionModel {
  const TranscriptionModel({
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

  TranscriptionEntity toEntity() {
    return TranscriptionEntity(
      id: id,
      speakerName: speakerName,
      languageCode: languageCode,
      originalText: originalText,
      translatedText: translatedText,
      timestamp: timestamp,
      confidence: confidence,
      isFinal: isFinal,
    );
  }
}
