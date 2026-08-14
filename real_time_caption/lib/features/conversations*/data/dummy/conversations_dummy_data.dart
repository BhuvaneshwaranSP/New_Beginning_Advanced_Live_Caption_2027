/*
1. PAGE NAME
   Conversations Dummy Data

2. PURPOSE
   Supplies realistic local multilingual conversation history for UI development.

3. DESCRIPTION
   Contains fictional conversations representing meetings, classrooms,
   personal communication, and conferences.

4. UI SECTIONS
   Conversation history list.

5. NAVIGATION FLOW
   Dummy data → mock data source → controller → page.

6. DYNAMIC COMPONENTS
   Titles, previews, participants, language pairs, durations, and statuses.

7. FUTURE BACKEND INTEGRATION
   Replace this local source with the project's planned Session History
   persistence layer when real functionality is introduced.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   ConversationsFeatureModel.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    Future session-history storage; exact schema is unspecified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Data contains readable multilingual examples.

17. EDGE CASES
    Includes multilingual text and different conversation lengths.

18. VALIDATION RULES
    Dummy records contain complete display values.

19. ERROR HANDLING
    Not applicable to static dummy data.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    The list can be locally replaced with an empty collection by the source.

22. OFFLINE BEHAVIOUR
    Data is local and therefore remains available without connectivity.

23. SECURITY CONSIDERATIONS
    All records are fictional demonstration content.

24. PERFORMANCE OPTIMIZATIONS
    Immutable const list.

25. WIDGET TREE OVERVIEW
    Dummy list → model → conversation card.

26. COMPLETE TESTING CHECKLIST
    Verify language rendering, long text, status labels, participant counts,
    timestamps, and card layouts.
*/

import '../models/conversations_feature_model.dart';

const List<ConversationsFeatureModel>
conversationsDummyData = <ConversationsFeatureModel>[
  ConversationsFeatureModel(
    id: 'conversation-001',
    title: 'Chennai Product Discussion',
    preview: 'Let us review the translated action points before Friday.',
    participants: <String>['Arun', 'Meera', 'Daniel', 'Priya'],
    sourceLanguage: 'English',
    targetLanguage: 'Tamil',
    timestampLabel: 'Today, 9:42 AM',
    durationLabel: '38 min',
    type: ConversationType.meeting,
    status: ConversationStatus.completed,
    isPinned: true,
  ),
  ConversationsFeatureModel(
    id: 'conversation-002',
    title: 'தமிழ் மொழி வகுப்பு',
    preview: 'இன்றைய பாடத்தின் முக்கிய குறிப்புகளை மீண்டும் பார்க்கலாம்.',
    participants: <String>['Kavin', 'Ananya', 'Ravi'],
    sourceLanguage: 'Tamil',
    targetLanguage: 'English',
    timestampLabel: 'Yesterday, 4:15 PM',
    durationLabel: '52 min',
    type: ConversationType.classroom,
    status: ConversationStatus.translated,
    isPinned: false,
  ),
  ConversationsFeatureModel(
    id: 'conversation-003',
    title: 'Hyderabad Client Call',
    preview: 'The Telugu discussion was converted into bilingual captions.',
    participants: <String>['Sanjay', 'Lakshmi', 'Rahul'],
    sourceLanguage: 'Telugu',
    targetLanguage: 'English',
    timestampLabel: 'Yesterday, 11:20 AM',
    durationLabel: '26 min',
    type: ConversationType.personal,
    status: ConversationStatus.completed,
    isPinned: false,
  ),
  ConversationsFeatureModel(
    id: 'conversation-004',
    title: 'Multilingual Accessibility Forum',
    preview:
        'Malayalam, Hindi and English captions were used during the session.',
    participants: <String>['Nisha', 'Vivek', 'Asha', 'Mohan', 'Sara'],
    sourceLanguage: 'Malayalam',
    targetLanguage: 'Hindi',
    timestampLabel: '12 Aug, 2:05 PM',
    durationLabel: '1 hr 14 min',
    type: ConversationType.conference,
    status: ConversationStatus.completed,
    isPinned: true,
  ),
  ConversationsFeatureModel(
    id: 'conversation-005',
    title: 'Hindi → English Planning',
    preview: 'Translation context is being prepared for the next session.',
    participants: <String>['Kabir', 'Neha'],
    sourceLanguage: 'Hindi',
    targetLanguage: 'English',
    timestampLabel: '10 Aug, 6:30 PM',
    durationLabel: '19 min',
    type: ConversationType.meeting,
    status: ConversationStatus.processing,
    isPinned: false,
  ),
];
