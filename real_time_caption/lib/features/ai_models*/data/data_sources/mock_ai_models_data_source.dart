/*
1. PAGE NAME
   Mock AI Models Data Source

2. PURPOSE
   Provides local model data to the UI without network, database, or AI
   infrastructure.

3. DESCRIPTION
   This data source deliberately acts as a local stand-in for the future
   model catalog source.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Dummy catalog → mock data source → controller → page.

6. DYNAMIC COMPONENTS
   AI model catalog.

7. FUTURE BACKEND INTEGRATION
   Future model-management data retrieval belongs at this boundary so the
   presentation layer remains independent of the actual source.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   AiModelModel.

10. FUTURE API ENDPOINTS
   Not defined.

11. DATABASE COLLECTIONS/TABLES
   Not defined.

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
   An empty catalog can be returned by changing the local dummy source.

18. VALIDATION RULES
   None.

19. ERROR HANDLING
   The method exposes a simple local failure simulation hook through
   simulateError without performing external operations.

20. LOADING STATE
   Loading is controlled by the presentation controller.

21. EMPTY STATE
   Empty results are handled by the page.

22. OFFLINE BEHAVIOUR
   The source is always local in this UI-only implementation.

23. SECURITY CONSIDERATIONS
   No external credentials or network access.

24. PERFORMANCE OPTIMIZATIONS
   Static local list and synchronous retrieval.

25. WIDGET TREE OVERVIEW
   Not applicable.

26. COMPLETE TESTING CHECKLIST
   Verify normal catalog retrieval and local simulated error handling.
*/

import '../dummy/ai_models_dummy_data.dart';
import '../models/ai_model_model.dart';

class MockAiModelsDataSource {
  const MockAiModelsDataSource();

  List<AiModelModel> getModels({bool simulateError = false}) {
    if (simulateError) {
      throw StateError('Unable to load the local model catalog.');
    }

    return List<AiModelModel>.unmodifiable(aiModelsDummyData);
  }
}
