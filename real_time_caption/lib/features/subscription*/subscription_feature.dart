/*
1. PAGE NAME
   Subscription Feature Entry

2. PURPOSE
   Provides the public entry point for the LinguaLive Subscription feature.

3. DESCRIPTION
   Exports the subscription presentation page so the feature can be integrated
   into the existing application router without exposing internal implementation
   details.

4. UI SECTIONS
   Not applicable. This is a feature barrel/entry file.

5. NAVIGATION FLOW
   Existing application navigation → SubscriptionPage.

6. DYNAMIC COMPONENTS
   SubscriptionPage manages its local dummy subscription presentation state.

7. FUTURE BACKEND INTEGRATION
   The page will eventually receive subscription status and available plans from
   the application's subscription domain/data layer.

8. TECHNOLOGIES USED
   Dart and Flutter.

9. REQUIRED DATA MODELS
   SubscriptionPlanEntity and SubscriptionPlanModel.

10. FUTURE API ENDPOINTS
    Not defined by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not defined by the supplied project documentation.

12. REQUIRED ASSETS
    None required.

13. REQUIRED ICONS
    Material Icons used by the presentation layer.

14. THEME COLORS
    Uses the application's Material 3 ColorScheme.

15. ANIMATIONS
    Lightweight implicit selection animation is implemented by plan cards.

16. ACCESSIBILITY
    Presentation widgets provide semantic labels and readable status text.

17. EDGE CASES
    Empty, error, loading, offline, and long plan content are represented locally.

18. VALIDATION RULES
    A plan must have a non-empty identifier and display name.

19. ERROR HANDLING
    UI-only local error representation.

20. LOADING STATE
    UI-only local loading representation.

21. EMPTY STATE
    UI-only local empty representation.

22. OFFLINE BEHAVIOUR
    UI-only offline representation; no network state is detected.

23. SECURITY CONSIDERATIONS
    No payment, account, authentication, or subscription data is processed here.

24. PERFORMANCE OPTIMIZATIONS
    Immutable dummy data and small private presentation widgets.

25. WIDGET TREE OVERVIEW
    SubscriptionPage
      → Header
      → Current status
      → Billing selector
      → Plan cards
      → Benefits
      → Disclaimer

26. COMPLETE TESTING CHECKLIST
    See the screen-level checklist supplied with this feature.
*/

export 'presentation/pages/subscription_page.dart';
