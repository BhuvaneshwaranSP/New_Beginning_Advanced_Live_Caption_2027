/*
1. PAGE NAME
   Languages Dummy Data

2. PURPOSE
   Supplies realistic local language data for the UI-only Languages feature.

3. DESCRIPTION
   Includes Indian and internationally common languages so the interface
   reflects LinguaLive's multilingual communication purpose.

4. UI SECTIONS
   My Languages, Preferred Languages, Recent Languages,
   and All Supported Languages.

5. NAVIGATION FLOW
   Dummy data → mock data source → controller → LanguagesPage.

6. DYNAMIC COMPONENTS
   Language tiles and selected source/target language pair.

7. FUTURE BACKEND INTEGRATION
   Replace this local catalog with the supported-language service at the
   data-source boundary.

8. TECHNOLOGIES USED
   Pure Dart.

9. REQUIRED DATA MODELS
   LanguageFeatureModel.

10. FUTURE API ENDPOINTS
    Not implemented.

11. DATABASE COLLECTIONS/TABLES
    Not implemented.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Language names and native names are exposed through presentation.

17. EDGE CASES
    Includes an unavailable language to exercise availability UI.

18. VALIDATION RULES
    IDs and language codes are unique within the dummy catalog.

19. ERROR HANDLING
    Empty/search states are exercised by the page.

20. LOADING STATE
    Simulated by controller state only.

21. EMPTY STATE
    Search can produce an empty result.

22. OFFLINE BEHAVIOUR
    Some languages intentionally demonstrate local availability status.

23. SECURITY CONSIDERATIONS
    No sensitive data.

24. PERFORMANCE OPTIMIZATIONS
    Constant list values.

25. WIDGET TREE OVERVIEW
    Dummy models → language list widgets.

26. COMPLETE TESTING CHECKLIST
    Search all names, native names, availability, preference, and recency.
*/

import '../models/languages_feature_model.dart';

const List<LanguageFeatureModel> languagesDummyData = [
  LanguageFeatureModel(
    id: 'en',
    name: 'English',
    nativeName: 'English',
    code: 'EN',
    region: 'Global',
    available: true,
    isPreferred: true,
    isRecent: true,
  ),
  LanguageFeatureModel(
    id: 'ta',
    name: 'Tamil',
    nativeName: 'தமிழ்',
    code: 'TA',
    region: 'India',
    available: true,
    isPreferred: true,
    isRecent: true,
  ),
  LanguageFeatureModel(
    id: 'te',
    name: 'Telugu',
    nativeName: 'తెలుగు',
    code: 'TE',
    region: 'India',
    available: true,
    isPreferred: false,
    isRecent: true,
  ),
  LanguageFeatureModel(
    id: 'hi',
    name: 'Hindi',
    nativeName: 'हिन्दी',
    code: 'HI',
    region: 'India',
    available: true,
    isPreferred: false,
    isRecent: false,
  ),
  LanguageFeatureModel(
    id: 'ml',
    name: 'Malayalam',
    nativeName: 'മലയാളം',
    code: 'ML',
    region: 'India',
    available: true,
    isPreferred: false,
    isRecent: false,
  ),
  LanguageFeatureModel(
    id: 'kn',
    name: 'Kannada',
    nativeName: 'ಕನ್ನಡ',
    code: 'KN',
    region: 'India',
    available: true,
    isPreferred: false,
    isRecent: false,
  ),
  LanguageFeatureModel(
    id: 'fr',
    name: 'French',
    nativeName: 'Français',
    code: 'FR',
    region: 'Europe',
    available: true,
    isPreferred: false,
    isRecent: false,
  ),
  LanguageFeatureModel(
    id: 'es',
    name: 'Spanish',
    nativeName: 'Español',
    code: 'ES',
    region: 'Europe / Americas',
    available: true,
    isPreferred: false,
    isRecent: false,
  ),
  LanguageFeatureModel(
    id: 'de',
    name: 'German',
    nativeName: 'Deutsch',
    code: 'DE',
    region: 'Europe',
    available: true,
    isPreferred: false,
    isRecent: false,
  ),
  LanguageFeatureModel(
    id: 'ja',
    name: 'Japanese',
    nativeName: '日本語',
    code: 'JA',
    region: 'Asia',
    available: true,
    isPreferred: false,
    isRecent: false,
  ),
  LanguageFeatureModel(
    id: 'ar',
    name: 'Arabic',
    nativeName: 'العربية',
    code: 'AR',
    region: 'Middle East',
    available: false,
    isPreferred: false,
    isRecent: false,
  ),
];
