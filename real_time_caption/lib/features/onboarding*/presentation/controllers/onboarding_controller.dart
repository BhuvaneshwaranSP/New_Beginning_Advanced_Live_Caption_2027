/*
1. PAGE NAME
   Onboarding Controller

2. PURPOSE
   Owns local UI state for source and target language selection.

3. DESCRIPTION
   Uses Flutter's local ChangeNotifier mechanism only. No external state
   management package or persistence is implemented.

4. UI SECTIONS
   Language selection and onboarding action state.

5. NAVIGATION FLOW
   Page → controller → selected languages → page action.

6. DYNAMIC COMPONENTS
   Source language, target language, and selection validation.

7. FUTURE BACKEND INTEGRATION
   Future: persist the selected source and target language preferences at the
   onboarding completion boundary because those preferences configure subsequent
   multilingual communication flows.

8. TECHNOLOGIES USED
   Flutter foundation ChangeNotifier.

9. REQUIRED DATA MODELS
   OnboardingEntity.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    None specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Exposes simple state suitable for semantic UI labels.

17. EDGE CASES
    Same source and target language.

18. VALIDATION RULES
    Source and target must be different.

19. ERROR HANDLING
    Invalid same-language selection returns a local validation message.

20. LOADING STATE
    Not required.

21. EMPTY STATE
    Not required.

22. OFFLINE BEHAVIOUR
    Selection remains functional offline.

23. SECURITY CONSIDERATIONS
    No credentials or personal information are handled.

24. PERFORMANCE OPTIMIZATIONS
    Notifies listeners only after meaningful state changes.

25. WIDGET TREE OVERVIEW
    Controller → page → selection widgets.

26. COMPLETE TESTING CHECKLIST
    Test source selection, target selection, swap, validation, and disposal.
*/

import 'package:flutter/foundation.dart';

import '../../domain/entities/onboarding_feature_entity.dart';

class OnboardingController extends ChangeNotifier {
  OnboardingController({required List<OnboardingEntity> languages})
    : _languages = List<OnboardingEntity>.unmodifiable(languages);

  final List<OnboardingEntity> _languages;

  OnboardingEntity? _sourceLanguage;
  OnboardingEntity? _targetLanguage;

  String? _validationMessage;

  List<OnboardingEntity> get languages => _languages;

  OnboardingEntity? get sourceLanguage => _sourceLanguage;

  OnboardingEntity? get targetLanguage => _targetLanguage;

  String? get validationMessage => _validationMessage;

  bool get canContinue =>
      _sourceLanguage != null &&
      _targetLanguage != null &&
      _sourceLanguage!.code != _targetLanguage!.code;

  void selectSource(OnboardingEntity language) {
    _sourceLanguage = language;

    if (_targetLanguage?.code == language.code) {
      _targetLanguage = null;
    }

    _validationMessage = null;
    notifyListeners();
  }

  void selectTarget(OnboardingEntity language) {
    if (_sourceLanguage?.code == language.code) {
      _validationMessage = 'Choose a different target language.';
      notifyListeners();
      return;
    }

    _targetLanguage = language;
    _validationMessage = null;
    notifyListeners();
  }

  void swapLanguages() {
    if (_sourceLanguage == null || _targetLanguage == null) {
      return;
    }

    final OnboardingEntity previousSource = _sourceLanguage!;
    _sourceLanguage = _targetLanguage;
    _targetLanguage = previousSource;
    _validationMessage = null;
    notifyListeners();
  }

  bool validate() {
    if (_sourceLanguage == null || _targetLanguage == null) {
      _validationMessage = 'Select both source and target languages.';
      notifyListeners();
      return false;
    }

    if (_sourceLanguage!.code == _targetLanguage!.code) {
      _validationMessage = 'Choose different source and target languages.';
      notifyListeners();
      return false;
    }

    _validationMessage = null;
    notifyListeners();

    // Future: pass the selected language pair into the next application flow;
    // onboarding establishes the language context used by later communication screens.
    return true;
  }
}
