/*
1. PAGE NAME
   Mock Notifications Data Source

2. PURPOSE
   Provides local notification data for UI-only development.

3. DESCRIPTION
   Acts as the current data boundary for the Notifications feature without
   implementing networking, APIs, Firebase, persistence, or a database.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Mock data source → NotificationsController → NotificationsPage.

6. DYNAMIC COMPONENTS
   Notification collection.

7. FUTURE BACKEND INTEGRATION
   Replace the local implementation at this boundary with the project's
   notification data provider when real notification infrastructure exists.

8. TECHNOLOGIES USED
   Dart.

9. REQUIRED DATA MODELS
   NotificationFeatureModel.

10. FUTURE API ENDPOINTS
    None defined.

11. DATABASE COLLECTIONS/TABLES
    None defined.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Not applicable to this non-UI layer.

17. EDGE CASES
    Empty collection and repeated loading.

18. VALIDATION RULES
    Returns model instances supplied by dummy data.

19. ERROR HANDLING
    Controller owns presentation-level error representation.

20. LOADING STATE
    Controller-owned.

21. EMPTY STATE
    Determined from returned collection.

22. OFFLINE BEHAVIOUR
    Local dummy data remains available without networking.

23. SECURITY CONSIDERATIONS
    No sensitive data.

24. PERFORMANCE OPTIMIZATIONS
    Returns a shallow copy so presentation state cannot mutate the source
    constant collection.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Data loading, returned collection contents, immutability expectations,
    repeated calls, and empty-data handling.
*/

import '../dummy/notifications_dummy_data.dart';
import '../models/notifications_feature_model.dart';

class MockNotificationsDataSource {
  const MockNotificationsDataSource();

  List<NotificationFeatureModel> loadNotifications() {
    return List<NotificationFeatureModel>.from(notificationsDummyData);
  }
}
