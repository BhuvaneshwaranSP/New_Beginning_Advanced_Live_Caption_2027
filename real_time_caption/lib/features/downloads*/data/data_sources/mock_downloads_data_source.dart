/*
1. PAGE NAME
   Mock Downloads Data Source

2. PURPOSE
   Supplies local dummy Downloads data to the presentation layer.

3. DESCRIPTION
   UI-only data source. No filesystem, database, API, or network access occurs.

4. UI SECTIONS
   Downloads list.

5. NAVIGATION FLOW
   Mock source → controller → page.

6. DYNAMIC COMPONENTS
   Download item collection.

7. FUTURE BACKEND INTEGRATION
   Future: connect this source to the application's intended local download
   storage and offline resource management layer.

8. TECHNOLOGIES USED
   Dart.

9. REQUIRED DATA MODELS
   DownloadsFeatureModel.

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
    Delegated to presentation.

17. EDGE CASES
    Empty and populated data sets.

18. VALIDATION RULES
    None beyond model construction.

19. ERROR HANDLING
    Presentation can simulate error state independently.

20. LOADING STATE
    Presentation can simulate loading state independently.

21. EMPTY STATE
    Empty model collection is supported.

22. OFFLINE BEHAVIOUR
    No network is accessed.

23. SECURITY CONSIDERATIONS
    No private data is accessed.

24. PERFORMANCE OPTIMIZATIONS
    Synchronous local retrieval.

25. WIDGET TREE OVERVIEW
    Data source → controller → page.

26. COMPLETE TESTING CHECKLIST
    Verify populated and empty collections.
*/

import '../dummy/downloads_dummy_data.dart';
import '../models/downloads_feature_model.dart';

class MockDownloadsDataSource {
  const MockDownloadsDataSource();

  List<DownloadsFeatureModel> getDownloads() {
    return List<DownloadsFeatureModel>.of(downloadsDummyData);
  }
}
