/*
1. PAGE NAME
   Voice Clone Dummy Data

2. PURPOSE
   Supplies realistic local multilingual voice-profile data.

3. DESCRIPTION
   No external service, audio file, or persistence is used.

4. UI SECTIONS
   Profile list and current profile.

5. NAVIGATION FLOW
   Dummy data → mock source → page.

6. DYNAMIC COMPONENTS
   Profile names, languages, durations, and states.

7. FUTURE BACKEND INTEGRATION
   Replace this local source with the project's supported voice-profile
   source when such functionality is formally defined.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   VoiceCloneModel.

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
    Text is exposed through the presentation layer.

17. EDGE CASES
    Empty collections are supported by the page.

18. VALIDATION RULES
    Sample durations are non-negative.

19. ERROR HANDLING
    Error state is separately represented by the controller.

20. LOADING STATE
    Controller can expose a local loading state.

21. EMPTY STATE
    Controller can expose an empty state.

22. OFFLINE BEHAVIOUR
    Includes an offline demonstration profile.

23. SECURITY CONSIDERATIONS
    No actual biometric voice data is included.

24. PERFORMANCE OPTIMIZATIONS
    Static const collection.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify multilingual content, status rendering, and empty-list handling.
*/

import '../models/voice_clone_model.dart';
import '../../domain/entities/voice_clone_entity.dart';

class VoiceCloneDummyData {
  const VoiceCloneDummyData._();

  static const profiles = <VoiceCloneModel>[
    VoiceCloneModel(
      name: 'My Natural Voice',
      language: 'English',
      sampleDurationSeconds: 42,
      status: VoiceProfileStatus.ready,
      isDefault: true,
    ),
    VoiceCloneModel(
      name: 'தமிழ் Voice',
      language: 'Tamil',
      sampleDurationSeconds: 38,
      status: VoiceProfileStatus.needsRecording,
      isDefault: false,
    ),
    VoiceCloneModel(
      name: 'తెలుగు Voice',
      language: 'Telugu',
      sampleDurationSeconds: 31,
      status: VoiceProfileStatus.offline,
      isDefault: false,
    ),
  ];
}