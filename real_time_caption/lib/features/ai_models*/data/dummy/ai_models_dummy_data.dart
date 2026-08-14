/*
1. PAGE NAME
   AI Models Dummy Data

2. PURPOSE
   Supplies realistic local AI model metadata for the UI-only AI Models screen.

3. DESCRIPTION
   The data reflects the models identified in the LinguaLive processing flow:
   Whisper Large/Turbo, NLLB-200 Distilled, Gemma 3B, CapTTS, ONNX Runtime,
   and MM-MO.

4. UI SECTIONS
   Model cards, categories, statuses, language support, and recommendations.

5. NAVIGATION FLOW
   Dummy data → mock data source → controller → AI Models page.

6. DYNAMIC COMPONENTS
   Model name, description, category, status, supported languages,
   recommended badge, offline badge, and performance label.

7. FUTURE BACKEND INTEGRATION
   Replace this static catalog with model metadata delivered by the intended
   model-management infrastructure.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   AiModelModel.

10. FUTURE API ENDPOINTS
   Not defined.

11. DATABASE COLLECTIONS/TABLES
   Not defined.

12. REQUIRED ASSETS
   None.

13. REQUIRED ICONS
   None.

14. THEME COLORS
   None.

15. ANIMATIONS
   None.

16. ACCESSIBILITY
   Text content is designed to remain readable through the presentation layer.

17. EDGE CASES
   The list intentionally contains models with different statuses and
   capabilities so the UI can represent varied states.

18. VALIDATION RULES
   Dummy values are compile-time controlled.

19. ERROR HANDLING
   Not applicable to static data.

20. LOADING STATE
   Simulated by the controller.

21. EMPTY STATE
   Search can produce an empty filtered result.

22. OFFLINE BEHAVIOUR
   Whisper Turbo and relevant model entries can visually represent offline-ready
   availability without implementing actual offline inference.

23. SECURITY CONSIDERATIONS
   No keys, URLs, credentials, or private configuration are included.

24. PERFORMANCE OPTIMIZATIONS
   The list is created once as a top-level constant.

25. WIDGET TREE OVERVIEW
   Not applicable.

26. COMPLETE TESTING CHECKLIST
   Verify all model names, categories, status labels, and multilingual examples.
*/

import '../models/ai_model_model.dart';
import '../../domain/entities/ai_model_entity.dart';

const List<AiModelModel> aiModelsDummyData = [
  AiModelModel(
    id: 'whisper-large',
    name: 'Whisper Large',
    family: 'Whisper',
    description:
        'High-capacity speech recognition model for accurate multilingual transcription.',
    category: AiModelCategory.speechRecognition,
    status: AiModelStatus.active,
    languages: ['English', 'Tamil', 'Hindi', 'Telugu', 'Malayalam'],
    primaryUse: 'Speech recognition',
    performanceLabel: 'High accuracy',
    isRecommended: true,
    isOfflineReady: true,
  ),
  AiModelModel(
    id: 'whisper-turbo',
    name: 'Whisper Turbo',
    family: 'Whisper',
    description:
        'Faster speech recognition variant intended for responsive real-time communication.',
    category: AiModelCategory.speechRecognition,
    status: AiModelStatus.offlineReady,
    languages: ['English', 'Tamil', 'Hindi', 'Telugu', 'Malayalam'],
    primaryUse: 'Low-latency speech recognition',
    performanceLabel: 'Fast response',
    isRecommended: true,
    isOfflineReady: true,
  ),
  AiModelModel(
    id: 'nllb-200-distilled',
    name: 'NLLB-200 Distilled',
    family: 'NLLB-200',
    description:
        'Multilingual neural machine translation model for converting recognized text between languages.',
    category: AiModelCategory.translation,
    status: AiModelStatus.active,
    languages: ['English', 'Tamil', 'Hindi', 'Telugu', 'Malayalam', '200+'],
    primaryUse: 'Machine translation',
    performanceLabel: 'Multilingual',
    isRecommended: true,
    isOfflineReady: false,
  ),
  AiModelModel(
    id: 'gemma-3b',
    name: 'Gemma 3B',
    family: 'Gemma',
    description:
        'Compact language model used for contextual and grammar-aware refinement of translated text.',
    category: AiModelCategory.contextualLanguage,
    status: AiModelStatus.available,
    languages: ['English', 'Multilingual context'],
    primaryUse: 'Context and grammar correction',
    performanceLabel: 'Context aware',
    isRecommended: false,
    isOfflineReady: false,
  ),
  AiModelModel(
    id: 'captts',
    name: 'CapTTS',
    family: 'CapTTS',
    description:
        'Text-to-speech component intended for optional translated voice output.',
    category: AiModelCategory.textToSpeech,
    status: AiModelStatus.available,
    languages: ['English', 'Multilingual output'],
    primaryUse: 'Text-to-speech',
    performanceLabel: 'Natural voice',
    isRecommended: false,
    isOfflineReady: false,
  ),
  AiModelModel(
    id: 'onnx-runtime',
    name: 'ONNX Runtime',
    family: 'ONNX Runtime',
    description:
        'Inference runtime layer intended to execute optimized model workloads efficiently.',
    category: AiModelCategory.runtime,
    status: AiModelStatus.available,
    languages: ['Model dependent'],
    primaryUse: 'Inference runtime',
    performanceLabel: 'Efficient inference',
    isRecommended: false,
    isOfflineReady: true,
  ),
  AiModelModel(
    id: 'mm-mo',
    name: 'MM-MO',
    family: 'Model Optimization',
    description:
        'Project-level model optimization approach represented in the inference pipeline for efficient execution.',
    category: AiModelCategory.optimization,
    status: AiModelStatus.processing,
    languages: ['Model dependent'],
    primaryUse: 'Model optimization',
    performanceLabel: 'Resource optimized',
    isRecommended: false,
    isOfflineReady: true,
  ),
];
