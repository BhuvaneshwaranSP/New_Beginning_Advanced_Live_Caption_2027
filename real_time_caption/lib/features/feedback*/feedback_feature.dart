/*
1. PAGE NAME
   Feedback Feature Barrel

2. PURPOSE
   Provides the public exports for the LinguaLive Feedback feature.

3. DESCRIPTION
   Keeps feedback feature imports centralized without changing the existing
   project folder structure.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Existing application navigation → FeedbackPage.

6. DYNAMIC COMPONENTS
   Feedback page, rating, category, message, and UI states.

7. FUTURE BACKEND INTEGRATION
   Future feedback submission services belong behind the feature boundary;
   this file only exposes the feature's public presentation entry points.

8. TECHNOLOGIES USED
   Dart exports only.

9. REQUIRED DATA MODELS
   FeedbackFeatureModel and FeedbackFeatureEntity.

10. FUTURE API ENDPOINTS
    No endpoint is implemented or assumed by this barrel file.

11. DATABASE COLLECTIONS/TABLES
    None implemented.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons are used by the presentation layer.

14. THEME COLORS
    Uses the application's Material 3 theme.

15. ANIMATIONS
    Implemented by presentation widgets.

16. ACCESSIBILITY
    Exposed widgets provide semantic labels where appropriate.

17. EDGE CASES
    None directly handled here.

18. VALIDATION RULES
    Implemented by the feedback controller and presentation layer.

19. ERROR HANDLING
    Implemented by the presentation state layer.

20. LOADING STATE
    Implemented by feedback states.

21. EMPTY STATE
    Implemented by the page where relevant.

22. OFFLINE BEHAVIOUR
    Represented locally only; no connectivity service is implemented.

23. SECURITY CONSIDERATIONS
    No user data is transmitted or persisted.

24. PERFORMANCE OPTIMIZATIONS
    Barrel exports avoid duplicated import declarations across consumers.

25. WIDGET TREE OVERVIEW
    Application → FeedbackPage → Feedback widgets.

26. COMPLETE TESTING CHECKLIST
    Validate imports, public exports, compilation, and analyzer cleanliness.
*/

export 'data/models/feedback_feature_model.dart';
export 'domain/entities/feedback_feature_entity.dart';
export 'presentation/controllers/feedback_controller.dart';
export 'presentation/pages/feedback_page.dart';
export 'presentation/widgets/feedback_category_selector.dart';
export 'presentation/widgets/feedback_header.dart';
export 'presentation/widgets/feedback_message_field.dart';
export 'presentation/widgets/feedback_rating_card.dart';
export 'presentation/widgets/feedback_states.dart';
