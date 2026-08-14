/*
1. PAGE NAME
   Mock Contacts Data Source

2. PURPOSE
   Provides local Contacts data without implementing networking or persistence.

3. DESCRIPTION
   Acts as the UI-only data boundary for the Contacts feature.

4. UI SECTIONS
   Contacts list.

5. NAVIGATION FLOW
   MockContactsDataSource → ContactsController → ContactsPage.

6. DYNAMIC COMPONENTS
   Contact collection and local loading/error representations.

7. FUTURE BACKEND INTEGRATION
   The data-source boundary is the intended location for connecting the
   Contacts repository when real contact retrieval is implemented.

8. TECHNOLOGIES USED
   Pure Dart.

9. REQUIRED DATA MODELS
   ContactFeatureModel.

10. FUTURE API ENDPOINTS
    Not defined in supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not defined in supplied project documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Not applicable.

17. EDGE CASES
    Empty and error demo states are exposed through optional parameters.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    Error behavior is represented locally for UI testing only.

20. LOADING STATE
    Controller simulates a local loading state.

21. EMPTY STATE
    Empty list can be supplied to the controller.

22. OFFLINE BEHAVIOUR
    No network detection is performed.

23. SECURITY CONSIDERATIONS
    No credentials or private data are used.

24. PERFORMANCE OPTIMIZATIONS
    Returns an immutable local list.

25. WIDGET TREE OVERVIEW
    Data source → controller → page.

26. COMPLETE TESTING CHECKLIST
    Verify successful, empty, and error data-state rendering.
*/

import '../dummy/contacts_dummy_data.dart';
import '../models/contacts_feature_model.dart';

class MockContactsDataSource {
  const MockContactsDataSource();

  List<ContactFeatureModel> loadContacts() {
    return contactsDummyData;
  }
}
