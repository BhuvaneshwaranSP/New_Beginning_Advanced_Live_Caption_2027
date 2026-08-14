/*
1. PAGE NAME
   Home Dummy Data

2. PURPOSE
   Supplies realistic local multilingual content for the Home UI.

3. DESCRIPTION
   UI-only demonstration data. No persistence or network access.

4. UI SECTIONS
   Language selector, communication features, recent sessions.

5. NAVIGATION FLOW
   Dummy data → Home presentation.

6. DYNAMIC COMPONENTS
   Languages, feature cards, sessions.

7. FUTURE BACKEND INTEGRATION
   Future: replace these local collections with repository-provided data;
   this file exists only to support the current UI-only implementation.

8. TECHNOLOGIES USED
   Dart.

9. REQUIRED DATA MODELS
   Home feature data models.

10. FUTURE API ENDPOINTS
    None currently implemented.

11. DATABASE COLLECTIONS/TABLES
    None currently implemented.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Icons are selected in presentation widgets.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Multilingual labels are intentionally readable by screen readers.

17. EDGE CASES
    Long language names and multilingual Unicode text.

18. VALIDATION RULES
    Dummy values are structurally valid.

19. ERROR HANDLING
    Not applicable.

20. LOADING STATE
    Not represented by this data source.

21. EMPTY STATE
    Presentation can use an empty list.

22. OFFLINE BEHAVIOUR
    Presentation can use the local data while offline.

23. SECURITY CONSIDERATIONS
    No real user data.

24. PERFORMANCE OPTIMIZATIONS
    Static const collections.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Multilingual rendering, long labels, empty collections, and list mapping.
*/

import '../models/home_feature_model.dart';

class HomeDummyData {
  const HomeDummyData._();

  static const List<LanguageOptionModel> languages = <LanguageOptionModel>[
    LanguageOptionModel(code: 'en', name: 'English', nativeName: 'English'),
    LanguageOptionModel(code: 'ta', name: 'Tamil', nativeName: 'தமிழ்'),
    LanguageOptionModel(code: 'te', name: 'Telugu', nativeName: 'తెలుగు'),
    LanguageOptionModel(code: 'hi', name: 'Hindi', nativeName: 'हिन्दी'),
    LanguageOptionModel(code: 'ml', name: 'Malayalam', nativeName: 'മലയാളം'),
  ];

  static const List<HomeFeatureModel> features = <HomeFeatureModel>[
    HomeFeatureModel(
      id: 'live_speech',
      title: 'Live Speech',
      subtitle: 'Real-time multilingual speech and captions',
      status: 'Ready',
    ),
    HomeFeatureModel(
      id: 'call_caption',
      title: 'Call Caption',
      subtitle: 'Follow calls with translated captions',
      status: 'Ready',
    ),
    HomeFeatureModel(
      id: 'chat',
      title: 'Chat',
      subtitle: 'Convert spoken conversations into chat',
      status: 'Ready',
    ),
    HomeFeatureModel(
      id: 'translation',
      title: 'Translation',
      subtitle: 'Translate between supported languages',
      status: 'Ready',
    ),
    HomeFeatureModel(
      id: 'qr_session',
      title: 'QR Session',
      subtitle: 'Join or create a shared communication session',
      status: 'Ready',
    ),
  ];

  static const List<RecentSessionModel> recentSessions = <RecentSessionModel>[
    RecentSessionModel(
      id: 'session_001',
      title: 'Classroom Discussion',
      languagePair: 'English → Tamil',
      timeLabel: 'Today, 9:20 AM',
      participantCount: 8,
    ),
    RecentSessionModel(
      id: 'session_002',
      title: 'Team Meeting',
      languagePair: 'Hindi → English',
      timeLabel: 'Yesterday, 4:45 PM',
      participantCount: 5,
    ),
    RecentSessionModel(
      id: 'session_003',
      title: 'Travel Conversation',
      languagePair: 'Malayalam → English',
      timeLabel: 'Aug 12, 7:15 PM',
      participantCount: 2,
    ),
  ];
}
