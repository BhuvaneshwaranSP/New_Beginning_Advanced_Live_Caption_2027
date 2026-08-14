/*
1. PAGE NAME
   Help Center Dummy Data

2. PURPOSE
   Provides local Help Center content for UI development.

3. DESCRIPTION
   Contains realistic multilingual FAQ data without backend functionality.

4. UI SECTIONS
   Categories and FAQ articles.

5. NAVIGATION FLOW
   Dummy data → data source → controller → Help Center page.

6. DYNAMIC COMPONENTS
   Searchable categories and FAQ articles.

7. FUTURE BACKEND INTEGRATION
   Future: replace these records with supported Help Center content.

8. TECHNOLOGIES USED
   Dart.

9. REQUIRED DATA MODELS
   HelpCenterCategoryModel
   HelpCenterArticleModel

10. FUTURE API ENDPOINTS
    Not specified.

11. DATABASE COLLECTIONS/TABLES
    Not specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Presentation responsibility.

17. EDGE CASES
    Multilingual and long text.

18. VALIDATION RULES
    Stable non-empty identifiers.

19. ERROR HANDLING
    Presentation responsibility.

20. LOADING STATE
    Presentation responsibility.

21. EMPTY STATE
    Presentation responsibility.

22. OFFLINE BEHAVIOUR
    Local data remains available.

23. SECURITY CONSIDERATIONS
    No sensitive data.

24. PERFORMANCE OPTIMIZATIONS
    Static const collections.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify rendering, filtering, expansion, and empty results.
*/

import '../../domain/entities/help_center_feature_entity.dart';
import '../models/help_center_feature_model.dart';

const List<HelpCenterCategoryModel> helpCenterCategories = [
  HelpCenterCategoryModel(
    id: 'getting_started',
    type: HelpCenterCategoryType.gettingStarted,
    title: 'Getting started',
    description: 'Learn the basics of multilingual communication.',
  ),
  HelpCenterCategoryModel(
    id: 'translation',
    type: HelpCenterCategoryType.translation,
    title: 'Translation',
    description: 'Understand source and target language features.',
  ),
  HelpCenterCategoryModel(
    id: 'live_communication',
    type: HelpCenterCategoryType.liveCommunication,
    title: 'Live communication',
    description: 'Learn about captions, conversations, and calls.',
  ),
  HelpCenterCategoryModel(
    id: 'privacy',
    type: HelpCenterCategoryType.privacy,
    title: 'Privacy & data',
    description: 'Understand privacy considerations for communication.',
  ),
];

const List<HelpCenterArticleModel> helpCenterArticles = [
  HelpCenterArticleModel(
    id: 'language_pair',
    categoryId: 'getting_started',
    title: 'How do I choose a source and target language?',
    description:
        'Select the language you are speaking as the source and the language you want to understand as the target.',
    keywords: ['language', 'source', 'target', 'English', 'தமிழ்', 'తెలుగు'],
  ),
  HelpCenterArticleModel(
    id: 'live_caption',
    categoryId: 'live_communication',
    title: 'What is live captioning?',
    description:
        'Live captioning presents recognized speech as text while a communication session is taking place.',
    keywords: ['caption', 'live', 'speech', 'transcription', 'கேப்ஷன்'],
  ),
  HelpCenterArticleModel(
    id: 'translation',
    categoryId: 'translation',
    title: 'How does translation work in a conversation?',
    description:
        'LinguaLive is designed around source and target language communication so participants can follow translated text during multilingual interactions.',
    keywords: [
      'translation',
      'multilingual',
      'conversation',
      'अनुवाद',
      'traducción',
    ],
  ),
  HelpCenterArticleModel(
    id: 'target_language',
    categoryId: 'translation',
    title: 'Can I change the target language?',
    description:
        'The target language represents the language selected for translated communication.',
    keywords: ['target', 'language', 'change', 'भाषा', 'மொழி'],
  ),
  HelpCenterArticleModel(
    id: 'conversation_history',
    categoryId: 'live_communication',
    title: 'Where can I review conversation content?',
    description:
        'Conversation-related content can be represented through the application history and conversation areas.',
    keywords: ['conversation', 'history', 'chat', 'session'],
  ),
  HelpCenterArticleModel(
    id: 'privacy',
    categoryId: 'privacy',
    title: 'Why is privacy important for multilingual communication?',
    description:
        'Speech, captions, translations, and conversations may contain sensitive information, so production integrations should apply appropriate privacy controls.',
    keywords: ['privacy', 'security', 'data', 'speech', 'conversation'],
  ),
];
