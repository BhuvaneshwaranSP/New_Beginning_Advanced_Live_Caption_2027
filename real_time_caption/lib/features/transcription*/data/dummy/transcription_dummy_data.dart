/*
1. PAGE NAME
   Transcription Dummy Data

2. PURPOSE
   Supplies realistic local multilingual transcription records.

3. DESCRIPTION
   Contains development-only data representing a live multilingual
   conversation.

4. UI SECTIONS
   Transcript list, language pair, and live status.

5. NAVIGATION FLOW
   Dummy data → Mock data source → Controller → TranscriptionPage.

6. DYNAMIC COMPONENTS
   Speaker names, languages, timestamps, confidence, and transcript text.

7. FUTURE BACKEND INTEGRATION
   Real streaming transcription will replace this local dataset.

8. TECHNOLOGIES USED
   Pure Dart.

9. REQUIRED DATA MODELS
   TranscriptionModel.

10. FUTURE API ENDPOINTS
    Not defined.

11. DATABASE COLLECTIONS/TABLES
    Not defined.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    Not applicable.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Text content is suitable for semantic rendering.

17. EDGE CASES
    Multilingual text and varying transcript lengths.

18. VALIDATION RULES
    Confidence values remain between 0 and 1.

19. ERROR HANDLING
    Not applicable.

20. LOADING STATE
    Not represented in the dataset.

21. EMPTY STATE
    Controller can expose an empty list.

22. OFFLINE BEHAVIOUR
    Dummy data allows the UI to render without connectivity.

23. SECURITY CONSIDERATIONS
    Contains no real user information.

24. PERFORMANCE OPTIMIZATIONS
    Small immutable dataset.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Test short, long, multilingual, and mixed-speaker records.
*/

import '../models/transcription_model.dart';

const List<TranscriptionModel> transcriptionDummyData = [
  TranscriptionModel(
    id: 'tx-001',
    speakerName: 'Arun',
    languageCode: 'EN',
    originalText: 'Good morning everyone. Shall we begin the meeting?',
    translatedText: 'காலை வணக்கம் அனைவருக்கும். கூட்டத்தைத் தொடங்கலாமா?',
    timestamp: '10:42:08',
    confidence: 0.97,
    isFinal: true,
  ),
  TranscriptionModel(
    id: 'tx-002',
    speakerName: 'Meena',
    languageCode: 'TA',
    originalText: 'ஆம், முதலில் இன்றைய முக்கியமான விஷயங்களைப் பார்க்கலாம்.',
    translatedText: 'Yes, let us first look at the important topics for today.',
    timestamp: '10:42:17',
    confidence: 0.94,
    isFinal: true,
  ),
  TranscriptionModel(
    id: 'tx-003',
    speakerName: 'Rahul',
    languageCode: 'HI',
    originalText: 'हम पहले पिछले सप्ताह की प्रगति की समीक्षा कर सकते हैं।',
    translatedText: 'We can first review the progress from last week.',
    timestamp: '10:42:29',
    confidence: 0.91,
    isFinal: true,
  ),
  TranscriptionModel(
    id: 'tx-004',
    speakerName: 'Arun',
    languageCode: 'EN',
    originalText:
        'The latest numbers look positive, especially in the regional teams.',
    translatedText:
        'சமீபத்திய எண்ணிக்கைகள் நன்றாக உள்ளன, குறிப்பாக பிராந்திய அணிகளில்.',
    timestamp: '10:42:43',
    confidence: 0.96,
    isFinal: true,
  ),
  TranscriptionModel(
    id: 'tx-005',
    speakerName: 'Meena',
    languageCode: 'TA',
    originalText: 'அடுத்த கட்டத்திற்கான பொறுப்புகளை இப்போது பகிரலாம்.',
    translatedText:
        'We can now assign the responsibilities for the next stage.',
    timestamp: '10:42:56',
    confidence: 0.93,
    isFinal: true,
  ),
];
