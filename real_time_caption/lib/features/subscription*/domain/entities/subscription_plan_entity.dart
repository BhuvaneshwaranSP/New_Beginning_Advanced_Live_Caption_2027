/*
1. PAGE NAME
   Subscription Plan Entity

2. PURPOSE
   Defines the domain-level representation of a LinguaLive subscription plan.

3. DESCRIPTION
   Pure Dart immutable entity without Flutter or infrastructure dependencies.

4. UI SECTIONS
   Represents data displayed by plan cards and comparison sections.

5. NAVIGATION FLOW
   Data model → domain entity → presentation.

6. DYNAMIC COMPONENTS
   Plan identity, pricing, badge, popularity, and features.

7. FUTURE BACKEND INTEGRATION
   Future: receive validated subscription information from the domain
   repository once billing infrastructure is implemented.

8. TECHNOLOGIES USED
   Dart.

9. REQUIRED DATA MODELS
   SubscriptionPlanModel maps to SubscriptionPlanEntity.

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
    Presentation layer converts entity values into accessible labels.

17. EDGE CASES
    Empty feature collections are supported.

18. VALIDATION RULES
    Plan id and name should be non-empty.

19. ERROR HANDLING
    No infrastructure handling belongs here.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Entity itself is independent of connectivity.

23. SECURITY CONSIDERATIONS
    No sensitive payment information.

24. PERFORMANCE OPTIMIZATIONS
    Immutable values and unmodifiable feature lists.

25. WIDGET TREE OVERVIEW
    Entity → SubscriptionController → SubscriptionPage.

26. COMPLETE TESTING CHECKLIST
    Validate all entity fields and plan selection identity.
*/

class SubscriptionPlanEntity {
  const SubscriptionPlanEntity({
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
