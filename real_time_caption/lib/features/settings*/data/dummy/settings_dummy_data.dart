/*
1. PAGE NAME
   Settings Dummy Data

2. PURPOSE
   Supplies realistic local Settings data for UI development.

3. DESCRIPTION
   Contains no network, database, authentication, or persistence functionality.

4. UI SECTIONS
   Language, translation, speech and captions, connectivity, appearance,
   and application information.

5. NAVIGATION FLOW
   Dummy data → mock data source → Settings page.

6. DYNAMIC COMPONENTS
   Local preference values and setting descriptions.

7. FUTURE BACKEND INTEGRATION
   Replace the mock source with the intended persistence/data layer
   when real settings synchronization is implemented.

8. TECHNOLOGIES USED
   Dart.

9. REQUIRED DATA MODELS
   SettingsFeatureModel.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    None specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material icon names represented as strings.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Descriptions provide context beyond iconography.

17. EDGE CASES
    Long language labels and disabled preferences.

18. VALIDATION RULES
    Dummy values must remain internally consistent.

19. ERROR HANDLING
    Not applicable.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    The source can return an empty list if required by UI testing.

22. OFFLINE BEHAVIOUR
    Values are available locally without a network.

23. SECURITY CONSIDERATIONS
    No real user information.

24. PERFORMANCE OPTIMIZATIONS
    Const model instances and immutable lists.

25. WIDGET TREE OVERVIEW
    Dummy model list → section grouping → setting tiles.

26. COMPLETE TESTING CHECKLIST
    Test all values at small widths, large text, and dark mode.
*/

import '../models/settings_feature_model.dart';

const List<SettingsFeatureModel> settingsLanguageData = [
  SettingsFeatureModel(
    id: 'source_language',
    title: 'Source language',
    description: 'Language used for speech input',
    value: 'English',
    icon: 'language',
    controlType: SettingsControlType.selection,
  ),
  SettingsFeatureModel(
    id: 'target_language',
    title: 'Target language',
    description: 'Language used for translated output',
    value: 'Tamil',
    icon: 'translate',
    controlType: SettingsControlType.selection,
  ),
];

const List<SettingsFeatureModel> settingsCommunicationData = [
  SettingsFeatureModel(
    id: 'live_captions',
    title: 'Live captions',
    description: 'Show recognized speech as captions',
    value: 'On',
    icon: 'closed_caption',
    controlType: SettingsControlType.switchControl,
  ),
  SettingsFeatureModel(
    id: 'context_translation',
    title: 'Context-aware translation',
    description: 'Use conversational context when preparing translations',
    value: 'On',
    icon: 'auto_awesome',
    controlType: SettingsControlType.switchControl,
  ),
  SettingsFeatureModel(
    id: 'text_to_speech',
    title: 'Translated speech',
    description: 'Allow translated text to be presented as speech',
    value: 'Off',
    icon: 'volume_up',
    controlType: SettingsControlType.switchControl,
  ),
];

const List<SettingsFeatureModel> settingsConnectivityData = [
  SettingsFeatureModel(
    id: 'offline_mode',
    title: 'Offline mode preference',
    description: 'Prefer locally available processing when possible',
    value: 'Automatic',
    icon: 'cloud_off',
    controlType: SettingsControlType.selection,
  ),
];

const List<SettingsFeatureModel> settingsAppearanceData = [
  SettingsFeatureModel(
    id: 'appearance',
    title: 'Appearance',
    description: 'Choose how LinguaLive follows your device theme',
    value: 'System',
    icon: 'brightness_6',
    controlType: SettingsControlType.selection,
  ),
];

const List<SettingsFeatureModel> settingsInformationData = [
  SettingsFeatureModel(
    id: 'privacy',
    title: 'Privacy',
    description: 'Review communication and processing preferences',
    value: 'View',
    icon: 'shield_outlined',
    controlType: SettingsControlType.information,
  ),
  SettingsFeatureModel(
    id: 'about',
    title: 'About LinguaLive',
    description: 'Application information',
    value: 'View',
    icon: 'info_outline',
    controlType: SettingsControlType.information,
  ),
];