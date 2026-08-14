/*
1. PAGE NAME
   Subscription Dummy Data

2. PURPOSE
   Supplies realistic local subscription plans for UI development.

3. DESCRIPTION
   Contains no networking, payment processing, persistence, or account logic.

4. UI SECTIONS
   Subscription plans and included multilingual communication capabilities.

5. NAVIGATION FLOW
   Dummy data → mock data source → presentation.

6. DYNAMIC COMPONENTS
   Free, Plus, and Pro plan information.

7. FUTURE BACKEND INTEGRATION
   Future: replace this local catalog with the application's supported
   subscription-plan source when real billing is introduced.

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
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Text is intentionally concise and localizable.

17. EDGE CASES
    Multiple currencies and long feature labels can be introduced later.

18. VALIDATION RULES
    All local plans have valid identifiers and names.

19. ERROR HANDLING
    None required for static local data.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    The source can expose an empty list for UI testing.

22. OFFLINE BEHAVIOUR
    Dummy plans are available without connectivity.

23. SECURITY CONSIDERATIONS
    Contains no sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Constant immutable model instances.

25. WIDGET TREE OVERVIEW
    List<SubscriptionPlanModel> → plan cards.

26. COMPLETE TESTING CHECKLIST
    Validate all plan content at different text scales.
*/

import '../models/subscription_plan_model.dart';

const List<SubscriptionPlanModel> subscriptionDummyPlans = [
  SubscriptionPlanModel(
    id: 'free',
    name: 'Free',
    description: 'Explore multilingual communication essentials.',
    monthlyPrice: 0,
    annualPrice: 0,
    currency: '₹',
    features: [
      'Basic live captions',
      'Selected language pairs',
      'Conversation history preview',
      'Offline-ready interface',
    ],
  ),
  SubscriptionPlanModel(
    id: 'plus',
    name: 'Plus',
    description: 'For frequent conversations across languages.',
    monthlyPrice: 249,
    annualPrice: 1999,
    currency: '₹',
    badge: 'Most popular',
    isPopular: true,
    features: [
      'Extended live translation',
      'More language pairs',
      'Full conversation history',
      'Multilingual chat conversion',
      'Priority feature access',
    ],
  ),
  SubscriptionPlanModel(
    id: 'pro',
    name: 'Pro',
    description: 'For intensive multilingual communication.',
    monthlyPrice: 599,
    annualPrice: 4999,
    currency: '₹',
    badge: 'For power users',
    features: [
      'Advanced live translation',
      'Expanded language coverage',
      'Extended conversation history',
      'Multi-user communication support',
      'Advanced caption experiences',
      'Priority processing experience',
    ],
  ),
];
