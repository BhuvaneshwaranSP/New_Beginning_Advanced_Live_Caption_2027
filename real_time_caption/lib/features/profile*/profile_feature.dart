/*
1. PAGE NAME
   Profile Feature Entry

2. PURPOSE
   Provides the public exports for the LinguaLive Profile feature.

3. DESCRIPTION
   Exposes the Profile page, model, entity, dummy data source, and controller
   without introducing backend or infrastructure functionality.

4. UI SECTIONS
   Not directly applicable. This file exposes the feature modules.

5. NAVIGATION FLOW
   Application navigation → Profile feature → ProfilePage.

6. DYNAMIC COMPONENTS
   Profile information, language preference, profile actions, and UI states.

7. FUTURE BACKEND INTEGRATION
   The exported presentation and data contracts can later be connected to
   the application's profile/account data flow.

8. TECHNOLOGIES USED
   Dart exports only.

9. REQUIRED DATA MODELS
   ProfileFeatureModel and ProfileFeatureEntity.

10. FUTURE API ENDPOINTS
    Not specified by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified by the supplied project documentation.

12. REQUIRED ASSETS
    No mandatory assets.

13. REQUIRED ICONS
    Material Icons used by the presentation layer.

14. THEME COLORS
    Uses the application's Material 3 theme.

15. ANIMATIONS
    Lightweight presentation-layer animations.

16. ACCESSIBILITY
    Implemented by the Profile page and its widgets.

17. EDGE CASES
    Null-safe and long profile values are handled by the presentation layer.

18. VALIDATION RULES
    No backend validation is implemented in this UI-only feature.

19. ERROR HANDLING
    Local UI error state only.

20. LOADING STATE
    Local dummy loading representation.

21. EMPTY STATE
    Local dummy empty representation.

22. OFFLINE BEHAVIOUR
    Profile UI remains displayable using local dummy data.

23. SECURITY CONSIDERATIONS
    No credentials, tokens, or sensitive authentication logic are stored here.

24. PERFORMANCE OPTIMIZATIONS
    Small immutable models and reusable widgets.

25. WIDGET TREE OVERVIEW
    ProfilePage
      → ProfileHeader
      → LanguagePreferenceCard
      → ProfileActionList
      → ProfileStates

26. COMPLETE TESTING CHECKLIST
    See the feature-level checklist supplied before this file.
*/

export 'data/data_sources/mock_profile_data_source.dart';
export 'data/dummy/profile_dummy_data.dart';
export 'data/models/profile_feature_model.dart';
export 'domain/entities/profile_feature_entity.dart';
export 'presentation/controllers/profile_controller.dart';
export 'presentation/pages/profile_page.dart';
export 'presentation/widgets/language_preference_card.dart';
export 'presentation/widgets/profile_action_list.dart';
export 'presentation/widgets/profile_header.dart';
export 'presentation/widgets/profile_states.dart';
