/*
1. PAGE NAME
   Mock Subscription Data Source

2. PURPOSE
   Supplies local subscription data to the Subscription feature.

3. DESCRIPTION
   UI-only data source with no API, database, authentication, payment,
   networking, or persistence functionality.

4. UI SECTIONS
   Subscription plan catalog and current subscription preview.

5. NAVIGATION FLOW
   SubscriptionPage → mock data source → dummy models.

6. DYNAMIC COMPONENTS
   Subscription plans.

7. FUTURE BACKEND INTEGRATION
   Future: replace the local catalog retrieval here with the supported
   subscription service so the presentation layer remains independent
   of transport details.

8. TECHNOLOGIES USED
   Dart.

9. REQUIRED DATA MODELS
   SubscriptionPlanModel.

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
    Handled by presentation widgets.

17. EDGE CASES
    Empty catalog is supported.

18. VALIDATION RULES
    No external validation is performed.

19. ERROR HANDLING
    Presentation provides local error representation.

20. LOADING STATE
    Presentation provides local loading representation.

21. EMPTY STATE
    Empty catalog can be represented by an empty list.

22. OFFLINE BEHAVIOUR
    Local dummy catalog remains available.

23. SECURITY CONSIDERATIONS
    No sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Returns immutable local data.

25. WIDGET TREE OVERVIEW
    Data source → model collection → entity collection.

26. COMPLETE TESTING CHECKLIST
    Validate non-empty and empty source states.
*/

import '../dummy/subscription_dummy_data.dart';
import '../models/subscription_plan_model.dart';

class MockSubscriptionDataSource {
  const MockSubscriptionDataSource();

  List<SubscriptionPlanModel> getPlans() {
    return subscriptionDummyPlans;
  }
}
