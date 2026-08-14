/*
1. PAGE NAME
   Calls Feature Data Models

2. PURPOSE
   Defines immutable local data models used by the Calls presentation layer.

3. DESCRIPTION
   These models represent dummy call-session data only. They contain no
   networking, persistence, authentication, or real communication logic.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Mock data source → CallsFeatureModel → CallsController → CallsPage.

6. DYNAMIC COMPONENTS
   Participant, language pair, call status, duration, and call type.

7. FUTURE BACKEND INTEGRATION
   Future API/stream response models can be mapped into these presentation-
   friendly values without changing the UI widgets.

8. TECHNOLOGIES USED
   Dart null safety.

9. REQUIRED DATA MODELS
   CallsFeatureModel
   CallParticipantModel
   CallLanguagePairModel

10. FUTURE API ENDPOINTS
    No endpoints implemented.

11. DATABASE COLLECTIONS/TABLES
    None implemented.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Display strings are kept human-readable for semantic presentation.

17. EDGE CASES
    Empty names and unusual duration values are safely represented.

18. VALIDATION RULES
    Display values use sensible defaults where required.

19. ERROR HANDLING
    No runtime data-source errors are implemented.

20. LOADING STATE
    Managed by the controller rather than this model.

21. EMPTY STATE
    Represented by an empty call list.

22. OFFLINE BEHAVIOUR
    Represented by the controller's local connection state.

23. SECURITY CONSIDERATIONS
    Dummy data contains no sensitive credentials.

24. PERFORMANCE OPTIMIZATIONS
    Immutable classes and const constructors.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify construction, null-safety, empty collections, and long strings.
*/

enum CallStatus { completed, missed, incoming, reconnecting, offline }

enum CallType { voice, video }

class CallParticipantModel {
  const CallParticipantModel({
    required this.name,
    required this.initials,
    required this.language,
    required this.isOnline,
  });

  final String name;
  final String initials;
  final String language;
  final bool isOnline;
}

class CallLanguagePairModel {
  const CallLanguagePairModel({required this.source, required this.target});

  final String source;
  final String target;

  String get displayLabel => '$source → $target';
}

class CallsFeatureModel {
  const CallsFeatureModel({
    required this.id,
    required this.participant,
    required this.languagePair,
    required this.status,
    required this.callType,
    required this.duration,
    required this.timestampLabel,
    required this.isIncoming,
  });

  final String id;
  final CallParticipantModel participant;
  final CallLanguagePairModel languagePair;
  final CallStatus status;
  final CallType callType;
  final Duration duration;
  final String timestampLabel;
  final bool isIncoming;
}
