/*
1. PAGE NAME
   Notifications Feature Domain Entities

2. PURPOSE
   Defines immutable domain-level objects used by the LinguaLive Notifications
   feature.

3. DESCRIPTION
   Contains pure Dart entities without Flutter, UI, or infrastructure
   dependencies.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Notifications data/model mapping → domain entities → presentation.

6. DYNAMIC COMPONENTS
   Notification identity, content, category, read status, time, and language pair.

7. FUTURE BACKEND INTEGRATION
   Data models can later be mapped into these domain entities without coupling
   the domain layer to the backend implementation.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   NotificationsFeatureEntity and NotificationCategory.

10. FUTURE API ENDPOINTS
    None defined at this UI stage.

11. DATABASE COLLECTIONS/TABLES
    None defined at this UI stage.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None; icon rendering remains outside the domain layer.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Handled by presentation widgets.

17. EDGE CASES
    Long notification content, empty filtered categories, and read/unread
    notification states.

18. VALIDATION RULES
    Required identifiers and display strings should be meaningful.

19. ERROR HANDLING
    Handled by data and presentation layers.

20. LOADING STATE
    Handled by presentation.

21. EMPTY STATE
    Handled by presentation.

22. OFFLINE BEHAVIOUR
    Represented by presentation/controller state rather than domain UI code.

23. SECURITY CONSIDERATIONS
    No credentials or sensitive information are stored here.

24. PERFORMANCE OPTIMIZATIONS
    Immutable const-compatible entities.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Entity construction, enum values, multilingual content, read/unread state,
    category mapping, and const compatibility.
*/

enum NotificationCategory { all, unread, sessions, calls, messages, system }

class NotificationsFeatureEntity {
  const NotificationsFeatureEntity({
    required this.id,
    required this.title,
    required this.message,
    required this.timeLabel,
    required this.category,
    required this.isUnread,
    required this.sourceLanguage,
    required this.targetLanguage,
  });

  final String id;
  final String title;
  final String message;
  final String timeLabel;
  final NotificationCategory category;
  final bool isUnread;
  final String sourceLanguage;
  final String targetLanguage;
}
