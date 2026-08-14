/*
1. PAGE NAME
   Settings Controller

2. PURPOSE
   Manages local UI state for the LinguaLive Settings screen.

3. DESCRIPTION
   Uses Flutter's built-in ValueNotifier without an external state-management
   package. It controls only presentation state and dummy preference values.

4. UI SECTIONS
   Language, communication, connectivity, and appearance settings.

5. NAVIGATION FLOW
   SettingsPage → SettingsController → local state changes.

6. DYNAMIC COMPONENTS
   Switch values, selected appearance mode, and selected connectivity mode.

7. FUTURE BACKEND INTEGRATION
   Future: persist changed preferences through the project's settings storage
   layer here so UI state and durable preferences remain synchronized.

8. TECHNOLOGIES USED
   Dart and Flutter ValueNotifier.

9. REQUIRED DATA MODELS
   SettingsFeatureEntity.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    None specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons are handled by widgets.

14. THEME COLORS
    Uses Material 3 theme values in presentation.

15. ANIMATIONS
    Value changes trigger lightweight widget animations.

16. ACCESSIBILITY
    State is exposed to standard Flutter controls.

17. EDGE CASES
    Repeated toggles and disposal.

18. VALIDATION RULES
    Only predefined local values are accepted.

19. ERROR HANDLING
    No service errors are handled.

20. LOADING STATE
    Controller exposes a local loading flag.

21. EMPTY STATE
    Page handles empty data separately.

22. OFFLINE BEHAVIOUR
    Local preference state remains usable without network access.

23. SECURITY CONSIDERATIONS
    No credentials or sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    ValueNotifier avoids broad widget-tree rebuilds.

25. WIDGET TREE OVERVIEW
    Controller → ValueListenableBuilder → Settings widgets.

26. COMPLETE TESTING CHECKLIST
    Verify state changes, disposal, dark mode, accessibility,
    and rebuild scope.
*/

import 'package:flutter/foundation.dart';

import '../../data/data_sources/mock_settings_data_source.dart';
import '../../domain/entities/settings_feature_entity.dart';

class SettingsController {
  SettingsController({MockSettingsDataSource? dataSource})
    : _dataSource = dataSource ?? const MockSettingsDataSource();

  final MockSettingsDataSource _dataSource;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isOffline = ValueNotifier<bool>(false);

  final ValueNotifier<bool> liveCaptionsEnabled = ValueNotifier<bool>(true);
  final ValueNotifier<bool> contextTranslationEnabled = ValueNotifier<bool>(
    true,
  );
  final ValueNotifier<bool> translatedSpeechEnabled = ValueNotifier<bool>(
    false,
  );

  final ValueNotifier<String> appearance = ValueNotifier<String>('System');

  final ValueNotifier<String> offlinePreference = ValueNotifier<String>(
    'Automatic',
  );

  List<SettingsFeatureEntity> get languageSettings => _dataSource
      .getLanguageSettings()
      .map((model) => model.toEntity())
      .toList(growable: false);

  List<SettingsFeatureEntity> get communicationSettings => _dataSource
      .getCommunicationSettings()
      .map((model) => model.toEntity())
      .toList(growable: false);

  List<SettingsFeatureEntity> get connectivitySettings => _dataSource
      .getConnectivitySettings()
      .map((model) => model.toEntity())
      .toList(growable: false);

  List<SettingsFeatureEntity> get appearanceSettings => _dataSource
      .getAppearanceSettings()
      .map((model) => model.toEntity())
      .toList(growable: false);

  List<SettingsFeatureEntity> get informationSettings => _dataSource
      .getInformationSettings()
      .map((model) => model.toEntity())
      .toList(growable: false);

  void setLiveCaptions(bool value) {
    liveCaptionsEnabled.value = value;
  }

  void setContextTranslation(bool value) {
    contextTranslationEnabled.value = value;
  }

  void setTranslatedSpeech(bool value) {
    translatedSpeechEnabled.value = value;
  }

  void setAppearance(String value) {
    if (value == 'System' || value == 'Light' || value == 'Dark') {
      appearance.value = value;
    }
  }

  void setOfflinePreference(String value) {
    if (value == 'Automatic' ||
        value == 'Offline first' ||
        value == 'Online first') {
      offlinePreference.value = value;
    }
  }

  void setOfflinePreview(bool value) {
    isOffline.value = value;
  }

  void dispose() {
    isLoading.dispose();
    isOffline.dispose();
    liveCaptionsEnabled.dispose();
    contextTranslationEnabled.dispose();
    translatedSpeechEnabled.dispose();
    appearance.dispose();
    offlinePreference.dispose();
  }
}
