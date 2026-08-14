/*
1. PAGE NAME
   Mock Help Center Data Source

2. PURPOSE
   Supplies local Help Center models to the presentation layer.

3. DESCRIPTION
   UI-only data source with no networking, database, Firebase, or API calls.

4. UI SECTIONS
   Categories and FAQ articles.

5. NAVIGATION FLOW
   Mock source → controller → Help Center page.

6. DYNAMIC COMPONENTS
   Local category and article collections.

7. FUTURE BACKEND INTEGRATION
   Future: replace local retrieval with the supported Help Center repository
   implementation when a production content source is defined.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   HelpCenterCategoryModel
   HelpCenterArticleModel

10. FUTURE API ENDPOINTS
    Not specified.

11. DATABASE COLLECTIONS/TABLES
    Not specified.

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
    Collections can be empty without causing exceptions.

18. VALIDATION RULES
    Local data is assumed valid.

19. ERROR HANDLING
    No external errors are generated.

20. LOADING STATE
    Controller simulates the UI state locally.

21. EMPTY STATE
    Controller can expose empty filtered results.

22. OFFLINE BEHAVIOUR
    Local data remains available.

23. SECURITY CONSIDERATIONS
    No sensitive data.

24. PERFORMANCE OPTIMIZATIONS
    Returns existing immutable local collections.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify category/article retrieval and empty collection handling.
*/

import '../dummy/help_center_dummy_data.dart';
import '../models/help_center_feature_model.dart';

class MockHelpCenterDataSource {
  const MockHelpCenterDataSource();

  List<HelpCenterCategoryModel> getCategories() {
    return helpCenterCategories;
  }

  List<HelpCenterArticleModel> getArticles() {
    return helpCenterArticles;
  }
}
