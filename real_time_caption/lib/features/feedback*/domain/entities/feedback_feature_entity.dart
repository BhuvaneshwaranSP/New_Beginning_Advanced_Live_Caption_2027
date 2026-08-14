/*
1. PAGE NAME
   Feedback Feature Domain Entities

2. PURPOSE
   Defines immutable domain-level objects used by the LinguaLive Feedback feature.

3. DESCRIPTION
   Contains pure Dart entities without Flutter or infrastructure dependencies.

4. UI SECTIONS
   Feedback category metadata.

5. NAVIGATION FLOW
   FeedbackPage → FeedbackController → FeedbackCategoryEntity.

6. DYNAMIC COMPONENTS
   Feedback categories.

7. FUTURE BACKEND INTEGRATION
   Future feedback submission can use this entity when mapping UI selections
   to the application's feedback contract.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   FeedbackCategoryEntity.

10. FUTURE API ENDPOINTS
    Not specified.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Icon identifiers are represented as integer Material icon code points.

14. THEME COLORS
    Not part of the domain entity.

15. ANIMATIONS
    Not applicable.

16. ACCESSIBILITY
    Category title and subtitle are exposed to the presentation layer.

17. EDGE CASES
    Empty category collections are supported.

18. VALIDATION RULES
    Category validation is handled by the controller.

19. ERROR HANDLING
    No infrastructure errors belong in the entity.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Supported by higher presentation layers.

22. OFFLINE BEHAVIOUR
    Entity is independent of connectivity.

23. SECURITY CONSIDERATIONS
    No personal or authentication information is stored.

24. PERFORMANCE OPTIMIZATIONS
    Immutable const entity.

25. WIDGET TREE OVERVIEW
    FeedbackCategoryEntity → FeedbackFeatureModel → controller → widgets.

26. COMPLETE TESTING CHECKLIST
    Verify construction, field values, empty strings, and null-safe usage.
*/

class FeedbackCategoryEntity {
  const FeedbackCategoryEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.iconName,
  });

  final String id;
  final String title;
  final String subtitle;
  final String iconName;
}
