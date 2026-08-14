/*
1. PAGE NAME
   Subscription Plan Model

2. PURPOSE
   Defines the data-layer representation of a LinguaLive subscription plan.

3. DESCRIPTION
   UI-ready local model used by the subscription dummy data source.

4. UI SECTIONS
   Supports subscription plan cards and feature lists.

5. NAVIGATION FLOW
   Dummy data source → model → entity → presentation.

6. DYNAMIC COMPONENTS
   Plan name, description, price, currency, billing label, features, and badge.

7. FUTURE BACKEND INTEGRATION
   Future: map subscription API responses into this model so the presentation
   layer can display server-provided plan information without changing widgets.

8. TECHNOLOGIES USED
   Dart.

9. REQUIRED DATA MODELS
   SubscriptionPlanModel.

10. FUTURE API ENDPOINTS
    Not specified by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified by the supplied project documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    Not stored in the data model.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Text values remain available to semantic presentation widgets.

17. EDGE CASES
    Empty feature lists and zero pricing are supported.

18. VALIDATION RULES
    Identifier and name should be non-empty.

19. ERROR HANDLING
    No infrastructure errors are handled by this model.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Empty plan collections are supported by the data source.

22. OFFLINE BEHAVIOUR
    Local dummy data remains available offline.

23. SECURITY CONSIDERATIONS
    No payment credentials or account secrets are represented.

24. PERFORMANCE OPTIMIZATIONS
    Immutable model fields.

25. WIDGET TREE OVERVIEW
    Model → entity → SubscriptionPlanCard.

26. COMPLETE TESTING CHECKLIST
    Validate mapping and edge-case values.
*/

class SubscriptionPlanModel {
  const SubscriptionPlanModel({
    required this.id,
    required this.name,
    required this.description,
    required this.monthlyPrice,
    required this.annualPrice,
    required this.currency,
    required this.features,
    this.badge,
    this.isPopular = false,
  });

  final String id;
  final String name;
  final String description;
  final double monthlyPrice;
  final double annualPrice;
  final String currency;
  final List<String> features;
  final String? badge;
  final bool isPopular;
}
