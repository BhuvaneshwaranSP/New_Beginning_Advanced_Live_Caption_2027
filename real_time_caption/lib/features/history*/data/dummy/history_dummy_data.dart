/*
1. PAGE NAME
   History Dummy Data

2. PURPOSE
   Supplies realistic multilingual local data for the History UI.

3. DESCRIPTION
   Contains representative LinguaLive sessions covering live speech,
   calls, conversations, multiple languages, completed sessions,
   interrupted sessions, and offline sessions.

4. UI SECTIONS
   History list and summary statistics.

5. NAVIGATION FLOW
   Dummy data → mock data source → controller → History page.

6. DYNAMIC COMPONENTS
   Searchable sessions, filters, status badges, and session summaries.

7. FUTURE BACKEND INTEGRATION
   These records will later be replaced by persisted history records.

8. TECHNOLOGIES USED
   Dart.

9. REQUIRED DATA MODELS
   HistoryFeatureModel.

10. FUTURE API ENDPOINTS
    No endpoint is implemented.

11. DATABASE COLLECTIONS/TABLES
    No database is implemented.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Data includes text labels rather than relying on visual color.

17. EDGE CASES
    Includes multilingual content and an interrupted/offline record.

18. VALIDATION RULES
    Dummy records use valid display values.

19. ERROR HANDLING
    Not applicable.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    The controller can expose an empty filtered result.

22. OFFLINE BEHAVIOUR
    One sample record demonstrates an offline session.

23. SECURITY CONSIDERATIONS
    All names and transcript text are fictional demo content.

24. PERFORMANCE OPTIMIZATIONS
    Constant list and immutable models.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Test search and filtering against every dummy record.
*/

import '../models/history_feature_model.dart';
import '../../domain/entities/history_feature_entity.dart';

const List<HistoryFeatureModel> historyDummyData = [
  HistoryFeatureModel(
    id: 'history_001',
    title: 'Chennai Team Sync',
    sourceLanguage: 'English',
    targetLanguage: 'Tamil',
    sourceLanguageCode: 'EN',
    targetLanguageCode: 'TA',
    participantLabel: '4 participants',
    preview: 'We will review the deployment plan after lunch.',
    durationLabel: '28 min',
    dateLabel: 'Today',
    timeLabel: '10:42 AM',
    type: HistorySessionType.liveSpeech,
    status: HistorySessionStatus.completed,
    messageCount: 86,
  ),
  HistoryFeatureModel(
    id: 'history_002',
    title: 'Family Call',
    sourceLanguage: 'Tamil',
    targetLanguage: 'English',
    sourceLanguageCode: 'TA',
    targetLanguageCode: 'EN',
    participantLabel: '2 participants',
    preview: 'நாளைக்கு மாலை பேசலாம், உங்களுக்கு வசதியா?',
    durationLabel: '14 min',
    dateLabel: 'Yesterday',
    timeLabel: '8:16 PM',
    type: HistorySessionType.call,
    status: HistorySessionStatus.completed,
    messageCount: 41,
  ),
  HistoryFeatureModel(
    id: 'history_003',
    title: 'Travel Planning',
    sourceLanguage: 'Hindi',
    targetLanguage: 'Malayalam',
    sourceLanguageCode: 'HI',
    targetLanguageCode: 'ML',
    participantLabel: '3 participants',
    preview: 'हम सुबह जल्दी निकलेंगे ताकि रास्ते में समय मिले।',
    durationLabel: '21 min',
    dateLabel: '12 Aug',
    timeLabel: '6:35 PM',
    type: HistorySessionType.conversation,
    status: HistorySessionStatus.completed,
    messageCount: 63,
  ),
  HistoryFeatureModel(
    id: 'history_004',
    title: 'Client Discussion',
    sourceLanguage: 'Telugu',
    targetLanguage: 'English',
    sourceLanguageCode: 'TE',
    targetLanguageCode: 'EN',
    participantLabel: '5 participants',
    preview: 'The revised timeline should be ready by Friday.',
    durationLabel: '36 min',
    dateLabel: '11 Aug',
    timeLabel: '3:08 PM',
    type: HistorySessionType.liveSpeech,
    status: HistorySessionStatus.completed,
    messageCount: 119,
  ),
  HistoryFeatureModel(
    id: 'history_005',
    title: 'Classroom Session',
    sourceLanguage: 'English',
    targetLanguage: 'Hindi',
    sourceLanguageCode: 'EN',
    targetLanguageCode: 'HI',
    participantLabel: '18 participants',
    preview: 'Today we are focusing on the second chapter.',
    durationLabel: '52 min',
    dateLabel: '10 Aug',
    timeLabel: '11:20 AM',
    type: HistorySessionType.liveSpeech,
    status: HistorySessionStatus.offline,
    messageCount: 174,
  ),
  HistoryFeatureModel(
    id: 'history_006',
    title: 'Project Catch-up',
    sourceLanguage: 'Malayalam',
    targetLanguage: 'Tamil',
    sourceLanguageCode: 'ML',
    targetLanguageCode: 'TA',
    participantLabel: '3 participants',
    preview: 'അടുത്ത ഘട്ടത്തിലെ പ്രധാന കാര്യങ്ങൾ ആദ്യം പരിശോധിക്കാം.',
    durationLabel: '17 min',
    dateLabel: '08 Aug',
    timeLabel: '4:45 PM',
    type: HistorySessionType.conversation,
    status: HistorySessionStatus.interrupted,
    messageCount: 37,
  ),
];
