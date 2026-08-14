/*
1. PAGE NAME
   Help Center Controller

2. PURPOSE
   Manages local Help Center UI state.

3. DESCRIPTION
   Uses Flutter's built-in ChangeNotifier for local screen state only.

4. UI SECTIONS
   Search, FAQ expansion, and screen states.

5. NAVIGATION FLOW
   Help Center page → controller → filtered local content.

6. DYNAMIC COMPONENTS
   Search results and expanded FAQ.

7. FUTURE BACKEND INTEGRATION
   Future: connect the supported Help Center repository at this controller
   boundary when production content is available.

8. TECHNOLOGIES USED
   Flutter foundation.

9. REQUIRED DATA MODELS
   HelpCenterCategoryEntity
   HelpCenterArticleEntity

10. FUTURE API ENDPOINTS
    Not specified.

11. DATABASE COLLECTIONS/TABLES
    Not specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    Presentation layer.

16. ACCESSIBILITY
    Presentation layer.

17. EDGE CASES
    Empty query and no matching articles.

18. VALIDATION RULES
    Case-insensitive local search.

19. ERROR HANDLING
    Local error state.

20. LOADING STATE
    Local loading state.

21. EMPTY STATE
    Local filtered-empty state.

22. OFFLINE BEHAVIOUR
    Local content remains available.

23. SECURITY CONSIDERATIONS
    No sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Filtering occurs only when search changes.

25. WIDGET TREE OVERVIEW
    Page → Controller → Presentation.

26. COMPLETE TESTING CHECKLIST
    Verify search, expansion, retry, and state changes.
*/

import 'package:flutter/foundation.dart';

import '../../data/data_sources/mock_help_center_data_source.dart';
import '../../domain/entities/help_center_feature_entity.dart';

enum HelpCenterViewState { loading, success, error, offline }

class HelpCenterController extends ChangeNotifier {
  HelpCenterController({MockHelpCenterDataSource? dataSource})
    : _dataSource = dataSource ?? const MockHelpCenterDataSource() {
    _loadContent();
  }

  final MockHelpCenterDataSource _dataSource;

  HelpCenterViewState _state = HelpCenterViewState.loading;
  String _query = '';
  String? _expandedArticleId;

  List<HelpCenterCategoryEntity> _categories = const [];
  List<HelpCenterArticleEntity> _articles = const [];

  HelpCenterViewState get state => _state;

  String get query => _query;

  String? get expandedArticleId => _expandedArticleId;

  List<HelpCenterCategoryEntity> get categories => _categories;

  List<HelpCenterArticleEntity> get filteredArticles {
    final query = _query.trim().toLowerCase();

    if (query.isEmpty) {
      return _articles;
    }

    return _articles
        .where((article) {
          final searchableText = <String>[
            article.title,
            article.description,
            ...article.keywords,
          ].join(' ').toLowerCase();

          return searchableText.contains(query);
        })
        .toList(growable: false);
  }

  void _loadContent() {
    _categories = _dataSource
        .getCategories()
        .map((model) => model.toEntity())
        .toList(growable: false);

    _articles = _dataSource
        .getArticles()
        .map((model) => model.toEntity())
        .toList(growable: false);

    _state = HelpCenterViewState.success;
    notifyListeners();
  }

  void updateSearch(String value) {
    _query = value;
    _expandedArticleId = null;
    notifyListeners();
  }

  void clearSearch() {
    _query = '';
    _expandedArticleId = null;
    notifyListeners();
  }

  void toggleArticle(String articleId) {
    _expandedArticleId = _expandedArticleId == articleId ? null : articleId;
    notifyListeners();
  }

  void retry() {
    _state = HelpCenterViewState.loading;
    notifyListeners();

    _loadContent();
  }

  void showOfflineState() {
    _state = HelpCenterViewState.offline;
    notifyListeners();
  }

  void restoreContent() {
    _state = HelpCenterViewState.success;
    notifyListeners();
  }

  void showErrorState() {
    _state = HelpCenterViewState.error;
    notifyListeners();
  }
}
