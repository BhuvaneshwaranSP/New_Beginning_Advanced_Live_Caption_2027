/*
1. PAGE NAME
   Mock Chat Data Source

2. PURPOSE
   Provides local data to the Chat feature during UI development.

3. DESCRIPTION
   No network, database, Firebase, authentication, or real AI service is used.

4. UI SECTIONS
   Supplies conversation content for the chat page.

5. NAVIGATION FLOW
   Mock source → Controller → ChatPage.

6. DYNAMIC COMPONENTS
   Message collection.

7. FUTURE BACKEND INTEGRATION
   This source will later be replaced by the project's supported chat/session
   data source when real chat conversion and translation are integrated.

8. TECHNOLOGIES USED
   Pure Dart.

9. REQUIRED DATA MODELS
   ChatFeatureModel.

10. FUTURE API ENDPOINTS
    Not specified in supplied documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified in supplied documentation.

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
    Empty conversation and local sample messages.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    Controller can represent local error state independently.

20. LOADING STATE
    Controller represents loading before consuming this source.

21. EMPTY STATE
    Returns an empty list when requested by future screen scenarios.

22. OFFLINE BEHAVIOUR
    Local dummy content remains available.

23. SECURITY CONSIDERATIONS
    No external data is accessed.

24. PERFORMANCE OPTIMIZATIONS
    Returns immutable dummy data.

25. WIDGET TREE OVERVIEW
    Data source → controller → presentation.

26. COMPLETE TESTING CHECKLIST
    Verify normal and empty collections.
*/

import '../dummy/chat_dummy_data.dart';
import '../models/chat_feature_model.dart';

class MockChatDataSource {
  const MockChatDataSource();

  List<ChatFeatureModel> loadMessages() {
    return List<ChatFeatureModel>.unmodifiable(chatDummyMessages);
  }

  List<ChatFeatureModel> loadEmptyMessages() {
    return const <ChatFeatureModel>[];
  }
}
