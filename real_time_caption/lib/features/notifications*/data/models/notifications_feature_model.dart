/*
1. PAGE NAME
   Notifications Feature Data Model

2. PURPOSE
   Defines data-layer models used by the Notifications feature.

3. DESCRIPTION
   Represents notification records as they would exist at the data boundary.
   The current implementation uses local dummy records only.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Data source → NotificationFeatureModel → controller/domain mapping.

6. DYNAMIC COMPONENTS
   Notification type, read status, language pair, title, message, and time.

7. FUTURE BACKEND INTEGRATION
   Backend notification responses can later be mapped into this model.

8. TECHNOLOGIES USED
   Dart and Flutter Material for IconData.

9. REQUIRED DATA MODELS
   NotificationFeatureModel.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    None specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material IconData is retained at the data/presentation boundary.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Accessibility is handled by presentation widgets.

17. EDGE CASES
    Long titles, long messages, zero-length language labels, and read/unread
    transitions.

18. VALIDATION RULES
    Required fields should contain meaningful values.

19. ERROR HANDLING
    Handled by the data source/controller.

20. LOADING STATE
    Not represented by the model.

21. EMPTY STATE
    Represented by an empty model collection.

22. OFFLINE BEHAVIOUR
    Dummy data can represent previously available local information.

23. SECURITY CONSIDERATIONS
    No credentials or sensitive data.

24. PERFORMANCE OPTIMIZATIONS
    Immutable const-compatible model.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Const construction, multilingual strings, enum values, icon values,
    read/unread states, and model field integrity.
*/

import 'package:flutter/material.dart';

enum NotificationKind { session, translation, call, chat, system }

enum NotificationStatus { unread, read }

class NotificationFeatureModel {
  const NotificationFeatureModel({
    required this.id,
    required this.title,
    required this.message,
    required this.timeLabel,
    required this.kind,
    required this.status,
    required this.icon,
    required this.sourceLanguage,
    required this.targetLanguage,
  });

  final String id;
  final String title;
  final String message;
  final String timeLabel;
  final NotificationKind kind;
  final NotificationStatus status;
  final IconData icon;
  final String sourceLanguage;
  final String targetLanguage;
}
