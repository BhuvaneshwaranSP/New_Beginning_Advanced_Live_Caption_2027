/*
1. PAGE NAME
   Mock History Data Source

2. PURPOSE
   Provides local history records to the UI without external services.

3. DESCRIPTION
   A UI-only mock source that exposes the supplied dummy session data.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Mock source → HistoryController → HistoryPage.

6. DYNAMIC COMPONENTS
   History records.

7. FUTURE BACKEND INTEGRATION
   The source will later be replaced or supplemented by the project's
   persisted session-history repository.

8. TECHNOLOGIES USED
   Dart and Flutter foundation ChangeNotifier is not used here.

9. REQUIRED DATA MODELS
   HistoryFeatureModel.

10. FUTURE API ENDPOINTS
    No endpoint is implemented.

11. DATABASE COLLECTIONS/TABLES
    No database is implemented.

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
    Empty list can be represented if the dummy source is changed.

18. VALIDATION RULES
    Returned records are immutable.

19. ERROR HANDLING
    No real I/O is performed.

20. LOADING STATE
    Simulated by the controller, not by this source.

21. EMPTY STATE
    Supported through an empty returned list.

22. OFFLINE BEHAVIOUR
    Local dummy history remains available.

23. SECURITY CONSIDERATIONS
    No external data is accessed.

24. PERFORMANCE OPTIMIZATIONS
    Returns the existing immutable dummy list.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify the source returns the expected number and order of records.
*/

import '../dummy/history_dummy_data.dart';
import '../models/history_feature_model.dart';

class MockHistoryDataSource {
  const MockHistoryDataSource();

  List<HistoryFeatureModel> loadHistory() {
    return historyDummyData;
  }
}
