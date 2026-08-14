/*
1. PAGE NAME
   Chat Feature Data Model

2. PURPOSE
   Defines the data representation used by the Chat feature.

3. DESCRIPTION
   Maps local data-source values into the Chat domain entity.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Mock data source → ChatFeatureModel → ChatFeatureEntity → presentation.

6. DYNAMIC COMPONENTS
   Message text, translation, language pair, timestamp, status, and confidence.

7. FUTURE BACKEND INTEGRATION
   Future: map real chat-session and multilingual translation responses into
   this model before converting them into the domain entity.

8. TECHNOLOGIES USED
   Pure Dart.

9. REQUIRED DATA MODELS
   ChatFeatureModel and ChatFeatureEntity.

10. FUTURE API ENDPOINTS
    Not specified in supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified in supplied project documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Not applicable at data-model level.

17. EDGE CASES
    Empty text, long text, unavailable translation, and offline status.

18. VALIDATION RULES
    None at model level.

19. ERROR HANDLING
    Status is passed through to the domain entity.

20. LOADING STATE
    Not represented by an individual message.

21. EMPTY STATE
    Represented by an empty collection.

22. OFFLINE BEHAVIOUR
    Supported through ChatMessageStatus.offline.

23. SECURITY CONSIDERATIONS
    No credentials or authentication data are stored.

24. PERFORMANCE OPTIMIZATIONS
    Immutable final fields.

25. WIDGET TREE OVERVIEW
    Model → Entity → Controller → UI.

26. COMPLETE TESTING CHECKLIST
    Verify all message statuses, multilingual text, confidence values,
    empty strings, and model-to-entity conversion.
*/

import '../../domain/entities/chat_feature_entity.dart';

class ChatFeatureModel {
  const ChatFeatureModel({
    required this.id,
    required this.senderName,
    required this.isMine,
    required this.originalText,
    required this.translatedText,
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.timestamp,
    required this.status,
    this.confidence,
  });

  final String id;
  final String senderName;
  final bool isMine;
  final String originalText;
  final String translatedText;
  final String sourceLanguage;
  final String targetLanguage;
  final String timestamp;

  // Uses the single ChatMessageStatus definition from the domain layer.
  final ChatMessageStatus status;

  final double? confidence;

  ChatFeatureEntity toEntity() {
    return ChatFeatureEntity(
      id: id,
      senderName: senderName,
      isMine: isMine,
      originalText: originalText,
      translatedText: translatedText,
      sourceLanguage: sourceLanguage,
      targetLanguage: targetLanguage,
      timestamp: timestamp,
      status: status,
      confidence: confidence,
    );
  }
}
