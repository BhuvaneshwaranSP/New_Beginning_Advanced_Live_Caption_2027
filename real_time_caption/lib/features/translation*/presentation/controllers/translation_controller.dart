/*
1. PAGE NAME
   Translation Controller

2. PURPOSE
   Controls local UI state for the Translation page.

3. DESCRIPTION
   Uses Flutter's built-in ChangeNotifier only. It contains no external
   state-management package and no backend functionality.

4. UI SECTIONS
   Language pair, input, result, and status.

5. NAVIGATION FLOW
   TranslationPage → TranslationController → local dummy data source.

6. DYNAMIC COMPONENTS
   Selected languages, source text, result entity, processing state,
   and offline/error representations.

7. FUTURE BACKEND INTEGRATION
   Future: invoke the documented speech/translation pipeline at translate(),
   where the source text is currently resolved from local dummy data.

8. TECHNOLOGIES USED
   Flutter foundation and Dart.

9. REQUIRED DATA MODELS
   TranslationEntity and TranslationModel.

10. FUTURE API ENDPOINTS
    Not specified by source documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified by source documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    Processing/result transitions are handled by presentation widgets.

16. ACCESSIBILITY
    State changes trigger normal Flutter rebuilds and semantic labels in widgets.

17. EDGE CASES
    Same source/target language, empty input, unknown translation, and offline state.

18. VALIDATION RULES
    Empty input is rejected locally.

19. ERROR HANDLING
    Local dummy error state.

20. LOADING STATE
    A short local processing representation is used.

21. EMPTY STATE
    Initial controller state.

22. OFFLINE BEHAVIOUR
    setOffline() provides a local UI representation only.

23. SECURITY CONSIDERATIONS
    No persistence, networking, credentials, or raw audio handling.

24. PERFORMANCE OPTIMIZATIONS
    ChangeNotifier exposes only the feature's local UI state.

25. WIDGET TREE OVERVIEW
    TranslationPage listens to TranslationController.

26. COMPLETE TESTING CHECKLIST
    Verify notifyListeners, language swap, clear, translate, error, and offline states.
*/

import 'package:flutter/foundation.dart';

import '../../data/data_sources/mock_translation_data_source.dart';
import '../../data/dummy/translation_dummy_data.dart';
import '../../domain/entities/translation_entity.dart';

class TranslationController extends ChangeNotifier {
  TranslationController({MockTranslationDataSource? dataSource})
    : _dataSource = dataSource ?? const MockTranslationDataSource() {
    _sourceLanguageCode = 'en';
    _targetLanguageCode = 'ta';
    _sourceText = defaultTranslationInput;
  }

  final MockTranslationDataSource _dataSource;

  String _sourceLanguageCode = 'en';
  String _targetLanguageCode = 'ta';
  String _sourceText = '';
  TranslationEntity? _translation;
  bool _isProcessing = false;

  String get sourceLanguageCode => _sourceLanguageCode;
  String get targetLanguageCode => _targetLanguageCode;
  String get sourceText => _sourceText;
  TranslationEntity? get translation => _translation;
  bool get isProcessing => _isProcessing;

  void setSourceLanguage(String code) {
    if (code == _targetLanguageCode) {
      _targetLanguageCode = _sourceLanguageCode;
    }

    _sourceLanguageCode = code;
    _translation = null;
    notifyListeners();
  }

  void setTargetLanguage(String code) {
    if (code == _sourceLanguageCode) {
      _sourceLanguageCode = _targetLanguageCode;
    }

    _targetLanguageCode = code;
    _translation = null;
    notifyListeners();
  }

  void setSourceText(String value) {
    _sourceText = value;
    if (_translation != null) {
      _translation = null;
      notifyListeners();
    } else {
      notifyListeners();
    }
  }

  void swapLanguages() {
    final oldSource = _sourceLanguageCode;
    _sourceLanguageCode = _targetLanguageCode;
    _targetLanguageCode = oldSource;
    _translation = null;
    notifyListeners();
  }

  void clear() {
    _sourceText = '';
    _translation = null;
    notifyListeners();
  }

  void translate() {
    if (_sourceText.trim().isEmpty) {
      _translation = TranslationEntity(
        sourceLanguageCode: _sourceLanguageCode,
        sourceLanguageName: _languageName(_sourceLanguageCode),
        targetLanguageCode: _targetLanguageCode,
        targetLanguageName: _languageName(_targetLanguageCode),
        sourceText: '',
        translatedText: '',
        status: TranslationStatus.empty,
        confidence: 0,
      );
      notifyListeners();
      return;
    }

    _isProcessing = true;
    _translation = null;
    notifyListeners();

    Future<void>.delayed(const Duration(milliseconds: 550), () {
      // Future: connect the documented NLLB-200 Distilled translation pipeline
      // here so real translation replaces this local demonstration result.
      final model = _dataSource.translate(
        sourceLanguageCode: _sourceLanguageCode,
        targetLanguageCode: _targetLanguageCode,
        sourceText: _sourceText,
      );

      _translation = model.toEntity();
      _isProcessing = false;
      notifyListeners();
    });
  }

  void setOffline() {
    _isProcessing = false;
    _translation = TranslationEntity(
      sourceLanguageCode: _sourceLanguageCode,
      sourceLanguageName: _languageName(_sourceLanguageCode),
      targetLanguageCode: _targetLanguageCode,
      targetLanguageName: _languageName(_targetLanguageCode),
      sourceText: _sourceText,
      translatedText: '',
      status: TranslationStatus.offline,
      confidence: 0,
    );
    notifyListeners();
  }

  String _languageName(String code) {
    for (final language in translationLanguages) {
      if (language.code == code) {
        return language.name;
      }
    }
    return code.toUpperCase();
  }
}
