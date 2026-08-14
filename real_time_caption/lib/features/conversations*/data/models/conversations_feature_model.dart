/*
1. PAGE NAME
   Conversations Feature Data Model

2. PURPOSE
   Defines the local data model used by the Conversations UI.

3. DESCRIPTION
   Represents a historical multilingual conversation/session using only
   locally supplied dummy information.

4. UI SECTIONS
   Conversation cards and summary information.

5. NAVIGATION FLOW
   Mock data source → model → controller → Conversations page.

6. DYNAMIC COMPONENTS
   Conversation title, participants, languages, preview, timestamp, and status.

7. FUTURE BACKEND INTEGRATION
   This model can later be populated from the project's Session History
   storage without changing the presentation model's responsibilities.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   ConversationsFeatureModel.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    Future session-history storage; schema not specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None; presentation determines colors.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Text fields remain semantic UI content.

17. EDGE CASES
    Empty participant list, long titles, missing preview, and multilingual
    content are supported.

18. VALIDATION RULES
    Fields use non-null defaults where appropriate.

19. ERROR HANDLING
    Invalid external data is not processed by this UI-only model.

20. LOADING STATE
    Not represented by the model.

21. EMPTY STATE
    Represented by the absence of models.

22. OFFLINE BEHAVIOUR
    Models remain usable as local dummy data.

23. SECURITY CONSIDERATIONS
    Contains fictional demonstration data only.

24. PERFORMANCE OPTIMIZATIONS
    Immutable fields and const construction.

25. WIDGET TREE OVERVIEW
    Model → controller → conversation card.

26. COMPLETE TESTING CHECKLIST
    Test multilingual strings, long text, empty values, status values,
    equality-like rendering, and null-safety.
*/

enum ConversationStatus { completed, translated, processing }

enum ConversationType { meeting, classroom, personal, conference }

class ConversationsFeatureModel {
  const ConversationsFeatureModel({
    required this.id,
    required this.title,
    required this.preview,
    required this.participants,
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.timestampLabel,
    required this.durationLabel,
    required this.type,
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
  final ConversationType type;
  final ConversationStatus status;
  final bool isPinned;
}
