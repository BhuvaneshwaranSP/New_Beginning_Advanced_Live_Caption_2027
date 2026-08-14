/*
1. PAGE NAME
   Mock Onboarding Data Source

2. PURPOSE
   Provides local onboarding data without implementing backend functionality.

3. DESCRIPTION
   Returns the deterministic supported-language collection used by the UI.

4. UI SECTIONS
   Language selection.

5. NAVIGATION FLOW
   Mock source → controller → onboarding page.

6. DYNAMIC COMPONENTS
   Supported language list.

7. FUTURE BACKEND INTEGRATION
   Future: replace this local source with the project's supported-language
   configuration provider when language capabilities are loaded dynamically.

8. TECHNOLOGIES USED
   Dart.

9. REQUIRED DATA MODELS
   OnboardingLanguageModel.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    None specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Data includes readable names and native names.

17. EDGE CASES
    Empty data collection is supported by the return type.

18. VALIDATION RULES
    Returned records originate from compile-time dummy data.

19. ERROR HANDLING
    No remote failure can occur in this UI-only implementation.

20. LOADING STATE
    Not required.

21. EMPTY STATE
    The presentation layer can display its empty state if this collection is
    intentionally replaced with an empty local source.

22. OFFLINE BEHAVIOUR
    Fully local.

23. SECURITY CONSIDERATIONS
    No sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Returns an existing immutable list.

25. WIDGET TREE OVERVIEW
    Source → controller → page.

26. COMPLETE TESTING CHECKLIST
    Verify language records are available and correctly mapped.
*/

import '../dummy/onboarding_dummy_data.dart';
import '../models/onboarding_feature_model.dart';

class MockOnboardingDataSource {
  const MockOnboardingDataSource();

  List<OnboardingLanguageModel> getLanguages() {
    return onboardingLanguages;
  }
}
