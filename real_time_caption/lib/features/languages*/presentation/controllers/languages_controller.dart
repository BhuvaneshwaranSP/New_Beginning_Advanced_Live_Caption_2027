/*
1. PAGE NAME
   Languages Controller

2. PURPOSE
   Owns local UI state for the Languages screen.

3. DESCRIPTION
   Handles local search, language-pair selection, swapping, and section
   filtering without any state-management package or backend service.

4. UI SECTIONS
   Search, source/target pair, preferred, recent, and supported languages.

5. NAVIGATION FLOW
   LanguagesPage → controller → local selection state.

6. DYNAMIC COMPONENTS
   Search results, selected language pair, and selected language tiles.

7. FUTURE BACKEND INTEGRATION
   Future: persist user language preferences at selection points after the
   production language-preference service is available.

8. TECHNOLOGIES USED
   Flutter foundation ChangeNotifier.

9. REQUIRED DATA MODELS
   LanguageFeatureEntity.

10. FUTURE API ENDPOINTS
    Not implemented.

11. DATABASE COLLECTIONS/TABLES
    Not implemented.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    Selection animation belongs to presentation widgets.

16. ACCESSIBILITY
    State changes are reflected through selected semantics in the UI.

17. EDGE CASES
    Missing source/target language, empty search, and unavailable language.

18. VALIDATION RULES
    Source and target should not intentionally resolve to the same language.

19. ERROR HANDLING
    Invalid selection is ignored locally.

20. LOADING STATE
    Initial loading is represented by a local boolean.

21. EMPTY STATE
    Search result can become empty.

22. OFFLINE BEHAVIOUR
    No network state is implemented; unavailable language status is local.

23. SECURITY CONSIDERATIONS
    No sensitive state.

24. PERFORMANCE OPTIMIZATIONS
    Filtering occurs only when search text changes.

25. WIDGET TREE OVERVIEW
    Page → controller-backed sections and pair card.

26. COMPLETE TESTING CHECKLIST
    Search, selection, swap, notification, disposal, and empty-result behavior.
*/

import 'package:flutter/foundation.dart';

import '../../data/data_sources/mock_languages_data_source.dart';
import '../../domain/entities/languages_feature_entity.dart';

class LanguagesController extends ChangeNotifier {
  LanguagesController({
    MockLanguagesDataSource dataSource = const MockLanguagesDataSource(),
  }) : _dataSource = dataSource {
    _loadLanguages();
  }

  final MockLanguagesDataSource _dataSource;

  List<LanguageFeatureEntity> _languages = const [];
  String _searchQuery = '';
  String _sourceLanguageId = 'ta';
  String _targetLanguageId = 'en';
  bool _isLoading = true;
  bool _isOfflinePreview = false;

  List<LanguageFeatureEntity> get languages => _languages;

  String get searchQuery => _searchQuery;

  String get sourceLanguageId => _sourceLanguageId;

  String get targetLanguageId => _targetLanguageId;

  bool get isLoading => _isLoading;

  bool get isOfflinePreview => _isOfflinePreview;

  LanguageFeatureEntity? get sourceLanguage => _findById(_sourceLanguageId);

  LanguageFeatureEntity? get targetLanguage => _findById(_targetLanguageId);

  List<LanguageFeatureEntity> get preferredLanguages =>
      _filtered(_languages.where((language) => language.isPreferred));

  List<LanguageFeatureEntity> get recentLanguages =>
      _filtered(_languages.where((language) => language.isRecent));

  List<LanguageFeatureEntity> get supportedLanguages => _filtered(_languages);

  List<LanguageFeatureEntity> get myLanguages => _filtered(
    _languages.where((language) => language.isPreferred || language.isRecent),
  );

  void _loadLanguages() {
    _isLoading = true;
    notifyListeners();

    _languages = _dataSource
        .getLanguages()
        .map((model) => model.toEntity())
        .toList(growable: false);

    _isLoading = false;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query.trim();
    notifyListeners();
  }

  void selectSourceLanguage(String languageId) {
    if (_findById(languageId) == null || languageId == _targetLanguageId) {
      return;
    }

    _sourceLanguageId = languageId;

    // Future: persist the selected source language through the language
    // preference service because this choice is shared across communication
    // experiences in LinguaLive.

    notifyListeners();
  }

  void selectTargetLanguage(String languageId) {
    if (_findById(languageId) == null || languageId == _sourceLanguageId) {
      return;
    }

    _targetLanguageId = languageId;

    // Future: persist the selected target language through the language
    // preference service because the source/target pair is a central
    // LinguaLive communication setting.

    notifyListeners();
  }

  void swapLanguages() {
    final currentSource = _sourceLanguageId;
    _sourceLanguageId = _targetLanguageId;
    _targetLanguageId = currentSource;

    // Future: synchronize the swapped pair with the shared language
    // configuration so translation and transcription screens use the same
    // source/target selection.

    notifyListeners();
  }

  void toggleOfflinePreview() {
    _isOfflinePreview = !_isOfflinePreview;
    notifyListeners();
  }

  List<LanguageFeatureEntity> _filtered(
    Iterable<LanguageFeatureEntity> source,
  ) {
    final query = _searchQuery.toLowerCase();

    if (query.isEmpty) {
      return source.toList(growable: false);
    }

    return source
        .where(
          (language) =>
              language.name.toLowerCase().contains(query) ||
              language.nativeName.toLowerCase().contains(query) ||
              language.code.toLowerCase().contains(query),
        )
        .toList(growable: false);
  }

  LanguageFeatureEntity? _findById(String id) {
    for (final language in _languages) {
      if (language.id == id) {
        return language;
      }
    }

    return null;
  }
}
