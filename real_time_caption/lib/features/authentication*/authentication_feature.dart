/*
1. PAGE NAME
   Authentication Feature Entry

2. PURPOSE
   Provides the public exports for the LinguaLive authentication feature.

3. DESCRIPTION
   Keeps authentication presentation and local UI models accessible through one
   feature-level entry point.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Application authentication route → AuthenticationPage → application-defined
   authenticated destination.

6. DYNAMIC COMPONENTS
   Authentication mode, form state, loading state, and local validation state.

7. FUTURE BACKEND INTEGRATION
   The application authentication service will be connected from the
   authentication presentation/controller integration point.

8. TECHNOLOGIES USED
   Dart and Flutter Material 3.

9. REQUIRED DATA MODELS
   AuthenticationFeatureModel and AuthenticationFeatureEntity.

10. FUTURE API ENDPOINTS
    Not defined by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not defined by the supplied project documentation.

12. REQUIRED ASSETS
    No external asset is required by this feature.

13. REQUIRED ICONS
    Material Icons supplied by Flutter.

14. THEME COLORS
    Uses the application's Material 3 ColorScheme.

15. ANIMATIONS
    Lightweight mode-transition animation.

16. ACCESSIBILITY
    Semantic labels, accessible form controls, sufficient touch targets,
    scalable text, and non-color-only validation feedback.

17. EDGE CASES
    Empty fields, invalid email, short password, long text, keyboard visibility,
    and large accessibility text.

18. VALIDATION RULES
    Email must be non-empty and contain a valid basic email structure.
    Password must contain at least eight characters.

19. ERROR HANDLING
    Local validation messages are displayed without network operations.

20. LOADING STATE
    Local simulated processing state is represented by the controller.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Authentication remains a UI-only representation and does not attempt
    network authentication.

23. SECURITY CONSIDERATIONS
    No credentials are persisted, transmitted, logged, or sent to a service.

24. PERFORMANCE OPTIMIZATIONS
    Small immutable models and localized widget rebuilds.

25. WIDGET TREE OVERVIEW
    AuthenticationPage
      → Brand header
      → Mode switcher
      → Authentication form
      → State feedback

26. COMPLETE TESTING CHECKLIST
    See the feature/page test checklist supplied with this implementation.
*/

library authentication_feature;

export 'data/models/authentication_feature_model.dart';
export 'data/data_sources/mock_authentication_data_source.dart';
export 'data/dummy/authentication_dummy_data.dart';
export 'domain/entities/authentication_feature_entity.dart';
export 'presentation/pages/authentication_page.dart';
export 'presentation/controllers/authentication_controller.dart';
export 'presentation/widgets/authentication_brand_header.dart';
export 'presentation/widgets/authentication_form.dart';
export 'presentation/widgets/authentication_mode_switcher.dart';
export 'presentation/widgets/authentication_states.dart';
