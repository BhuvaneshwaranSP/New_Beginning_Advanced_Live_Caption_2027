/*
1. PAGE NAME
   Analytics Dummy Data

2. PURPOSE
   Supplies realistic multilingual local data for Analytics UI development.

3. DESCRIPTION
   No network, database, AI inference, or persistence is used.

4. UI SECTIONS
   Summary metrics, weekly usage, languages, sessions, translations.

5. NAVIGATION FLOW
   Dummy data → mock data source → controller → AnalyticsPage.

6. DYNAMIC COMPONENTS
   All values returned by the mock data source.

7. FUTURE BACKEND INTEGRATION
   Replace this data with validated analytics returned by the intended
   LinguaLive analytics data source.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   AnalyticsFeatureModel and its child models.

10. FUTURE API ENDPOINTS
    Not defined.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Multilingual sample values include readable native language names.

17. EDGE CASES
    Data includes different percentages and usage levels.

18. VALIDATION RULES
    Percentages remain between 0 and 100.

19. ERROR HANDLING
    Not applicable to static dummy data.

20. LOADING STATE
    Simulated by the controller.

21. EMPTY STATE
    Can be demonstrated by supplying an empty model.

22. OFFLINE BEHAVIOUR
    Can be represented by controller state.

23. SECURITY CONSIDERATIONS
    All values are fabricated demonstration data.

24. PERFORMANCE OPTIMIZATIONS
    Const immutable collections.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify multilingual strings, chart values, percentages,
    zero values, and empty-data scenarios.
*/

import '../models/analytics_feature_model.dart';

const AnalyticsFeatureModel analyticsDummyData = AnalyticsFeatureModel(
  metrics: [
    AnalyticsMetricModel(
      id: 'sessions',
      label: 'Translation sessions',
      value: '48',
      changeLabel: '+12%',
      positive: true,
      description: 'Compared with the previous period',
    ),
    AnalyticsMetricModel(
      id: 'words',
      label: 'Words translated',
      value: '18.6K',
      changeLabel: '+8.4%',
      positive: true,
      description: 'Across supported conversations',
    ),
    AnalyticsMetricModel(
      id: 'duration',
      label: 'Conversation time',
      value: '14h 32m',
      changeLabel: '+5.7%',
      positive: true,
      description: 'Total interpreted conversation time',
    ),
    AnalyticsMetricModel(
      id: 'confidence',
      label: 'Average confidence',
      value: '94.2%',
      changeLabel: '+1.8%',
      positive: true,
      description: 'Average local demonstration score',
    ),
  ],
  usagePoints: [
    UsagePointModel(label: 'Mon', value: 42),
    UsagePointModel(label: 'Tue', value: 58),
    UsagePointModel(label: 'Wed', value: 46),
    UsagePointModel(label: 'Thu', value: 74),
    UsagePointModel(label: 'Fri', value: 68),
    UsagePointModel(label: 'Sat', value: 88),
    UsagePointModel(label: 'Sun', value: 61),
  ],
  languages: [
    LanguageUsageModel(
      languageCode: 'EN',
      languageName: 'English',
      nativeName: 'English',
      sessions: 22,
      percentage: 46,
    ),
    LanguageUsageModel(
      languageCode: 'TA',
      languageName: 'Tamil',
      nativeName: 'தமிழ்',
      sessions: 13,
      percentage: 27,
    ),
    LanguageUsageModel(
      languageCode: 'TE',
      languageName: 'Telugu',
      nativeName: 'తెలుగు',
      sessions: 8,
      percentage: 17,
    ),
    LanguageUsageModel(
      languageCode: 'HI',
      languageName: 'Hindi',
      nativeName: 'हिन्दी',
      sessions: 5,
      percentage: 10,
    ),
  ],
  sessions: SessionAnalyticsModel(
    totalSessions: 48,
    completedSessions: 43,
    averageMinutes: 18,
    mostUsedPair: 'English ↔ Tamil',
  ),
  translations: TranslationAnalyticsModel(
    translatedWords: 18640,
    translatedSegments: 3420,
    averageConfidence: 94.2,
    mostActiveLanguage: 'Tamil',
  ),
);
