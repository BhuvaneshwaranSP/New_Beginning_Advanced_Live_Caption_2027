/*
1. PAGE NAME
   Accessibility Controller

2. PURPOSE
   Owns local UI state for the Accessibility page.

3. DESCRIPTION
   Provides simple Flutter-compatible local state without a state-management
   package, persistence, networking, or backend functionality.

4. UI SECTIONS
   Settings, preview, communication preferences, and state feedback.

5. NAVIGATION FLOW
   AccessibilityPage → Controller → child widgets.

6. DYNAMIC COMPONENTS
   Toggle settings, text/caption scale, and communication preferences.

7. FUTURE BACKEND INTEGRATION
   Future: connect the preference repository here so accessibility choices
   can be persisted and restored across sessions.

8. TECHNOLOGIES USED
   Dart and Flutter ChangeNotifier.

9. REQUIRED DATA MODELS
   AccessibilitySettingEntity and CommunicationPreferenceEntity.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    None specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    Child widgets animate local value changes.

16. ACCESSIBILITY
    State changes are exposed through semantic widget labels.

17. EDGE CASES
    Values are clamped before updating.

18. VALIDATION RULES
    Text/caption scale remains between 0.85 and 1.35.

19. ERROR HANDLING
    Retry resets the local preview state.

20. LOADING STATE
    Controller exposes a local loading flag for UI demonstration.

21. EMPTY STATE
    Controller supports an empty-state flag.

22. OFFLINE BEHAVIOUR
    No external connection is required.

23. SECURITY CONSIDERATIONS
    State is memory-only.

24. PERFORMANCE OPTIMIZATIONS
    notifyListeners is called only after state changes.

25. WIDGET TREE OVERVIEW
    Page → Controller → setting/preference widgets.

26. COMPLETE TESTING CHECKLIST
    Test toggles, sliders, retry, loading, empty state, and preference changes.
*/

import 'package:flutter/material.dart';

import '../../data/data_sources/mock_accessibility_data_source.dart';
import '../../domain/entities/accessibility_feature_entity.dart';

class AccessibilityController extends ChangeNotifier {
  AccessibilityController({MockAccessibilityDataSource? dataSource})
    : _dataSource = dataSource ?? const MockAccessibilityDataSource() {
    _settings = _dataSource
        .getSettings()
        .map(
          (item) => AccessibilitySettingEntity(
            id: item.id,
            title: item.title,
            description: item.description,
            icon: item.icon,
            enabled: item.enabled,
            value: item.value,
            valueLabel: item.valueLabel,
          ),
        )
        .toList();

    _preferences = _dataSource
        .getCommunicationPreferences()
        .map(
          (item) => CommunicationPreferenceEntity(
            id: item.id,
            title: item.title,
            description: item.description,
            icon: item.icon,
            selected: item.selected,
          ),
        )
        .toList();
  }

  final MockAccessibilityDataSource _dataSource;

  late List<AccessibilitySettingEntity> _settings;
  late List<CommunicationPreferenceEntity> _preferences;

  bool isLoading = false;
  bool hasError = false;
  bool isEmpty = false;

  double textScale = 1.0;
  double captionScale = 1.0;

  List<AccessibilitySettingEntity> get settings => List.unmodifiable(_settings);

  List<CommunicationPreferenceEntity> get preferences =>
      List.unmodifiable(_preferences);

  bool isEnabled(String id) {
    final index = _settings.indexWhere((setting) => setting.id == id);

    if (index == -1) {
      return false;
    }

    return _settings[index].enabled;
  }

  void toggleSetting(String id) {
    final index = _settings.indexWhere((setting) => setting.id == id);

    if (index == -1) {
      return;
    }

    final current = _settings[index];

    _settings[index] = AccessibilitySettingEntity(
      id: current.id,
      title: current.title,
      description: current.description,
      icon: current.icon,
      enabled: !current.enabled,
      value: current.value,
      valueLabel: current.valueLabel,
    );

    notifyListeners();
  }

  void togglePreference(String id) {
    final index = _preferences.indexWhere((preference) => preference.id == id);

    if (index == -1) {
      return;
    }

    final current = _preferences[index];

    _preferences[index] = CommunicationPreferenceEntity(
      id: current.id,
      title: current.title,
      description: current.description,
      icon: current.icon,
      selected: !current.selected,
    );

    notifyListeners();
  }

  void setTextScale(double value) {
    textScale = value.clamp(0.85, 1.35);
    notifyListeners();
  }

  void setCaptionScale(double value) {
    captionScale = value.clamp(0.85, 1.35);
    notifyListeners();
  }

  void simulateLoading() {
    isLoading = !isLoading;
    hasError = false;
    notifyListeners();
  }

  void simulateError() {
    isLoading = false;
    hasError = true;
    notifyListeners();
  }

  void retry() {
    isLoading = false;
    hasError = false;
    isEmpty = false;
    notifyListeners();
  }
}
