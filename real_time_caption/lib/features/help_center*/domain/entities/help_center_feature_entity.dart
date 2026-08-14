/*
1. PAGE NAME
   Help Center Feature Domain Entities

2. PURPOSE
   Defines the domain entities used by the LinguaLive Help Center.

3. DESCRIPTION
   Contains pure Dart immutable entities. Flutter-specific icons are
   intentionally excluded from the domain layer.

4. UI SECTIONS
   Help categories and FAQ articles.

5. NAVIGATION FLOW
   Help Center page → controller → domain entities.

6. DYNAMIC COMPONENTS
   Categories, FAQ articles, search results, expanded article.

7. FUTURE BACKEND INTEGRATION
   Future: map supported Help Center content into these domain entities;
   the domain layer remains independent from the external data source.

8. TECHNOLOGIES USED
   Dart.

9. REQUIRED DATA MODELS
   HelpCenterCategoryEntity
   HelpCenterArticleEntity

10. FUTURE API ENDPOINTS
    Not specified by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified by the supplied project documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None in the domain layer.

14. THEME COLORS
    None in the domain layer.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Implemented by presentation widgets.

17. EDGE CASES
    Empty descriptions, empty search results, and long multilingual content.

18. VALIDATION RULES
    Identifiers and display values are immutable.

19. ERROR HANDLING
    Handled by presentation/controller layers.

20. LOADING STATE
    Handled by presentation/controller layers.

21. EMPTY STATE
    Handled by presentation/controller layers.

22. OFFLINE BEHAVIOUR
    Local content remains available.

23. SECURITY CONSIDERATIONS
    No sensitive information is stored.

24. PERFORMANCE OPTIMIZATIONS
    Immutable entities.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify construction, immutability, null safety, and model mapping.
*/

enum HelpCenterCategoryType {
  gettingStarted,
  translation,
  liveCommunication,
  privacy,
}

class HelpCenterCategoryEntity {
  const HelpCenterCategoryEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
  });

  final String id;
  final HelpCenterCategoryType type;
  final String title;
  final String description;
}

class HelpCenterArticleEntity {
  const HelpCenterArticleEntity({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.keywords,
  });

  final String id;
  final String categoryId;
  final String title;
  final String description;
  final List<String> keywords;
}
