/*
1. PAGE NAME
   Mock Profile Data Source

2. PURPOSE
   Provides local profile data for the UI-only Profile feature.

3. DESCRIPTION
   This source deliberately contains no API, database, Firebase, or network
   implementation.

4. UI SECTIONS
   Supplies the Profile page.

5. NAVIGATION FLOW
   MockProfileDataSource → ProfileController → ProfilePage.

6. DYNAMIC COMPONENTS
   ProfileFeatureModel.

7. FUTURE BACKEND INTEGRATION
   The getProfile method is the data boundary where a future profile/account
   repository can supply persisted user information.

8. TECHNOLOGIES USED
   Pure Dart.

9. REQUIRED DATA MODELS
   ProfileFeatureModel.

10. FUTURE API ENDPOINTS
    Not specified by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified by the supplied project documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    Not applicable.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Presentation responsibility.

17. EDGE CASES
    Local dummy data avoids network-dependent failures.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    Controller owns UI state representation.

20. LOADING STATE
    Controller representation.

21. EMPTY STATE
    Controller representation.

22. OFFLINE BEHAVIOUR
    Local data source continues to provide profile content.

23. SECURITY CONSIDERATIONS
    Dummy profile data only.

24. PERFORMANCE OPTIMIZATIONS
    No asynchronous network work is performed.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify the data source returns the expected model.
*/

import '../dummy/profile_dummy_data.dart';
import '../models/profile_feature_model.dart';

class MockProfileDataSource {
  const MockProfileDataSource();

  ProfileFeatureModel getProfile() {
    return profileDummyData;
  }
}
