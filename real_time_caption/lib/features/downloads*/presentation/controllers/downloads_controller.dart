/*
1. PAGE NAME
   Downloads Controller

2. PURPOSE
   Provides local UI state for the Downloads page.

3. DESCRIPTION
   Uses ChangeNotifier only for local presentation state. It does not connect
   to networking, persistence, downloads, or backend services.

4. UI SECTIONS
   Search, filters, list state, and dummy loading/error states.

5. NAVIGATION FLOW
   Downloads page ↔ controller.

6. DYNAMIC COMPONENTS
   Search query, selected filter, loading/error flags, and visible items.

7. FUTURE BACKEND INTEGRATION
   Future: connect resource availability and download operations to the
   project's intended offline/local storage services at the controller
   integration boundary.

8. TECHNOLOGIES USED
   Flutter ChangeNotifier and Dart collections.

9. REQUIRED DATA MODELS
   DownloadsFeatureModel.

10. FUTURE API ENDPOINTS
    Not specified by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified for Downloads.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    State is exposed to accessible presentation widgets.

17. EDGE CASES
    Empty search results and no downloads.

18. VALIDATION RULES
    Search is normalized and matched locally.

19. ERROR HANDLING
    Local error flag can be used by the page.

20. LOADING STATE
    Local loading flag is available.

21. EMPTY STATE
    visibleDownloads can become empty.

22. OFFLINE BEHAVIOUR
    offlineMode is local dummy UI state.

23. SECURITY CONSIDERATIONS
    No sensitive information is handled.

24. PERFORMANCE OPTIMIZATIONS
    Filtering occurs over a small local immutable source list.

25. WIDGET TREE OVERVIEW
    Page → Controller → filtered downloads.

26. COMPLETE TESTING CHECKLIST
    Search, filters, loading/error toggles, and empty results.
*/

import 'package:flutter/foundation.dart';

import '../../data/data_sources/mock_downloads_data_source.dart';
import '../../data/models/downloads_feature_model.dart';

enum DownloadsFilter { all, completed, inProgress, failed }

class DownloadsController extends ChangeNotifier {
  DownloadsController({MockDownloadsDataSource? dataSource})
    : _dataSource = dataSource ?? const MockDownloadsDataSource() {
    _downloads = _dataSource.getDownloads();
  }

  final MockDownloadsDataSource _dataSource;

  List<DownloadsFeatureModel> _downloads = <DownloadsFeatureModel>[];
  String _query = '';
  DownloadsFilter _filter = DownloadsFilter.all;
  bool _isLoading = false;
  bool _hasError = false;
  bool _isOffline = false;

  List<DownloadsFeatureModel> get visibleDownloads {
    final String normalizedQuery = _query.trim().toLowerCase();

    return _downloads
        .where((DownloadsFeatureModel item) {
          final bool matchesQuery =
              normalizedQuery.isEmpty ||
              item.title.toLowerCase().contains(normalizedQuery) ||
              item.sourceLanguage.toLowerCase().contains(normalizedQuery) ||
              item.targetLanguage.toLowerCase().contains(normalizedQuery);

          final bool matchesFilter = switch (_filter) {
            DownloadsFilter.all => true,
            DownloadsFilter.completed =>
              item.status == DownloadItemStatus.completed,
            DownloadsFilter.inProgress =>
              item.status == DownloadItemStatus.downloading ||
                  item.status == DownloadItemStatus.paused,
            DownloadsFilter.failed => item.status == DownloadItemStatus.failed,
          };

          return matchesQuery && matchesFilter;
        })
        .toList(growable: false);
  }

  DownloadsFilter get filter => _filter;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  bool get isOffline => _isOffline;

  int get completedCount => _downloads
      .where((item) => item.status == DownloadItemStatus.completed)
      .length;

  int get totalCount => _downloads.length;

  void setQuery(String value) {
    _query = value;
    notifyListeners();
  }

  void setFilter(DownloadsFilter value) {
    _filter = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setError(bool value) {
    _hasError = value;
    notifyListeners();
  }

  void setOffline(bool value) {
    _isOffline = value;
    notifyListeners();
  }

  void retry() {
    _hasError = false;
    _isLoading = false;
    _downloads = _dataSource.getDownloads();
    notifyListeners();
  }
}
