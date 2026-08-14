/*
1. PAGE NAME
   Conversations Feature Domain Entity

2. PURPOSE
   Defines the domain-level representation of a conversation.

3. DESCRIPTION
   Contains pure Dart business data without Flutter or infrastructure
   dependencies.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Conversation data source/model → domain representation → presentation.

6. DYNAMIC COMPONENTS
   Conversation metadata and language pair.

7. FUTURE BACKEND INTEGRATION
   Future persistence and service layers can map their records into this
   entity before presentation.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   ConversationsFeatureEntity.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    Future session-history storage; exact schema unspecified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Not applicable.

17. EDGE CASES
    Empty participant lists and multilingual text are valid.

18. VALIDATION RULES
    All core values are required.

19. ERROR HANDLING
    No infrastructure errors are represented here.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Represented by no entities.

22. OFFLINE BEHAVIOUR
    Entity is independent of connectivity.

23. SECURITY CONSIDERATIONS
    No external processing.

24. PERFORMANCE OPTIMIZATIONS
    Immutable values.

25. WIDGET TREE OVERVIEW
    Entity → presentation model/controller.

26. COMPLETE TESTING CHECKLIST
    Verify immutable data, multilingual values, and long text.
*/

enum ConversationEntityStatus { completed, translated, processing }

class ConversationsFeatureEntity {
  const ConversationsFeatureEntity({
    required this.id,
    required this.title,
    required this.preview,
    required this.participants,
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.timestampLabel,
    required this.durationLabel,
    required this.status,
    required this.isPinned,
  });

  final String id;
  final String title;
  final String preview;
  final List<String> participants;
  final String sourceLanguage;
  final String targetLanguage;
  final String timestampLabel;
  final String durationLabel;
  final ConversationEntityStatus status;
  final bool isPinned;
}
