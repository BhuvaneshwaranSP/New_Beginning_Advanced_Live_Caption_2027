/*
1. PAGE NAME
   About Feature Dummy Data

2. PURPOSE
   Supplies realistic local demonstration content for the About screen.

3. DESCRIPTION
   No API, database, networking, authentication, or persistence is used.
   The content represents documented LinguaLive capabilities only.

4. UI SECTIONS
   Application identity, mission, capabilities, communication modes,
   and technology overview.

5. NAVIGATION FLOW
   Dummy data → model → mapper → entity → About page.

6. DYNAMIC COMPONENTS
   Capability cards, communication-mode cards, and technology cards.

7. FUTURE BACKEND INTEGRATION
   If application metadata becomes configurable, this local source can later
   be replaced by an approved repository/data source without changing the
   presentation contract.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   AboutFeatureModel and its nested data models.

10. FUTURE API ENDPOINTS
    None specified by the current project documentation for this page.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    No external assets required.

13. REQUIRED ICONS
    Selected in presentation because icons are visual concerns.

14. THEME COLORS
    Uses the application's Material 3 ColorScheme in presentation.

15. ANIMATIONS
    Presentation controls lightweight animations.

16. ACCESSIBILITY
    Presentation provides semantics and readable layouts.

17. EDGE CASES
    Long technology names, multilingual content, and empty lists.

18. VALIDATION RULES
    Demo content should remain representative of documented capabilities.

19. ERROR HANDLING
    No external source errors exist at this stage.

20. LOADING STATE
    Not required for local dummy content.

21. EMPTY STATE
    Presentation supports empty collections defensively.

22. OFFLINE BEHAVIOUR
    Content remains available because it is local.

23. SECURITY CONSIDERATIONS
    No sensitive user information is included.

24. PERFORMANCE OPTIMIZATIONS
    Static const data avoids unnecessary allocations.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Data availability, multilingual strings, long labels,
    empty collections, and model compatibility.
*/

import '../models/about_feature_model.dart';

const AboutFeatureModel aboutDummyData = AboutFeatureModel(
  appName: 'LinguaLive',
  version: '1.0.0',
  description:
      'An AI-powered multilingual communication platform designed to '
      'make real-time conversations easier across language barriers.',
  mission:
      'Connect people through speech, captions, translation, and '
      'context-aware multilingual communication.',
  capabilities: [
    AboutCapabilityModel(
      title: 'Live Speech',
      description:
          'Real-time speech recognition, speech-to-text, captioning, '
          'and multilingual communication.',
    ),
    AboutCapabilityModel(
      title: 'Call Caption',
      description:
          'Live captions and multilingual translation designed for '
          'communication during calls.',
    ),
    AboutCapabilityModel(
      title: 'Multilingual Chat',
      description:
          'Spoken conversations can be represented as chat while '
          'supporting multilingual translation.',
    ),
    AboutCapabilityModel(
      title: 'Context-Aware Translation',
      description:
          'Translation is designed to preserve conversational context '
          'and meaning rather than relying only on literal conversion.',
    ),
    AboutCapabilityModel(
      title: 'Offline Support',
      description:
          'The project is designed to support communication scenarios '
          'where connectivity is limited or unavailable.',
    ),
    AboutCapabilityModel(
      title: 'Collaborative Sessions',
      description:
          'QR-based session sharing and multi-user communication are '
          'part of the documented project capabilities.',
    ),
  ],
  communicationModes: [
    AboutModeModel(
      title: 'Live Speech',
      description:
          'Speak naturally while captions and translated content '
          'are presented in real time.',
    ),
    AboutModeModel(
      title: 'Call Caption',
      description:
          'Follow conversations through live speech recognition, '
          'captions, and translation.',
    ),
    AboutModeModel(
      title: 'Chat',
      description:
          'Continue multilingual conversations through translated '
          'text and conversation history.',
    ),
  ],
  technologies: [
    AboutTechnologyModel(
      name: 'Whisper Large / Turbo',
      role: 'Speech recognition',
    ),
    AboutTechnologyModel(
      name: 'Whisper Streaming',
      role: 'Streaming automatic speech recognition',
    ),
    AboutTechnologyModel(
      name: 'NLLB-200 Distilled',
      role: 'Machine translation',
    ),
    AboutTechnologyModel(
      name: 'Gemma 3B',
      role: 'Context and grammar correction',
    ),
    AboutTechnologyModel(
      name: 'Silero VAD / WebRTC VAD',
      role: 'Voice activity detection',
    ),
    AboutTechnologyModel(name: 'DeepFilterNet', role: 'Noise reduction'),
    AboutTechnologyModel(name: 'pyannote-audio', role: 'Speaker diarization'),
    AboutTechnologyModel(name: 'SRC-TDNN', role: 'Speaker recognition'),
    AboutTechnologyModel(name: 'ONNX Runtime', role: 'Inference runtime'),
    AboutTechnologyModel(name: 'WebSocket', role: 'Real-time communication'),
  ],
);
