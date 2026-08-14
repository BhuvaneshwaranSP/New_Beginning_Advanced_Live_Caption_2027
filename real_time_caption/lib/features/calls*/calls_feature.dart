/*
1. PAGE NAME
   Calls Feature

2. PURPOSE
   Public entry point for the LinguaLive Calls feature.

3. DESCRIPTION
   Exposes the Calls page and feature-level types through a single barrel file.
   The current implementation is UI-only and uses local dummy data.

4. UI SECTIONS
   The feature contains:
   - Calls header
   - Search field
   - Call status summary
   - Recent calls
   - Incoming call state
   - Empty/loading/error/offline states

5. NAVIGATION FLOW
   Calls page → Call item interaction → future call caption experience.

6. DYNAMIC COMPONENTS
   - Recent call cards
   - Participant information
   - Language pair
   - Call status
   - Duration
   - Incoming call state

7. FUTURE BACKEND INTEGRATION
   Future call-session services will supply live call state, participant
   information, captions, translations, and session history.

8. TECHNOLOGIES USED
   - Flutter
   - Material 3
   - Dart null safety

9. REQUIRED DATA MODELS
   - CallsFeatureModel
   - CallParticipantModel
   - CallLanguagePairModel
   - CallSessionEntity

10. FUTURE API ENDPOINTS
    No endpoints are implemented.
    Future integration will require call-session creation, participant
    presence, call-state updates, caption streaming, and translation streams.

11. DATABASE COLLECTIONS/TABLES
    No database is implemented.
    Future persistence may store call-session history and participant metadata.

12. REQUIRED ASSETS
    No external assets are required for the current UI.

13. REQUIRED ICONS
    Material Icons:
    phone, video_call, search, translate, mic, call_end, language,
    wifi, signal_cellular_alt, history.

14. THEME COLORS
    Uses the active application Material 3 ColorScheme.
    No feature-specific hard-coded color system is required.

15. ANIMATIONS
    Lightweight AnimatedContainer and AnimatedSwitcher transitions.

16. ACCESSIBILITY
    Semantic labels, adequate touch targets, readable status text,
    and non-color-only state communication.

17. EDGE CASES
    Empty call history, long names, long language labels, offline state,
    reconnecting state, invalid/missing participant data.

18. VALIDATION RULES
    Display-only UI validation:
    participant names and language labels fall back to safe display values.

19. ERROR HANDLING
    Local error representation only. No real retry/network operation.

20. LOADING STATE
    Local skeleton-style loading representation.

21. EMPTY STATE
    Local empty call-history representation.

22. OFFLINE BEHAVIOUR
    Displays a local offline state without attempting reconnection.

23. SECURITY CONSIDERATIONS
    No real call credentials, personal data, tokens, or network information
    are stored or processed by this UI-only implementation.

24. PERFORMANCE OPTIMIZATIONS
    Const widgets where possible, immutable dummy data, small reusable widgets,
    and localized state updates.

25. WIDGET TREE OVERVIEW
    CallsPage
      └── Scaffold
          ├── AppBar
          └── CustomScrollView
              ├── Header section
              ├── Search section
              ├── Status section
              ├── Incoming call section
              └── Recent calls section

26. COMPLETE TESTING CHECKLIST
    See the test checklist supplied before this file.
*/

export 'data/models/calls_feature_model.dart';
export 'domain/entities/calls_feature_entity.dart';
export 'presentation/controllers/calls_controller.dart';
export 'presentation/pages/calls_page.dart';
