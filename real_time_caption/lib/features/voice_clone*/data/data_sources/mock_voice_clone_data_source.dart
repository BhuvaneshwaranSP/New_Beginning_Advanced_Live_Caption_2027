/*
1. PAGE NAME
   Mock Voice Clone Data Source

2. PURPOSE
   Supplies local dummy voice-profile data to the feature.

3. DESCRIPTION
   Simulates a data source without networking or persistence.

4. UI SECTIONS
   Provides data for the profile selector.

5. NAVIGATION FLOW
   Mock source → controller → page.

6. DYNAMIC COMPONENTS
   Local voice profiles.

7. FUTURE BACKEND INTEGRATION
   A future supported voice-profile repository can replace this mock source
   at the data boundary without changing the presentation widgets.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   VoiceCloneModel.

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
    Not applicable to the data source.

17. EDGE CASES
    Empty local collection.

18. VALIDATION RULES
    None beyond model construction.

19. ERROR HANDLING
    Presentation state can simulate errors without throwing network errors.

20. LOADING STATE
    Controller simulates local loading.

21. EMPTY STATE
    Empty collection can be supplied.

22. OFFLINE BEHAVIOUR
    Data remains available locally.

23. SECURITY CONSIDERATIONS
    No real voice recordings are loaded.

24. PERFORMANCE OPTIMIZATIONS
    Synchronous immutable dummy data.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify returned list and compatibility with controller mapping.
*/

import '../dummy/voice_clone_dummy_data.dart';
import '../models/voice_clone_model.dart';

class MockVoiceCloneDataSource {
  const MockVoiceCloneDataSource();

  List<VoiceCloneModel> loadProfiles() {
    return VoiceCloneDummyData.profiles;
  }
}