/*
1. PAGE NAME
   Splash Feature Model

2. PURPOSE
   Defines the local data model used by the Splash presentation.

3. DESCRIPTION
   Stores branding and loading information required by the UI.

4. UI SECTIONS
   Branding and loading indicator.

5. NAVIGATION FLOW
   Splash data → Splash presentation → future startup destination.

6. DYNAMIC COMPONENTS
   Application name, tagline, and loading label.

7. FUTURE BACKEND INTEGRATION
   None. The current model intentionally contains only local presentation data.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   SplashFeatureModel.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None; colors remain presentation concerns.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Text values are suitable for semantic presentation.

17. EDGE CASES
    Empty strings are avoided in supplied dummy data.

18. VALIDATION RULES
    Branding values must be non-empty for production presentation.

19. ERROR HANDLING
    No service operations are performed.

20. LOADING STATE
    Represented through loadingLabel.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Fully local.

23. SECURITY CONSIDERATIONS
    Contains no sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Immutable final fields.

25. WIDGET TREE OVERVIEW
    Model → Splash entity → Splash widgets.

26. COMPLETE TESTING CHECKLIST
    Validate model mapping and rendering with localization-length variants.
*/

import '../../domain/entities/splash_feature_entity.dart';

class SplashFeatureModel {
  const SplashFeatureModel({
    required this.appName,
    required this.tagline,
    required this.loadingLabel,
  });

  final String appName;
  final String tagline;
  final String loadingLabel;

  SplashFeatureEntity toEntity() {
    return SplashFeatureEntity(
      appName: appName,
      tagline: tagline,
      loadingLabel: loadingLabel,
    );
  }
}
