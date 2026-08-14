/*
1. PAGE NAME
   Chat Dummy Data

2. PURPOSE
   Supplies realistic local multilingual conversation data for the UI.

3. DESCRIPTION
   Demonstrates English, Tamil, Hindi, Telugu, and Malayalam content without
   connecting to any external service.

4. UI SECTIONS
   Conversation message list and incoming call state.

5. NAVIGATION FLOW
   Dummy data → Mock data source → Chat controller → ChatPage.

6. DYNAMIC COMPONENTS
   Conversation messages and call notification.

7. FUTURE BACKEND INTEGRATION
   Real spoken-conversation-to-chat and translation results will replace this
   local demonstration data.

8. TECHNOLOGIES USED
   Pure Dart.

9. REQUIRED DATA MODELS
   ChatFeatureModel.

10. FUTURE API ENDPOINTS
    Not specified in supplied documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified in supplied documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Dummy strings include multilingual Unicode content.

17. EDGE CASES
    Includes short and long translated messages.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    Not applicable.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    The list can be reduced to zero items by the mock source.

22. OFFLINE BEHAVIOUR
    One message demonstrates an offline status.

23. SECURITY CONSIDERATIONS
    Contains fictional demo content only.

24. PERFORMANCE OPTIMIZATIONS
    Uses a compile-time constant list.

25. WIDGET TREE OVERVIEW
    Dummy list → message bubbles.

26. COMPLETE TESTING CHECKLIST
    Verify Unicode rendering, long messages, status indicators, and
    multilingual alignment.
*/

import '../models/chat_feature_model.dart';
import '../../domain/entities/chat_feature_entity.dart';

const List<ChatFeatureModel> chatDummyMessages = <ChatFeatureModel>[
  ChatFeatureModel(
    id: 'message-001',
    senderName: 'Ananya',
    isMine: false,
    originalText: 'வணக்கம்! இன்று எப்படி இருக்கிறீர்கள்?',
    translatedText: 'Hello! How are you today?',
    sourceLanguage: 'Tamil',
    targetLanguage: 'English',
    timestamp: '09:41',
    status: ChatMessageStatus.read,
    confidence: 0.98,
  ),
  ChatFeatureModel(
    id: 'message-002',
    senderName: 'You',
    isMine: true,
    originalText: 'I am doing well. Shall we start the meeting?',
    translatedText: 'நான் நன்றாக இருக்கிறேன். கூட்டத்தைத் தொடங்கலாமா?',
    sourceLanguage: 'English',
    targetLanguage: 'Tamil',
    timestamp: '09:42',
    status: ChatMessageStatus.read,
    confidence: 0.99,
  ),
  ChatFeatureModel(
    id: 'message-003',
    senderName: 'Ananya',
    isMine: false,
    originalText: 'हाँ, मैं तैयार हूँ।',
    translatedText: 'Yes, I am ready.',
    sourceLanguage: 'Hindi',
    targetLanguage: 'English',
    timestamp: '09:43',
    status: ChatMessageStatus.delivered,
    confidence: 0.97,
  ),
  ChatFeatureModel(
    id: 'message-004',
    senderName: 'You',
    isMine: true,
    originalText: 'మనము మొదటి అంశంతో ప్రారంభిద్దాం.',
    translatedText: 'Let us begin with the first topic.',
    sourceLanguage: 'Telugu',
    targetLanguage: 'English',
    timestamp: '09:44',
    status: ChatMessageStatus.sent,
    confidence: 0.96,
  ),
  ChatFeatureModel(
    id: 'message-005',
    senderName: 'Ananya',
    isMine: false,
    originalText:
        'നാളെ വീണ്ടും സംസാരിക്കാം. എല്ലാ പ്രധാന കാര്യങ്ങളും ഞാൻ കുറിച്ചുവെക്കും.',
    translatedText:
        'We can speak again tomorrow. I will note down all the important points.',
    sourceLanguage: 'Malayalam',
    targetLanguage: 'English',
    timestamp: '09:45',
    status: ChatMessageStatus.offline,
    confidence: 0.94,
  ),
];
