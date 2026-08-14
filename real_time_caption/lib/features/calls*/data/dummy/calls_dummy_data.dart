/*
1. PAGE NAME
   Calls Feature Dummy Data

2. PURPOSE
   Supplies realistic multilingual local data for the Calls UI.

3. DESCRIPTION
   Contains only static demo content. No remote data or persistence is used.

4. UI SECTIONS
   Recent calls and incoming call presentation.

5. NAVIGATION FLOW
   Dummy data → Mock data source → Controller → Calls page.

6. DYNAMIC COMPONENTS
   Multilingual participants, language pairs, statuses, durations, and times.

7. FUTURE BACKEND INTEGRATION
   Replace the local source with the project's future call-session repository.

8. TECHNOLOGIES USED
   Dart.

9. REQUIRED DATA MODELS
   CallsFeatureModel and related models.

10. FUTURE API ENDPOINTS
    None implemented.

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
    Data is designed with readable names and language labels.

17. EDGE CASES
    Includes different statuses and language combinations.

18. VALIDATION RULES
    Dummy values are intentionally valid.

19. ERROR HANDLING
    Not applicable.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    The controller can expose an empty list independently.

22. OFFLINE BEHAVIOUR
    One sample call demonstrates an offline/reconnecting scenario.

23. SECURITY CONSIDERATIONS
    All identities are fictional demo data.

24. PERFORMANCE OPTIMIZATIONS
    Compile-time constant data.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify multilingual text, long labels, status mapping, and empty lists.
*/

import '../models/calls_feature_model.dart';

const List<CallsFeatureModel> callsDummyData = <CallsFeatureModel>[
  CallsFeatureModel(
    id: 'call_001',
    participant: CallParticipantModel(
      name: 'Ananya Rao',
      initials: 'AR',
      language: 'Tamil',
      isOnline: true,
    ),
    languagePair: CallLanguagePairModel(source: 'English', target: 'Tamil'),
    status: CallStatus.completed,
    callType: CallType.video,
    duration: Duration(minutes: 18, seconds: 42),
    timestampLabel: 'Today, 9:42 AM',
    isIncoming: false,
  ),
  CallsFeatureModel(
    id: 'call_002',
    participant: CallParticipantModel(
      name: 'Mateo Fernández',
      initials: 'MF',
      language: 'Spanish',
      isOnline: true,
    ),
    languagePair: CallLanguagePairModel(source: 'English', target: 'Spanish'),
    status: CallStatus.missed,
    callType: CallType.voice,
    duration: Duration.zero,
    timestampLabel: 'Yesterday, 7:18 PM',
    isIncoming: false,
  ),
  CallsFeatureModel(
    id: 'call_003',
    participant: CallParticipantModel(
      name: 'Priya Nair',
      initials: 'PN',
      language: 'Malayalam',
      isOnline: false,
    ),
    languagePair: CallLanguagePairModel(source: 'Hindi', target: 'Malayalam'),
    status: CallStatus.completed,
    callType: CallType.voice,
    duration: Duration(minutes: 7, seconds: 15),
    timestampLabel: 'Yesterday, 2:06 PM',
    isIncoming: false,
  ),
  CallsFeatureModel(
    id: 'call_004',
    participant: CallParticipantModel(
      name: 'Kiran Kumar',
      initials: 'KK',
      language: 'Telugu',
      isOnline: true,
    ),
    languagePair: CallLanguagePairModel(source: 'English', target: 'Telugu'),
    status: CallStatus.reconnecting,
    callType: CallType.video,
    duration: Duration(minutes: 3, seconds: 28),
    timestampLabel: 'Mon, 6:51 PM',
    isIncoming: false,
  ),
];
