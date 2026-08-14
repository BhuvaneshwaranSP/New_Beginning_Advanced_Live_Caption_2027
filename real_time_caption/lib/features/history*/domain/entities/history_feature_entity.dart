/*
1. PAGE NAME
   History Feature Domain Entity

2. PURPOSE
   Defines the immutable domain representation of a LinguaLive history
   session.

3. DESCRIPTION
   Represents previously completed multilingual communication sessions
   without depending on Flutter or infrastructure.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   History page → selected HistoryFeatureEntity.

6. DYNAMIC COMPONENTS
   Session type, language pair, participants, duration, status,
   transcript preview, and session timestamp.

7. FUTURE BACKEND INTEGRATION
   Repository implementations will later map persisted history records
   into this entity.

8. TECHNOLOGIES USED
   Pure Dart.

9. REQUIRED DATA MODELS
   HistoryFeatureEntity.

10. FUTURE API ENDPOINTS
    No endpoint is implemented here.

11. DATABASE COLLECTIONS/TABLES
    No database is implemented here.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Human-readable strings are retained for presentation mapping.

17. EDGE CASES
    Empty transcript previews and optional participant labels.

18. VALIDATION RULES
    Text values remain non-null to simplify safe presentation.

19. ERROR HANDLING
    Not applicable at domain-entity level.

20. LOADING STATE
    Not represented in the entity.

21. EMPTY STATE
    Represented by an empty list outside the entity.

22. OFFLINE BEHAVIOUR
    The entity can represent locally available history.

23. SECURITY CONSIDERATIONS
    Contains only display-oriented dummy session information.

24. PERFORMANCE OPTIMIZATIONS
    Immutable final fields and const constructor.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Validate equality of values passed through model mapping and safe
    handling of optional participant information.
*/

enum HistorySessionType { liveSpeech, call, conversation }

enum HistorySessionStatus { completed, interrupted, offline }

class HistoryFeatureEntity {
  const HistoryFeatureEntity({
    required this.id,
    required this.title,
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.sourceLanguageCode,
    required this.targetLanguageCode,
    required this.participantLabel,
    required this.preview,
    required this.durationLabel,
    required this.dateLabel,
    required this.timeLabel,
    required this.type,
    required this.status,
    required this.messageCount,
  });

  final String id;
  final String title;
  final String sourceLanguage;
  final String targetLanguage;
  final String sourceLanguageCode;
  final String targetLanguageCode;
  final String participantLabel;
  final String preview;
  final String durationLabel;
  final String dateLabel;
  final String timeLabel;
  final HistorySessionType type;
  final HistorySessionStatus status;
  final int messageCount;
}
