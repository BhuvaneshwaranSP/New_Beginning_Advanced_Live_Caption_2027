/*
1. PAGE NAME
   Mock Accessibility Data Source

2. PURPOSE
   Supplies local dummy accessibility data to the feature.

3. DESCRIPTION
   Provides deterministic data without network or persistence dependencies.

4. UI SECTIONS
   Accessibility settings and communication preferences.

5. NAVIGATION FLOW
   Data source → Controller → AccessibilityPage.

6. DYNAMIC COMPONENTS
   Local settings and preference choices.

7. FUTURE BACKEND INTEGRATION
   Replace this source with the project's supported preference repository
   when real persistence is introduced.

8. TECHNOLOGIES USED
   Dart.

9. REQUIRED DATA MODELS
   AccessibilityFeatureModel.

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
    Provides accessible labels through model data.

17. EDGE CASES
    Empty data falls back to empty immutable collections.

18. VALIDATION RULES
    No external input is accepted.

19. ERROR HANDLING
    No external failure is possible.

20. LOADING STATE
    Not needed for local dummy data.

21. EMPTY STATE
    Controller can represent an empty state if source data changes.

22. OFFLINE BEHAVIOUR
    Fully functional with local data.

23. SECURITY CONSIDERATIONS
    No sensitive data.

24. PERFORMANCE OPTIMIZATIONS
    Const data access.

25. WIDGET TREE OVERVIEW
    Source → Controller → Page.

26. COMPLETE TESTING CHECKLIST
    Verify the controller receives the expected dummy collections.
*/

import '../dummy/accessibility_dummy_data.dart';
import '../models/accessibility_feature_model.dart';

class MockAccessibilityDataSource {
  const MockAccessibilityDataSource();

  List<AccessibilitySettingModel> getSettings() {
    return accessibilitySettings;
  }

  List<CommunicationPreferenceModel> getCommunicationPreferences() {
    return communicationPreferences;
  }
}
