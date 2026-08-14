/*
1. PAGE NAME
   Notifications Dummy Data

2. PURPOSE
   Supplies realistic local notification records for UI development.

3. DESCRIPTION
   Contains immutable multilingual notification examples covering sessions,
   translations, calls, chat, and system/offline-related information.

4. UI SECTIONS
   Supports the notification list and category filters.

5. NAVIGATION FLOW
   MockNotificationsDataSource → controller → NotificationsPage.

6. DYNAMIC COMPONENTS
   Notification title, message, time, type, status, and language pair.

7. FUTURE BACKEND INTEGRATION
   Replace this local source with the project's supported notification data
   source when backend integration is implemented.

8. TECHNOLOGIES USED
   Dart and Flutter Material Icons.

9. REQUIRED DATA MODELS
   NotificationFeatureModel.

10. FUTURE API ENDPOINTS
    None defined.

11. DATABASE COLLECTIONS/TABLES
    None defined.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Data is presented through accessible notification widgets.

17. EDGE CASES
    Multiple languages, different notification types, unread/read records,
    and varying message lengths.

18. VALIDATION RULES
    Dummy records contain non-empty identifiers and display content.

19. ERROR HANDLING
    Not applicable to static dummy records.

20. LOADING STATE
    Handled by the controller.

21. EMPTY STATE
    The collection can be empty during state testing.

22. OFFLINE BEHAVIOUR
    Includes a local language-pack notification representing offline usage.

23. SECURITY CONSIDERATIONS
    All records are fictional UI data.

24. PERFORMANCE OPTIMIZATIONS
    Const list and const model objects.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Rendering, multilingual text, unread/read state, category filtering,
    long text, and empty collection behaviour.
*/

import 'package:flutter/material.dart';

import '../models/notifications_feature_model.dart';

const List<NotificationFeatureModel> notificationsDummyData = [
  NotificationFeatureModel(
    id: 'notification_001',
    title: 'Live session ready',
    message: 'Your English → Tamil live session is ready to continue.',
    timeLabel: '2 min ago',
    kind: NotificationKind.session,
    status: NotificationStatus.unread,
    icon: Icons.translate_rounded,
    sourceLanguage: 'English',
    targetLanguage: 'Tamil',
  ),
  NotificationFeatureModel(
    id: 'notification_002',
    title: 'New translated message',
    message: 'Arun sent a new Telugu → English translated message.',
    timeLabel: '18 min ago',
    kind: NotificationKind.chat,
    status: NotificationStatus.unread,
    icon: Icons.chat_bubble_outline_rounded,
    sourceLanguage: 'Telugu',
    targetLanguage: 'English',
  ),
  NotificationFeatureModel(
    id: 'notification_003',
    title: 'Call captions available',
    message: 'Your Malayalam call captions are available in session history.',
    timeLabel: '1 hr ago',
    kind: NotificationKind.call,
    status: NotificationStatus.read,
    icon: Icons.call_outlined,
    sourceLanguage: 'Malayalam',
    targetLanguage: 'English',
  ),
  NotificationFeatureModel(
    id: 'notification_004',
    title: 'Translation completed',
    message: 'Your Hindi → Tamil translation has finished successfully.',
    timeLabel: '3 hrs ago',
    kind: NotificationKind.translation,
    status: NotificationStatus.read,
    icon: Icons.check_circle_outline_rounded,
    sourceLanguage: 'Hindi',
    targetLanguage: 'Tamil',
  ),
  NotificationFeatureModel(
    id: 'notification_005',
    title: 'Offline language pack',
    message:
        'The Tamil language pack is available for offline translation use.',
    timeLabel: 'Yesterday',
    kind: NotificationKind.system,
    status: NotificationStatus.read,
    icon: Icons.download_outlined,
    sourceLanguage: 'Tamil',
    targetLanguage: 'Tamil',
  ),
];
