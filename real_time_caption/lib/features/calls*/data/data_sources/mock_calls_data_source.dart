/*
1. PAGE NAME
   Mock Calls Data Source

2. PURPOSE
   Provides local Calls feature data without implementing backend services.

3. DESCRIPTION
   This is intentionally a UI-development data source.

4. UI SECTIONS
   Supplies the recent calls list.

5. NAVIGATION FLOW
   Mock source → Controller → Calls page.

6. DYNAMIC COMPONENTS
   Recent calls.

7. FUTURE BACKEND INTEGRATION
   Future: replace this local source with the call-session repository so the
   page can receive real call history and current call state.

8. TECHNOLOGIES USED
   Dart.

9. REQUIRED DATA MODELS
   CallsFeatureModel.

10. FUTURE API ENDPOINTS
    Call history and active call-session endpoints will be integrated later.

11. DATABASE COLLECTIONS/TABLES
    Call-session history will be persisted later.

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
    Empty result is supported by the controller.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    No real errors are generated.

20. LOADING STATE
    Simulated by the controller.

21. EMPTY STATE
    Supported when the returned list is empty.

22. OFFLINE BEHAVIOUR
    No network request is made.

23. SECURITY CONSIDERATIONS
    No sensitive information is accessed.

24. PERFORMANCE OPTIMIZATIONS
    Static immutable list.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify list retrieval and empty-list handling.
*/

import '../dummy/calls_dummy_data.dart';
import '../models/calls_feature_model.dart';

class MockCallsDataSource {
  const MockCallsDataSource();

  List<CallsFeatureModel> loadCalls() {
    return List<CallsFeatureModel>.unmodifiable(callsDummyData);
  }
}
