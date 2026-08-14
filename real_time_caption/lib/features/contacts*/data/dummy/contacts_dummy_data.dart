/*
1. PAGE NAME
   Contacts Dummy Data

2. PURPOSE
   Supplies realistic multilingual local contact data for the UI.

3. DESCRIPTION
   This file intentionally contains only local demo data.

4. UI SECTIONS
   Contact list.

5. NAVIGATION FLOW
   Dummy data → mock data source → ContactsPage.

6. DYNAMIC COMPONENTS
   Multilingual contact names, language pairs, online state, favorites,
   and recent interaction labels.

7. FUTURE BACKEND INTEGRATION
   Replace this local source with the intended contacts repository while
   preserving the ContactFeatureModel contract.

8. TECHNOLOGIES USED
   Pure Dart.

9. REQUIRED DATA MODELS
   ContactFeatureModel.

10. FUTURE API ENDPOINTS
    Not specified in the supplied documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified in the supplied documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Data is provided in readable text suitable for semantic presentation.

17. EDGE CASES
    Includes multiple language combinations and different availability
    states.

18. VALIDATION RULES
    IDs are unique within the local list.

19. ERROR HANDLING
    Not applicable to static local data.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    The mock source can return an empty list independently.

22. OFFLINE BEHAVIOUR
    Dummy contacts remain available for UI demonstration.

23. SECURITY CONSIDERATIONS
    All names and data are fictional demo values.

24. PERFORMANCE OPTIMIZATIONS
    Small const list.

25. WIDGET TREE OVERVIEW
    ContactFeatureModel list → ContactListTile.

26. COMPLETE TESTING CHECKLIST
    Test rendering, search, filtering, and multilingual text.
*/

import '../models/contacts_feature_model.dart';

const List<ContactFeatureModel> contactsDummyData = <ContactFeatureModel>[
  ContactFeatureModel(
    id: 'contact_001',
    name: 'Ananya Rao',
    initials: 'AR',
    primaryLanguage: 'English',
    secondaryLanguage: 'Tamil',
    isOnline: true,
    isFavorite: true,
    lastInteraction: 'Translated conversation · 12 min ago',
  ),
  ContactFeatureModel(
    id: 'contact_002',
    name: 'Arjun Kumar',
    initials: 'AK',
    primaryLanguage: 'Tamil',
    secondaryLanguage: 'Hindi',
    isOnline: true,
    isFavorite: false,
    lastInteraction: 'Live caption session · 1 hr ago',
  ),
  ContactFeatureModel(
    id: 'contact_003',
    name: 'Meera Nair',
    initials: 'MN',
    primaryLanguage: 'Malayalam',
    secondaryLanguage: 'English',
    isOnline: false,
    isFavorite: true,
    lastInteraction: 'Conversation · Yesterday',
  ),
  ContactFeatureModel(
    id: 'contact_004',
    name: 'Ravi Teja',
    initials: 'RT',
    primaryLanguage: 'Telugu',
    secondaryLanguage: 'English',
    isOnline: true,
    isFavorite: false,
    lastInteraction: 'Call caption · Yesterday',
  ),
  ContactFeatureModel(
    id: 'contact_005',
    name: 'Priya Shah',
    initials: 'PS',
    primaryLanguage: 'Hindi',
    secondaryLanguage: 'English',
    isOnline: false,
    isFavorite: false,
    lastInteraction: 'Translated chat · Mon',
  ),
  ContactFeatureModel(
    id: 'contact_006',
    name: 'Daniel Thomas',
    initials: 'DT',
    primaryLanguage: 'English',
    secondaryLanguage: 'Malayalam',
    isOnline: true,
    isFavorite: true,
    lastInteraction: 'Live session · Mon',
  ),
  ContactFeatureModel(
    id: 'contact_007',
    name: 'Kavya Srinivas',
    initials: 'KS',
    primaryLanguage: 'Kannada',
    secondaryLanguage: 'Tamil',
    isOnline: false,
    isFavorite: false,
    lastInteraction: 'Conversation · Sun',
  ),
];
