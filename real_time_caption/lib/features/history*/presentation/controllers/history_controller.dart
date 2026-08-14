/*
1. PAGE NAME
   History Controller

2. PURPOSE
   Manages local presentation state for the History screen.

3. DESCRIPTION
   Handles search, filtering, sorting, loading, retry representation,
   and offline presentation using Flutter's built-in ChangeNotifier only.

4. UI SECTIONS
   Search, filter controls, sort menu, history list, and state banners.

5. NAVIGATION FLOW
   HistoryPage ↔ HistoryController.

6. DYNAMIC COMPONENTS
   Search query, selected type, sort order, loading state, offline state,
   and visible history records.

7. FUTURE BACKEND INTEGRATION
   Persisted history retrieval will be connected at loadHistory(), where
   the local mock source currently supplies records for UI development.

8. TECHNOLOGIES USED
   Dart and Flutter foundation.

9. REQUIRED DATA MODELS
   HistoryFeatureModel and HistoryFeatureEntity.

10. FUTURE API ENDPOINTS
    No endpoint is implemented.

11. DATABASE COLLECTIONS/TABLES
    No database is implemented.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    State changes are consumed by lightweight presentation animations.

16. ACCESSIBILITY
    State changes notify the page without relying on color.

17. EDGE CASES
    No search matches, empty history, and offline state.

18. VALIDATION RULES
    Search is normalized and safely handles empty input.

19. ERROR HANDLING
    A local error flag is exposed for presentation testing.

20. LOADING STATE
    The initial state simulates loading.

21. EMPTY STATE
    Filtered results can become empty.

22. OFFLINE BEHAVIOUR
    Offline state is represented without network detection.

23. SECURITY CONSIDERATIONS
    No persistence or external communication occurs.

24. PERFORMANCE OPTIMIZATIONS
    Filtering is performed only when controller state changes.

25. WIDGET TREE OVERVIEW
    HistoryPage → controller state → HistorySessionCard list.

26. COMPLETE TESTING CHECKLIST
    Verify every setter causes only the expected state update and that
    search/filter/sort combinations remain stable.
*/

import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../data/data_sources/mock_history_data_source.dart';
import '../../domain/entities/history_feature_entity.dart';

enum HistoryFilter { all, liveSpeech, calls, conversations }

enum HistorySort { newest, oldest }

class HistoryController extends ChangeNotifier {
  HistoryController({MockHistoryDataSource? dataSource})
    : _dataSource = dataSource ?? const MockHistoryDataSource() {
    unawaited(loadHistory());
  }

  final MockHistoryDataSource _dataSource;

  List<HistoryFeatureEntity> _allHistory = const [];
  String _searchQuery = '';
  HistoryFilter _filter = HistoryFilter.all;
  HistorySort _sort = HistorySort.newest;
  bool _isLoading = true;
  bool _hasError = false;
  bool _isOffline = false;

  List<HistoryFeatureEntity> get visibleHistory {
    final normalizedQuery = _searchQuery.trim().toLowerCase();

    final filtered = _allHistory
        .where((session) {
          final matchesFilter = switch (_filter) {
            HistoryFilter.all => true,
            HistoryFilter.liveSpeech =>
              session.type == HistorySessionType.liveSpeech,
            HistoryFilter.calls => session.type == HistorySessionType.call,
            HistoryFilter.conversations =>
              session.type == HistorySessionType.conversation,
          };

          if (!matchesFilter) {
            return false;
          }

          if (normalizedQuery.isEmpty) {
            return true;
          }

          return session.title.toLowerCase().contains(normalizedQuery) ||
              session.sourceLanguage.toLowerCase().contains(normalizedQuery) ||
              session.targetLanguage.toLowerCase().contains(normalizedQuery) ||
              session.preview.toLowerCase().contains(normalizedQuery);
        })
        .toList(growable: false);

    final sorted = List<HistoryFeatureEntity>.of(filtered);

    if (_sort == HistorySort.oldest) {
      sorted.sort((a, b) => a.id.compareTo(b.id));
    } else {
      sorted.sort((a, b) => b.id.compareTo(a.id));
    }

    return sorted;
  }

  String get searchQuery => _searchQuery;
  HistoryFilter get filter => _filter;
  HistorySort get sort => _sort;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  bool get isOffline => _isOffline;
  int get totalSessions => _allHistory.length;

  Future<void> loadHistory() async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    await Future<void>.delayed(const Duration(milliseconds: 450));

    try {
      // Future: replace the mock source with the project's persisted session-history repository here; history belongs here because this controller owns presentation loading state.
      _allHistory = _dataSource
          .loadHistory()
          .map((model) => model.toEntity())
          .toList(growable: false);

      _isOffline = false;
      _hasError = false;
    } catch (_) {
      _allHistory = const [];
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSearchQuery(String value) {
    if (_searchQuery == value) {
      return;
    }

    _searchQuery = value;
    notifyListeners();
  }

  void setFilter(HistoryFilter value) {
    if (_filter == value) {
      return;
    }

    _filter = value;
    notifyListeners();
  }

  void setSort(HistorySort value) {
    if (_sort == value) {
      return;
    }

    _sort = value;
    notifyListeners();
  }

  void clearSearch() {
    if (_searchQuery.isEmpty) {
      return;
    }

    _searchQuery = '';
    notifyListeners();
  }

  void setOfflinePreview(bool value) {
    if (_isOffline == value) {
      return;
    }

    _isOffline = value;
    notifyListeners();
  }

  void simulateError() {
    _hasError = true;
    _isLoading = false;
    notifyListeners();
  }
}
