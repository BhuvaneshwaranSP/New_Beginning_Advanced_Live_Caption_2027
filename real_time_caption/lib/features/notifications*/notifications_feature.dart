/*
1. PAGE NAME
   Notifications Feature

2. PURPOSE
   Provides the public entry points for the LinguaLive Notifications feature.

3. DESCRIPTION
   Re-exports the notifications data, domain, controller, page, and widget
   components so the feature can be integrated without exposing internal
   folder details.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Application navigation → NotificationsPage.

6. DYNAMIC COMPONENTS
   Notification models, entities, controller state, notification tiles,
   category filters, and notification states.

7. FUTURE BACKEND INTEGRATION
   Backend integration belongs behind the data-source/repository boundary.

8. TECHNOLOGIES USED
   Dart and Flutter.

9. REQUIRED DATA MODELS
   NotificationFeatureModel.

10. FUTURE API ENDPOINTS
    None defined at this UI-only stage.

11. DATABASE COLLECTIONS/TABLES
    None defined at this UI-only stage.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons used by presentation/data models.

14. THEME COLORS
    Uses the application's Material 3 ColorScheme.

15. ANIMATIONS
    None required at feature export level.

16. ACCESSIBILITY
    Implemented by presentation widgets.

17. EDGE CASES
    Empty notifications, unread filtering, long multilingual content,
    loading, error, and offline presentation.

18. VALIDATION RULES
    Models require meaningful notification fields.

19. ERROR HANDLING
    Handled by the controller and presentation state widgets.

20. LOADING STATE
    Handled by presentation.

21. EMPTY STATE
    Handled by presentation.

22. OFFLINE BEHAVIOUR
    Represented locally by the notifications controller.

23. SECURITY CONSIDERATIONS
    No credentials, persistence, networking, or sensitive storage.

24. PERFORMANCE OPTIMIZATIONS
    Small immutable dummy data and focused feature exports.

25. WIDGET TREE OVERVIEW
    NotificationsPage
      → NotificationsHeader
      → category filters
      → notification states/list
      → NotificationTile.

26. COMPLETE TESTING CHECKLIST
    Export availability, import correctness, analyzer checks, feature
    integration, navigation integration, and absence of circular imports.
*/

export 'data/data_sources/mock_notifications_data_source.dart';
export 'data/dummy/notifications_dummy_data.dart';
export 'data/models/notifications_feature_model.dart';
export 'domain/entities/notifications_feature_entity.dart';
export 'presentation/controllers/notifications_controller.dart';
export 'presentation/pages/notifications_page.dart';
export 'presentation/widgets/notification_tile.dart';
export 'presentation/widgets/notifications_header.dart';
export 'presentation/widgets/notifications_states.dart';
