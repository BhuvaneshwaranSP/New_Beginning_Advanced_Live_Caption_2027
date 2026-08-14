/*
1. PAGE NAME
   Voice Clone Data Model

2. PURPOSE
   Provides the data-layer representation of a voice profile.

3. DESCRIPTION
   Lightweight model used with local dummy data only.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Mock data source → model → domain entity → presentation.

6. DYNAMIC COMPONENTS
   Profile metadata and status.

7. FUTURE BACKEND INTEGRATION
   A future repository may map remote voice-profile records into this model.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   VoiceCloneModel.

10. FUTURE API ENDPOINTS
    Not specified in the supplied documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified in the supplied documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    Not applicable.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Applied by presentation widgets.

17. EDGE CASES
    Zero-duration recordings and non-ready statuses.

18. VALIDATION RULES
    Values are constrained through immutable construction.

19. ERROR HANDLING
    Status is represented explicitly.

20. LOADING STATE
    Processing status.

21. EMPTY STATE
    Handled by the page when no profile exists.

22. OFFLINE BEHAVIOUR
    Offline status can be represented without networking.

23. SECURITY CONSIDERATIONS
    No actual voice bytes are stored in this model.

24. PERFORMANCE OPTIMIZATIONS
    Small immutable object.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify status mapping and conversion to the domain entity.
*/

import '../../domain/entities/voice_clone_entity.dart';

class VoiceCloneModel {
  const VoiceCloneModel({
    required this.name,
    required this.language,
    required this.sampleDurationSeconds,
    required this.status,
    required this.isDefault,
  });

  final String name;
  final String language;
  final int sampleDurationSeconds;
  final VoiceProfileStatus status;
  final bool isDefault;

  VoiceCloneEntity toEntity() {
    return VoiceCloneEntity(
      name: name,
      language: language,
      sampleDuration: Duration(seconds: sampleDurationSeconds),
      status: status,
      isDefault: isDefault,
    );
  }
}
