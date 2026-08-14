/*
1. PAGE NAME
   Chat Feature Domain Entity

2. PURPOSE
   Defines the immutable domain representation of a LinguaLive chat message
   and its message delivery/translation status.

3. DESCRIPTION
   Contains pure Dart domain-level objects without Flutter dependencies.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Data model → domain entity → presentation controller.

6. DYNAMIC COMPONENTS
   Message text, translation, language pair, speaker, timestamp, status,
   and translation confidence.

7. FUTURE BACKEND INTEGRATION
   Future: map real spoken-conversation, translation, delivery, and streaming
   results into this domain representation.

8. TECHNOLOGIES USED
   Pure Dart.

9. REQUIRED DATA MODELS
   ChatFeatureEntity.

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
    Presentation widgets provide semantic descriptions.

17. EDGE CASES
    Empty and long text, unavailable translation, translating state,
    and offline delivery.

18. VALIDATION RULES
    None at domain entity level.

19. ERROR HANDLING
    Status values allow the presentation layer to communicate state.

20. LOADING STATE
    Not represented by an individual message entity.

21. EMPTY STATE
    Represented by an empty message collection.

22. OFFLINE BEHAVIOUR
    Offline message status is supported.

23. SECURITY CONSIDERATIONS
    No credentials or authentication information are stored.

24. PERFORMANCE OPTIMIZATIONS
    Immutable final fields.

25. WIDGET TREE OVERVIEW
    Entity → controller → message bubble.

26. COMPLETE TESTING CHECKLIST
    Validate Unicode text, nullable confidence, all message statuses,
    immutable data, long messages, and offline representation.
*/

enum ChatMessageStatus { sent, delivered, read, translating, offline }

class ChatFeatureEntity {
  const ChatFeatureEntity({
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
  final ChatMessageStatus status;
  final double? confidence;
}
