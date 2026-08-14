/*
1. PAGE NAME
   Voice Clone Domain Entity

2. PURPOSE
   Defines the immutable domain representation of a local voice profile.

3. DESCRIPTION
   Pure Dart entity used by the Voice Clone feature presentation layer.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Voice Clone page → voice profile entity.

6. DYNAMIC COMPONENTS
   Voice profile name, language, sample duration, readiness state.

7. FUTURE BACKEND INTEGRATION
   A future voice-profile/voice-cloning service may consume this domain
   representation after explicit consent and supported project integration.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   VoiceCloneEntity.

10. FUTURE API ENDPOINTS
    Not defined by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not defined by the supplied project documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons are selected by presentation widgets.

14. THEME COLORS
    Supplied by the application ThemeData.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Presentation layer supplies semantic labels.

17. EDGE CASES
    Empty name, unsupported language label, zero-duration sample.

18. VALIDATION RULES
    Entity values remain immutable; presentation validates user-facing input.

19. ERROR HANDLING
    Errors are represented by presentation state models.

20. LOADING STATE
    Represented by presentation state models.

21. EMPTY STATE
    Represented by presentation state models.

22. OFFLINE BEHAVIOUR
    UI may show an offline state; no network operation is performed.

23. SECURITY CONSIDERATIONS
    Voice data must not be transmitted or persisted by this UI-only implementation.

24. PERFORMANCE OPTIMIZATIONS
    Immutable fields and const-friendly construction.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Validate construction, equality expectations, null-safety assumptions,
    and rendering compatibility with the presentation layer.
*/

enum VoiceProfileStatus {
  ready,
  processing,
  needsRecording,
  error,
  offline,
}

class VoiceCloneEntity {
  const VoiceCloneEntity({
    required this.name,
    required this.language,
    required this.sampleDuration,
    required this.status,
    required this.isDefault,
  });

  final String name;
  final String language;
  final Duration sampleDuration;
  final VoiceProfileStatus status;
  final bool isDefault;
}