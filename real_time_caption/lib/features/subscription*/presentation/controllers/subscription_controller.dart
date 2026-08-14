/*
1. PAGE NAME
   Subscription Controller

2. PURPOSE
   Provides lightweight local presentation preparation for the Subscription page.

3. DESCRIPTION
   This controller intentionally contains no external state-management package,
   backend calls, payment processing, persistence, or networking.

4. UI SECTIONS
   Subscription plan catalog.

5. NAVIGATION FLOW
   SubscriptionPage → SubscriptionController → local data source.

6. DYNAMIC COMPONENTS
   Plan collection and current dummy plan.

7. FUTURE BACKEND INTEGRATION
   Future: load the user's actual subscription status and available plans here
   when the supported subscription service is integrated.

8. TECHNOLOGIES USED
   Dart.

9. REQUIRED DATA MODELS
   SubscriptionPlanModel and SubscriptionPlanEntity.

10. FUTURE API ENDPOINTS
    Not specified by supplied documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified by supplied documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Presentation widgets handle semantics.

17. EDGE CASES
    Empty plan catalog is supported.

18. VALIDATION RULES
    Plans with valid identifiers are selected.

19. ERROR HANDLING
    UI state is handled by the page.

20. LOADING STATE
    UI-only page state.

21. EMPTY STATE
    UI-only page state.

22. OFFLINE BEHAVIOUR
    Local data remains available.

23. SECURITY CONSIDERATIONS
    No credentials or payment information.

24. PERFORMANCE OPTIMIZATIONS
    Conversion happens once when the page initializes.

25. WIDGET TREE OVERVIEW
    Controller → entities → presentation widgets.

26. COMPLETE TESTING CHECKLIST
    Validate entity conversion and selected-plan lookup.
*/

import '../../data/data_sources/mock_subscription_data_source.dart';
import '../../domain/entities/subscription_plan_entity.dart';

class SubscriptionController {
  SubscriptionController({MockSubscriptionDataSource? dataSource})
    : _dataSource = dataSource ?? const MockSubscriptionDataSource();

  final MockSubscriptionDataSource _dataSource;

  List<SubscriptionPlanEntity> loadPlans() {
    return _dataSource
        .getPlans()
        .map(
          (model) => SubscriptionPlanEntity(
            id: model.id,
            name: model.name,
            description: model.description,
            monthlyPrice: model.monthlyPrice,
            annualPrice: model.annualPrice,
            currency: model.currency,
            features: List.unmodifiable(model.features),
            badge: model.badge,
            isPopular: model.isPopular,
          ),
        )
        .toList(growable: false);
  }
}
