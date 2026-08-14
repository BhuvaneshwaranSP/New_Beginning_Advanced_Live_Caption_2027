/*
1. PAGE NAME
   Notifications Controller

2. PURPOSE
   Manages local UI state for the Notifications page.

3. DESCRIPTION
   Coordinates local dummy notification data, category filtering, unread state,
   and loading/error/offline/empty representations.

4. UI SECTIONS
   Controls the notification header, category selector, and notification body.

5. NAVIGATION FLOW
   NotificationsPage → NotificationsController → local data source.

6. DYNAMIC COMPONENTS
   Notification list, unread count, category filter, and screen states.

7. FUTURE BACKEND INTEGRATION
   Connect the project's notification data provider at the data-loading
   boundary. Notification actions can later connect to their originating
   session, call, or chat feature.

8. TECHNOLOGIES USED
   Dart and Flutter foundation ChangeNotifier.

9. REQUIRED DATA MODELS
   NotificationFeatureModel and NotificationsFeatureEntity.

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
    Presentation widgets expose accessible semantics.

17. EDGE CASES
    Zero notifications, zero notifications in a selected filter, unread count
    changes, retry, and offline/error presentation.

18. VALIDATION RULES
    Filters operate only against known notification categories.

19. ERROR HANDLING
    Provides local error state and retry callback.

20. LOADING STATE
    Provides a loading state before local data is displayed.

21. EMPTY STATE
    Provides empty state when the notification collection has no records.

22. OFFLINE BEHAVIOUR
    Provides a local offline representation only; no connectivity detection.

23. SECURITY CONSIDERATIONS
    No authentication, credentials, persistence, or network operations.

24. PERFORMANCE OPTIMIZATIONS
    Immutable visible lists and focused listener notifications.

25. WIDGET TREE OVERVIEW
    NotificationsPage → controller state → notification widgets.

26. COMPLETE TESTING CHECKLIST
    Loading, success, empty, error, offline, filter transitions, unread count,
    mark-all-read, retry, repeated load, and controller disposal.
*/

import 'package:flutter/foundation.dart';

import '../../data/data_sources/mock_notifications_data_source.dart';
import '../../data/models/notifications_feature_model.dart';
import '../../domain/entities/notifications_feature_entity.dart';

enum NotificationsViewState { loading, success, empty, error, offline }

class NotificationsController extends ChangeNotifier {
  NotificationsController({MockNotificationsDataSource? dataSource})
    : _dataSource = dataSource ?? const MockNotificationsDataSource();

  final MockNotificationsDataSource _dataSource;

  NotificationsViewState _state = NotificationsViewState.loading;
  NotificationCategory _category = NotificationCategory.all;

  List<NotificationFeatureModel> _items = const [];
  String? _errorMessage;

  NotificationsViewState get state => _state;

  NotificationCategory get category => _category;

  String? get errorMessage => _errorMessage;

  int get unreadCount {
    return _items
        .where((item) => item.status == NotificationStatus.unread)
        .length;
  }

  List<NotificationsFeatureEntity> get visibleItems {
    return _items
        .where(_matchesCategory)
        .map(_toEntity)
        .toList(growable: false);
  }

  void load() {
    _state = NotificationsViewState.loading;
    _errorMessage = null;
    notifyListeners();

    // Future: connect the project's notification data provider here so
    // notification records can be loaded from the supported application source.
    _items = _dataSource.loadNotifications();

    _state = _items.isEmpty
        ? NotificationsViewState.empty
        : NotificationsViewState.success;

    notifyListeners();
  }

  void setCategory(NotificationCategory category) {
    _category = category;
    notifyListeners();
  }

  void markAllAsRead() {
    _items = _items
        .map(
          (item) => NotificationFeatureModel(
            id: item.id,
            title: item.title,
            message: item.message,
            timeLabel: item.timeLabel,
            kind: item.kind,
            status: NotificationStatus.read,
            icon: item.icon,
            sourceLanguage: item.sourceLanguage,
            targetLanguage: item.targetLanguage,
          ),
        )
        .toList(growable: false);

    notifyListeners();
  }

  void retry() {
    load();
  }

  void showOfflineState() {
    _state = NotificationsViewState.offline;
    notifyListeners();
  }

  void showErrorState() {
    _errorMessage = 'Notifications could not be displayed.';
    _state = NotificationsViewState.error;
    notifyListeners();
  }

  bool _matchesCategory(NotificationFeatureModel item) {
    switch (_category) {
      case NotificationCategory.all:
        return true;
      case NotificationCategory.unread:
        return item.status == NotificationStatus.unread;
      case NotificationCategory.sessions:
        return item.kind == NotificationKind.session ||
            item.kind == NotificationKind.translation;
      case NotificationCategory.calls:
        return item.kind == NotificationKind.call;
      case NotificationCategory.messages:
        return item.kind == NotificationKind.chat;
      case NotificationCategory.system:
        return item.kind == NotificationKind.system;
    }
  }

  NotificationsFeatureEntity _toEntity(NotificationFeatureModel item) {
    return NotificationsFeatureEntity(
      id: item.id,
      title: item.title,
      message: item.message,
      timeLabel: item.timeLabel,
      category: _categoryFor(item.kind),
      isUnread: item.status == NotificationStatus.unread,
      sourceLanguage: item.sourceLanguage,
      targetLanguage: item.targetLanguage,
    );
  }

  NotificationCategory _categoryFor(NotificationKind kind) {
    switch (kind) {
      case NotificationKind.session:
      case NotificationKind.translation:
        return NotificationCategory.sessions;
      case NotificationKind.call:
        return NotificationCategory.calls;
      case NotificationKind.chat:
        return NotificationCategory.messages;
      case NotificationKind.system:
        return NotificationCategory.system;
    }
  }
}
