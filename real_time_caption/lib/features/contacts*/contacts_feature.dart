/*
1. PAGE NAME
   Contacts Feature Entry

2. PURPOSE
   Provides the public exports for the LinguaLive Contacts feature.

3. DESCRIPTION
   This barrel file exposes the Contacts page and feature-specific public
   types without introducing backend, networking, authentication, or
   persistence functionality.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Application navigation → ContactsPage.

6. DYNAMIC COMPONENTS
   ContactsPage and its local presentation components.

7. FUTURE BACKEND INTEGRATION
   The page and data contracts can later be connected to the contacts
   repository described by the application's architecture.

8. TECHNOLOGIES USED
   Dart and Flutter Material 3 through the exported presentation page.

9. REQUIRED DATA MODELS
   ContactFeatureModel and ContactFeatureEntity.

10. FUTURE API ENDPOINTS
    Not defined by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not defined by the supplied project documentation.

12. REQUIRED ASSETS
    None required; avatars use local initials.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Uses the application's active Material 3 ColorScheme.

15. ANIMATIONS
    Local lightweight implicit animations are used by presentation widgets.

16. ACCESSIBILITY
    Public page is designed for semantic labels and scalable text.

17. EDGE CASES
    Empty contacts, search with no matches, long names, and offline state.

18. VALIDATION RULES
    Search accepts arbitrary text and performs local filtering only.

19. ERROR HANDLING
    Local UI error state only.

20. LOADING STATE
    Local dummy loading state only.

21. EMPTY STATE
    Local empty-contact and no-search-result states.

22. OFFLINE BEHAVIOUR
    Displays a local offline representation without connectivity detection.

23. SECURITY CONSIDERATIONS
    No personal data, authentication, networking, or persistence is used.

24. PERFORMANCE OPTIMIZATIONS
    Small immutable models, local filtering, and const widgets where possible.

25. WIDGET TREE OVERVIEW
    ContactsPage
      ├── ContactsHeader
      ├── ContactsSearchBar
      ├── ContactsFilterChips
      └── ContactFeatureTile / ContactsState

26. COMPLETE TESTING CHECKLIST
    Covered by the screen-level ContactsPage checklist.
*/

export 'data/models/contacts_feature_model.dart';
export 'data/data_sources/mock_contacts_data_source.dart';
export 'data/dummy/contacts_dummy_data.dart';
export 'domain/entities/contacts_feature_entity.dart';
export 'presentation/controllers/contacts_controller.dart';
export 'presentation/pages/contacts_page.dart';
export 'presentation/widgets/contact_list_tile.dart';
export 'presentation/widgets/contacts_filter_chips.dart';
export 'presentation/widgets/contacts_header.dart';
export 'presentation/widgets/contacts_search_bar.dart';
export 'presentation/widgets/contacts_states.dart';
