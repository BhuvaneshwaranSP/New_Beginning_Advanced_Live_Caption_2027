/*
1. PAGE NAME
   Home Controller

2. PURPOSE
   Holds local presentation state for the Home page.

3. DESCRIPTION
   Uses Flutter's local ChangeNotifier only. No external state-management
   package is used.

4. UI SECTIONS
   Language pair and navigation state.

5. NAVIGATION FLOW
   Home page ↔ local controller state.

6. DYNAMIC COMPONENTS
   Selected source language, selected target language, bottom navigation index.

7. FUTURE BACKEND INTEGRATION
   Future: connect language selection to the project's communication setup;
   this controller owns temporary UI state before the real workflow is added.

8. TECHNOLOGIES USED
   Flutter ChangeNotifier.

9. REQUIRED DATA MODELS
   LanguageOptionEntity.

10. FUTURE API ENDPOINTS
    None implemented.

11. DATABASE COLLECTIONS/TABLES
    None implemented.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Presentation widgets provide semantics.

17. EDGE CASES
    Same source/target selection and null selections.

18. VALIDATION RULES
    Null dropdown selections are ignored.

19. ERROR HANDLING
    No external operations.

20. LOADING STATE
    Not owned by this controller.

21. EMPTY STATE
    Not owned by this controller.

22. OFFLINE BEHAVIOUR
    Not owned by this controller.

23. SECURITY CONSIDERATIONS
    No sensitive data.

24. PERFORMANCE OPTIMIZATIONS
    Small synchronous state changes.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Source selection, target selection, swap, navigation index, disposal.
*/

import 'package:flutter/foundation.dart';

import '../../domain/entities/home_feature_entity.dart';

class HomeController extends ChangeNotifier {
  HomeController({required List<LanguageOptionEntity> languages})
    : _languages = List<LanguageOptionEntity>.unmodifiable(languages) {
    _sourceLanguage = _languages.first;
    _targetLanguage = _languages.length > 1 ? _languages[1] : _languages.first;
  }

  final List<LanguageOptionEntity> _languages;

  late LanguageOptionEntity _sourceLanguage;
  late LanguageOptionEntity _targetLanguage;

  int _navigationIndex = 0;

  List<LanguageOptionEntity> get languages => _languages;

  LanguageOptionEntity get sourceLanguage => _sourceLanguage;

  LanguageOptionEntity get targetLanguage => _targetLanguage;

  int get navigationIndex => _navigationIndex;

  void selectSourceLanguage(LanguageOptionEntity? language) {
    if (language == null) {
      return;
    }

    _sourceLanguage = language;
    notifyListeners();
  }

  void selectTargetLanguage(LanguageOptionEntity? language) {
    if (language == null) {
      return;
    }

    _targetLanguage = language;
    notifyListeners();
  }

  void swapLanguages() {
    final LanguageOptionEntity oldSource = _sourceLanguage;
    _sourceLanguage = _targetLanguage;
    _targetLanguage = oldSource;
    notifyListeners();
  }

  void selectNavigationItem(int index) {
    _navigationIndex = index;
    notifyListeners();
  }
}
