/*
1. PAGE NAME
   Help Center Feature Data Models

2. PURPOSE
   Defines local data models for Help Center content.

3. DESCRIPTION
   Converts local data into domain entities without introducing Flutter
   dependencies.

4. UI SECTIONS
   Categories and FAQ articles.

5. NAVIGATION FLOW
   Dummy data → mock data source → models → entities → controller → page.

6. DYNAMIC COMPONENTS
   Category cards and FAQ articles.

7. FUTURE BACKEND INTEGRATION
   Future: map supported Help Center responses into these models;
   this layer owns external data representation.

8. TECHNOLOGIES USED
   Dart.

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
    Presentation responsibility.

17. EDGE CASES
    Empty keywords and long multilingual content.

18. VALIDATION RULES
    Dummy identifiers remain non-empty.

19. ERROR HANDLING
    Presentation/controller responsibility.

20. LOADING STATE
    Presentation/controller responsibility.

21. EMPTY STATE
    Presentation/controller responsibility.

22. OFFLINE BEHAVIOUR
    Local dummy content remains available.

23. SECURITY CONSIDERATIONS
    No sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Small immutable models.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify entity conversion and multilingual content.
*/

import '../../domain/entities/help_center_feature_entity.dart';

class HelpCenterCategoryModel {
  const HelpCenterCategoryModel({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
  });

  final String id;
  final HelpCenterCategoryType type;
  final String title;
  final String description;

  HelpCenterCategoryEntity toEntity() {
    return HelpCenterCategoryEntity(
      id: id,
      type: type,
      title: title,
      description: description,
    );
  }
}

class HelpCenterArticleModel {
  const HelpCenterArticleModel({
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

  HelpCenterArticleEntity toEntity() {
    return HelpCenterArticleEntity(
      id: id,
      categoryId: categoryId,
      title: title,
      description: description,
      keywords: List<String>.unmodifiable(keywords),
    );
  }
}