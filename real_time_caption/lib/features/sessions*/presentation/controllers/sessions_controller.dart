import 'package:flutter/foundation.dart';

import '../../data/data_sources/mock_sessions_data_source.dart';
import '../../domain/entities/session_entity.dart';

enum SessionFilter {
  all,
  live,
  scheduled,
  completed,
  offline,
}

class SessionsController extends ChangeNotifier {
  SessionsController({
    MockSessionsDataSource? dataSource,
  }) : _dataSource = dataSource ?? const MockSessionsDataSource() {
    _sessions = _dataSource.loadSessions();
  }

  final MockSessionsDataSource _dataSource;

  List<SessionEntity> _sessions = <SessionEntity>[];
  SessionFilter _filter = SessionFilter.all;
  String _query = '';
  bool _isLoading = false;
  bool _isOfflinePreview = false;

  List<SessionEntity> get sessions => List<SessionEntity>.unmodifiable(_sessions);

  SessionFilter get filter => _filter;

  String get query => _query;

  bool get isLoading => _isLoading;

  bool get isOfflinePreview => _isOfflinePreview;

  List<SessionEntity> get filteredSessions {
    final String normalizedQuery = _query.trim().toLowerCase();

    return _sessions.where((SessionEntity session) {
      final bool matchesFilter = switch (_filter) {
        SessionFilter.all => true,
        SessionFilter.live => session.status == SessionStatus.live,
        SessionFilter.scheduled =>
          session.status == SessionStatus.scheduled,
        SessionFilter.completed =>
          session.status == SessionStatus.completed,
        SessionFilter.offline => session.status == SessionStatus.offline,
      };

      if (!matchesFilter) {
        return false;
      }

      if (normalizedQuery.isEmpty) {
        return true;
      }

      return session.title.toLowerCase().contains(normalizedQuery) ||
          session.languagePair.toLowerCase().contains(normalizedQuery) ||
          session.typeLabel.toLowerCase().contains(normalizedQuery) ||
          session.participants.any(
            (String participant) =>
                participant.toLowerCase().contains(normalizedQuery),
          );
    }).toList(growable: false);
  }

  int get liveCount =>
      _sessions.where((SessionEntity item) => item.status == SessionStatus.live).length;

  int get scheduledCount => _sessions
      .where((SessionEntity item) => item.status == SessionStatus.scheduled)
      .length;

  int get completedCount => _sessions
      .where((SessionEntity item) => item.status == SessionStatus.completed)
      .length;

  void setFilter(SessionFilter filter) {
    if (_filter == filter) {
      return;
    }

    _filter = filter;
    notifyListeners();
  }

  void setQuery(String value) {
    if (_query == value) {
      return;
    }

    _query = value;
    notifyListeners();
  }

  Future<void> refresh() async {
    _isLoading = true;
    notifyListeners();

    await Future<void>.delayed(const Duration(milliseconds: 650));

    _sessions = _dataSource.loadSessions();
    _isLoading = false;
    notifyListeners();
  }

  void toggleOfflinePreview() {
    _isOfflinePreview = !_isOfflinePreview;
    notifyListeners();
  }
}