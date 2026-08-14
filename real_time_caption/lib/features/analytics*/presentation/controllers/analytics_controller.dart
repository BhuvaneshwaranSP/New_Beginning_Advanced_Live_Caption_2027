/*
1. PAGE NAME
   Analytics Controller

2. PURPOSE
   Controls local UI state for the Analytics page.

3. DESCRIPTION
   Uses only local Flutter state patterns and the mock data source.
   No state-management package or backend service is used.

4. UI SECTIONS
   Time-range selection and Analytics view states.

5. NAVIGATION FLOW
   AnalyticsPage → AnalyticsController.

6. DYNAMIC COMPONENTS
   Analytics data, selected time range, loading/error/offline states.

7. FUTURE BACKEND INTEGRATION
   The load method is the intended location for repository-backed
   analytics retrieval.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   AnalyticsFeatureEntity.

10. FUTURE API ENDPOINTS
    Not defined.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    Presentation widgets own animations.

16. ACCESSIBILITY
    Presentation widgets provide semantics.

17. EDGE CASES
    Loading, empty, error, and offline states.

18. VALIDATION RULES
    Selected range must be one of the supported local values.

19. ERROR HANDLING
    Local state captures data-load failures.

20. LOADING STATE
    AnalyticsViewState.loading.

21. EMPTY STATE
    AnalyticsViewState.empty.

22. OFFLINE BEHAVIOUR
    AnalyticsViewState.offline.

23. SECURITY CONSIDERATIONS
    No credentials or network access.

24. PERFORMANCE OPTIMIZATIONS
    Simple ChangeNotifier with minimal state.

25. WIDGET TREE OVERVIEW
    AnalyticsPage listens to this controller.

26. COMPLETE TESTING CHECKLIST
    Initial load, state changes, retry, range selection, disposal,
    and repeated notifications.
*/

import 'package:flutter/foundation.dart';

import '../../data/data_sources/mock_analytics_data_source.dart';
import '../../domain/entities/analytics_feature_entity.dart';

class AnalyticsController extends ChangeNotifier {
  AnalyticsController({MockAnalyticsDataSource? dataSource})
    : _dataSource = dataSource ?? const MockAnalyticsDataSource();

  final MockAnalyticsDataSource _dataSource;

  AnalyticsViewState _state = AnalyticsViewState.loading;
  AnalyticsFeatureEntity? _analytics;
  String _selectedRange = '7D';

  AnalyticsViewState get state => _state;
  AnalyticsFeatureEntity? get analytics => _analytics;
  String get selectedRange => _selectedRange;

  Future<void> load() async {
    _state = AnalyticsViewState.loading;
    notifyListeners();

    try {
      final model = await _dataSource.loadAnalytics();
      final entity = model.toEntity();

      if (entity.metrics.isEmpty &&
          entity.usagePoints.isEmpty &&
          entity.languages.isEmpty) {
        _analytics = entity;
        _state = AnalyticsViewState.empty;
      } else {
        _analytics = entity;
        _state = AnalyticsViewState.success;
      }
    } catch (_) {
      _state = AnalyticsViewState.error;
    }

    notifyListeners();
  }

  void selectRange(String range) {
    if (_selectedRange == range) {
      return;
    }

    _selectedRange = range;
    notifyListeners();

    // Future: request analytics for the selected period here when the
    // analytics repository supports time-range queries.
  }

  void showOfflineState() {
    _state = AnalyticsViewState.offline;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
