/*
1. PAGE NAME
   Transcription Feature Barrel

2. PURPOSE
   Provides the public exports for the LinguaLive Transcription feature.

3. DESCRIPTION
   Exposes the transcription page and feature-level public types without
   introducing additional application infrastructure.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Application routing → TranscriptionPage.

6. DYNAMIC COMPONENTS
   TranscriptionPage and its local presentation components.

7. FUTURE BACKEND INTEGRATION
   Backend and AI services are intentionally excluded from this UI-only phase.

8. TECHNOLOGIES USED
   Dart and Flutter Material 3 through exported feature files.

9. REQUIRED DATA MODELS
   TranscriptionModel and TranscriptionEntity.

10. FUTURE API ENDPOINTS
    Not defined at this UI-only stage.

11. DATABASE COLLECTIONS/TABLES
    Not defined at this UI-only stage.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons only.

14. THEME COLORS
    Uses the application's active Material 3 ColorScheme.

15. ANIMATIONS
    Presentation widgets use lightweight implicit animations.

16. ACCESSIBILITY
    Public page uses Material semantics and accessible controls.

17. EDGE CASES
    Empty, loading, error, offline, paused, and processing states.

18. VALIDATION RULES
    UI state only; no remote validation.

19. ERROR HANDLING
    Represented locally through the presentation state widgets.

20. LOADING STATE
    Local skeleton/progress representation.

21. EMPTY STATE
    Local empty transcript representation.

22. OFFLINE BEHAVIOUR
    Displays an offline state without performing connectivity detection.

23. SECURITY CONSIDERATIONS
    No audio, transcript, or personal data is persisted.

24. PERFORMANCE OPTIMIZATIONS
    Immutable models, const widgets, and local dummy data.

25. WIDGET TREE OVERVIEW
    TranscriptionPage
      → Header
      → LanguagePairCard
      → Status/State area
      → TranscriptSegmentCard list
      → Bottom transcription controls.

26. COMPLETE TESTING CHECKLIST
    See the screen-level checklist supplied with this feature.
*/

export 'presentation/pages/transcription_page.dart';
