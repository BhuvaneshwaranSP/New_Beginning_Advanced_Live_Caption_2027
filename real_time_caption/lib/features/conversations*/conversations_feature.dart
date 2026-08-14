/*
1. PAGE NAME
   Conversations Feature

2. PURPOSE
   Provides the public entry points for the LinguaLive Conversations feature.

3. DESCRIPTION
   Exposes the Conversations page and feature-level components without
   introducing backend, networking, persistence, or real AI functionality.

4. UI SECTIONS
   Conversations page, search, filters, conversation history cards, and states.

5. NAVIGATION FLOW
   Home/navigation area → Conversations page.
   Conversation card → future conversation/session detail flow.

6. DYNAMIC COMPONENTS
   Local conversation models, search results, filters, and UI states.

7. FUTURE BACKEND INTEGRATION
   The page will eventually consume persisted Session History data from the
   project's planned storage/database layer.

8. TECHNOLOGIES USED
   Flutter Material 3 and Dart.

9. REQUIRED DATA MODELS
   ConversationsFeatureModel and ConversationsFeatureEntity.

10. FUTURE API ENDPOINTS
    None defined by the supplied project documentation for this screen.

11. DATABASE COLLECTIONS/TABLES
    Future session-history storage; exact schema is not defined by the
    supplied project documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Uses the application's Material 3 ColorScheme.

15. ANIMATIONS
    Lightweight implicit card and state transitions.

16. ACCESSIBILITY
    Semantic labels, adequate touch targets, scalable text, and non-color-only
    status communication.

17. EDGE CASES
    Empty history, search with no matches, long titles, multilingual text,
    offline state, and unavailable session metadata.

18. VALIDATION RULES
    Search input is treated as plain text and trimmed before filtering.

19. ERROR HANDLING
    A local error representation with retry is provided.

20. LOADING STATE
    A local loading representation is provided.

21. EMPTY STATE
    A dedicated empty-history/search-empty representation is provided.

22. OFFLINE BEHAVIOUR
    Displays a local offline representation without attempting connectivity.

23. SECURITY CONSIDERATIONS
    No conversation data is transmitted, persisted, or processed externally
    by this UI-only implementation.

24. PERFORMANCE OPTIMIZATIONS
    Uses const widgets where possible and lightweight list rendering.

25. WIDGET TREE OVERVIEW
    Material page → SafeArea → CustomScrollView → header → search/filter →
    state content → conversation cards.

26. COMPLETE TESTING CHECKLIST
    Test responsiveness, accessibility, dark mode, large text, search,
    filtering, empty/loading/error/offline states, multilingual content,
    callbacks, scrolling, animation, and analyzer cleanliness.
*/

export 'presentation/pages/conversations_page.dart';
export 'presentation/controllers/conversations_controller.dart';
export 'presentation/widgets/conversation_card.dart';
export 'presentation/widgets/conversation_filter_bar.dart';
export 'presentation/widgets/conversations_header.dart';
export 'presentation/widgets/conversation_states.dart';
