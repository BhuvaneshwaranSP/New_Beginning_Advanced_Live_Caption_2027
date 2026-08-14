/*
1. PAGE NAME
   Calls Feature Domain Entity

2. PURPOSE
   Defines the domain-level representation of a LinguaLive call session.

3. DESCRIPTION
   Pure Dart immutable entity with no Flutter dependency.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Future call-session repository → domain entity → presentation model.

6. DYNAMIC COMPONENTS
   Participant, language pair, status, type, duration, and timestamp.

7. FUTURE BACKEND INTEGRATION
   Future call-session services will map their responses into this entity.

8. TECHNOLOGIES USED
   Dart.

9. REQUIRED DATA MODELS
   CallSessionEntity.

10. FUTURE API ENDPOINTS
    Call creation, call state, participant presence, caption stream,
    and translation stream.

11. DATABASE COLLECTIONS/TABLES
    Future call-session history.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Domain entity itself has no UI responsibilities.

17. EDGE CASES
    Immutable values reduce accidental presentation state mutation.

18. VALIDATION RULES
    UI validation is intentionally outside this entity.

19. ERROR HANDLING
    None.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Represented by call status when required.

23. SECURITY CONSIDERATIONS
    No credentials or authentication information belong in this entity.

24. PERFORMANCE OPTIMIZATIONS
    Immutable final fields.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify immutable construction and null safety.
*/

enum CallSessionStatus { completed, missed, incoming, reconnecting, offline }

class CallSessionEntity {
  const CallSessionEntity({
    required this.id,
    required this.participantName,
    required this.participantLanguage,
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.status,
    required this.duration,
  });

  final String id;
  final String participantName;
  final String participantLanguage;
  final String sourceLanguage;
  final String targetLanguage;
  final CallSessionStatus status;
  final Duration duration;
}
