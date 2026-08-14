/*
1. PAGE NAME
   Mock Settings Data Source

2. PURPOSE
   Provides local dummy settings data for the Settings UI.

3. DESCRIPTION
   This data source intentionally avoids networking, databases,
   authentication, and persistence.

4. UI SECTIONS
   Returns settings grouped by their presentation sections.

5. NAVIGATION FLOW
   Mock source → SettingsController → SettingsPage.

6. DYNAMIC COMPONENTS
   Local settings models.

7. FUTURE BACKEND INTEGRATION
   Replace this mock implementation with the project's intended settings
   repository/data source when persistence becomes available.

8. TECHNOLOGIES USED
   Dart.

9. REQUIRED DATA MODELS
   SettingsFeatureModel.

10. FUTURE API ENDPOINTS
    None defined by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    None defined.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Data remains independent from visual presentation.

17. EDGE CASES
    Empty groups are supported.

18. VALIDATION RULES
    No network validation is performed.

19. ERROR HANDLING
    No infrastructure error handling is required.

20. LOADING STATE
    The controller can represent loading independently.

21. EMPTY STATE
    Empty collections can be returned for UI testing.

22. OFFLINE BEHAVIOUR
    Data is available locally.

23. SECURITY CONSIDERATIONS
    No private user data.

24. PERFORMANCE OPTIMIZATIONS
    Const data and synchronous local access.

25. WIDGET TREE OVERVIEW
    Source → Controller → Page.

26. COMPLETE TESTING CHECKLIST
    Verify every section renders and empty collections remain safe.
*/

import '../dummy/settings_dummy_data.dart';
import '../models/settings_feature_model.dart';

class MockSettingsDataSource {
  const MockSettingsDataSource();

  List<SettingsFeatureModel> getLanguageSettings() {
    return settingsLanguageData;
  }

  List<SettingsFeatureModel> getCommunicationSettings() {
    return settingsCommunicationData;
  }

  List<SettingsFeatureModel> getConnectivitySettings() {
    return settingsConnectivityData;
  }

  List<SettingsFeatureModel> getAppearanceSettings() {
    return settingsAppearanceData;
  }

  List<SettingsFeatureModel> getInformationSettings() {
    return settingsInformationData;
  }
}
