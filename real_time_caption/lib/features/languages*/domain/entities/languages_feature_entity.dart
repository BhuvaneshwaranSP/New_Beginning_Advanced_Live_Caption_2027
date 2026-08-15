/*
1. PAGE NAME
   Languages Feature Domain Entities

2. PURPOSE
   Defines immutable domain-level language objects used by the Languages feature.

3. DESCRIPTION
   Represents a language available to LinguaLive, including selection,
   preference, recency, availability, and auto-detection support.

4. UI SECTIONS
   My Languages, Preferred Languages, Recent Languages,
   All Supported Languages, and Auto-detect.

5. NAVIGATION FLOW
   Languages page → language selection → future application language/session
   integration.

6. DYNAMIC COMPONENTS
   Language cards, language tiles, source/target pair, availability indicator.

7. FUTURE BACKEND INTEGRATION
   Future language catalog and user-language preferences will populate these
   entities. This page currently uses local dummy data only.

8. TECHNOLOGIES USED
   Pure Dart immutable entity.

9. REQUIRED DATA MODELS
   LanguageFeatureEntity.

10. FUTURE API ENDPOINTS
    Not implemented. Future language catalog and user preference endpoints
    will be determined by the production service contract.

11. DATABASE COLLECTIONS/TABLES
    Not implemented. Future user language preferences may be persisted
    according to the project's eventual storage design.

12. REQUIRED ASSETS
    No assets required. Language identity uses Material icons and text.

13. REQUIRED ICONS
    language, translate, history, star, download, check, swap_horiz.

14. THEME COLORS
    Uses application Material 3 ColorScheme at presentation level.

15. ANIMATIONS
    Lightweight selection animation handled by presentation widgets.

16. ACCESSIBILITY
    Semantic language names, selected states, availability labels,
    and descriptive controls.

17. EDGE CASES
    Long language names, unavailable languages, duplicate selections,
    empty lists, and search with no matches.

18. VALIDATION RULES
    Source and target languages should remain distinct when possible.

19. ERROR HANDLING
    Presentation layer provides local empty/unavailable representations.

20. LOADING STATE
    Represented locally by the presentation state widgets.

21. EMPTY STATE
    Represented locally when no languages match a search or category.

22. OFFLINE BEHAVIOUR
    UI can represent locally unavailable language resources without
    implementing connectivity.

23. SECURITY CONSIDERATIONS
    No credentials, private data, or remote requests are handled here.

24. PERFORMANCE OPTIMIZATIONS
    Immutable objects and const-compatible UI values where practical.

25. WIDGET TREE OVERVIEW
    LanguagesPage → header → pair card → sections → language tiles.

26. COMPLETE TESTING CHECKLIST
    Validate selection, availability, search, accessibility, responsiveness,
    dark mode, large text, and empty states.
*/

class LanguageFeatureEntity {
  const LanguageFeatureEntity({
    required this.id,
    required this.name,
    required this.nativeName,
    required this.code,
    required this.region,
    required this.available,
    required this.isPreferred,
    required this.isRecent,
  });

  final String id;
  final String name;
  final String nativeName;
  final String code;
  final String region;
  final bool available;
  final bool isPreferred;
  final bool isRecent;
}
