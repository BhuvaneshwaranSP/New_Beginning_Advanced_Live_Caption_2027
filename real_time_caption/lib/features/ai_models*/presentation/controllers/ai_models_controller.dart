/*
1. PAGE NAME
   AI Models Controller

2. PURPOSE
   Manages lightweight local presentation state for the AI Models screen.

3. DESCRIPTION
   Uses Flutter's built-in ChangeNotifier only. No external state-management
   package is used.

4. UI SECTIONS
   Search, category filtering, model selection, loading, success, and error.

5. NAVIGATION FLOW
   Page → controller → local mock source → filtered model presentation.

6. DYNAMIC COMPONENTS
   Search query, selected category, selected model, loading/error state.

7. FUTURE BACKEND INTEGRATION
   Future model catalog retrieval belongs inside the loadModels boundary;
   model selection can later connect to the project's model configuration
   mechanism.

8. TECHNOLOGIES USED
   Flutter ChangeNotifier.

9. REQUIRED DATA MODELS
   AiModelEntity.

10. FUTURE API ENDPOINTS
   Not defined.

11. DATABASE COLLECTIONS/TABLES
   Not defined.

12. REQUIRED ASSETS
   None.

13. REQUIRED ICONS
   None.

14. THEME COLORS
   None.

15. ANIMATIONS
   UI widgets perform lightweight implicit animations.

16. ACCESSIBILITY
   State is exposed to semantic UI widgets.

17. EDGE CASES
   Empty search results, error state, no category selection, and selection
   changes are supported.

18. VALIDATION RULES
   Search is normalized locally and does not require validation.

19. ERROR HANDLING
   Local source exceptions are converted into presentation error state.

20. LOADING STATE
   Loading is represented locally before catalog exposure.

21. EMPTY STATE
   Empty search results are represented separately from loading/error.

22. OFFLINE BEHAVIOUR
   Local dummy catalog remains available independently of connectivity.

23. SECURITY CONSIDERATIONS
   No sensitive information is handled.

24. PERFORMANCE OPTIMIZATIONS
   Filtering occurs only when the controller state changes.

25. WIDGET TREE OVERVIEW
   Controller → AiModelsPage → filter/search/model cards.

26. COMPLETE TESTING CHECKLIST
   Verify loading, error, retry, search, filtering, selection, and disposal.
*/

import 'package:flutter/foundation.dart';

import '../../data/data_sources/mock_ai_models_data_source.dart';
import '../../domain/entities/ai_model_entity.dart';

class AiModelsController extends ChangeNotifier {
  AiModelsController({MockAiModelsDataSource? dataSource})
    : _dataSource = dataSource ?? const MockAiModelsDataSource();

  final MockAiModelsDataSource _dataSource;

  List<AiModelEntity> _models = const [];
  String _searchQuery = '';
  AiModelCategory? _selectedCategory;
  String? _selectedModelId;
  bool _isLoading = true;
  String? _errorMessage;

  List<AiModelEntity> get models => List.unmodifiable(_models);
  String get searchQuery => _searchQuery;
  AiModelCategory? get selectedCategory => _selectedCategory;
  String? get selectedModelId => _selectedModelId;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  List<AiModelEntity> get filteredModels {
    final query = _searchQuery.trim().toLowerCase();

    return _models
        .where((model) {
          final matchesCategory =
              _selectedCategory == null || model.category == _selectedCategory;

          if (query.isEmpty) {
            return matchesCategory;
          }

          final searchableText = [
            model.name,
            model.family,
            model.description,
            model.primaryUse,
            ...model.languages,
          ].join(' ').toLowerCase();

          return matchesCategory && searchableText.contains(query);
        })
        .toList(growable: false);
  }

  Future<void> loadModels({bool simulateError = false}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await Future<void>.delayed(const Duration(milliseconds: 450));

    try {
      // Future: connect the project model catalog here so supported AI
      // configurations can be loaded dynamically instead of local dummy data.
      _models = _dataSource
          .getModels(simulateError: simulateError)
          .map((model) => model.toEntity())
          .toList(growable: false);
    } catch (error) {
      _models = const [];
      _errorMessage = error.toString().replaceFirst('Bad state: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateSearch(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  void selectCategory(AiModelCategory? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void selectModel(String modelId) {
    _selectedModelId = modelId;
    notifyListeners();

    // Future: connect model selection to the project's AI inference
    // configuration so the chosen pipeline component becomes active.
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedCategory = null;
    notifyListeners();
  }
}
