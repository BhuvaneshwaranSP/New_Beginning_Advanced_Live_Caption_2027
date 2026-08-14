/*
1. PAGE NAME
   Mock Conversations Data Source

2. PURPOSE
   Provides the Conversations feature with local dummy data.

3. DESCRIPTION
   Acts as a lightweight source boundary so the presentation layer does not
   directly own the dummy dataset.

4. UI SECTIONS
   Conversation history.

5. NAVIGATION FLOW
   Mock source → controller → Conversations page.

6. DYNAMIC COMPONENTS
   Conversation collection.

7. FUTURE BACKEND INTEGRATION
   Future Session History retrieval belongs at this source boundary because
   the controller should remain independent from persistence and networking.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   ConversationsFeatureModel.

10. FUTURE API ENDPOINTS
    No endpoint is defined by the supplied documentation.

11. DATABASE COLLECTIONS/TABLES
    Future session-history persistence; exact structure is not specified.

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
    Empty local dataset.

18. VALIDATION RULES
    Returns immutable dummy data.

19. ERROR HANDLING
    UI can represent errors without this source throwing infrastructure errors.

20. LOADING STATE
    Controlled by the presentation controller.

21. EMPTY STATE
    An empty collection is supported.

22. OFFLINE BEHAVIOUR
    Local data remains available without connectivity.

23. SECURITY CONSIDERATIONS
    No external data access.

24. PERFORMANCE OPTIMIZATIONS
    Returns a prebuilt immutable list.

25. WIDGET TREE OVERVIEW
    Source → controller → state/content widgets.

26. COMPLETE TESTING CHECKLIST
    Verify returned records, empty collection handling, and controller
    integration.
*/

import '../dummy/conversations_dummy_data.dart';
import '../models/conversations_feature_model.dart';

class MockConversationsDataSource {
  const MockConversationsDataSource();

  List<ConversationsFeatureModel> getConversations() {
    // Future: replace this local source with Session History retrieval;
    // this boundary isolates persistence from the Conversations presentation.
    return conversationsDummyData;
  }
}
