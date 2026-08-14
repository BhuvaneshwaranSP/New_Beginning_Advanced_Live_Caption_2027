/*
1. PAGE NAME
   Profile Feature Data Model

2. PURPOSE
   Represents local profile data used by the UI-only Profile feature.

3. DESCRIPTION
   Provides a serializable-style data structure and conversion into the
   domain entity without requiring external serialization packages.

4. UI SECTIONS
   Supplies data for the profile header and language preference card.

5. NAVIGATION FLOW
   Mock data source → ProfileFeatureModel → ProfileFeatureEntity → UI.

6. DYNAMIC COMPONENTS
   Profile identity and language preference values.

7. FUTURE BACKEND INTEGRATION
   Future profile/account responses can be mapped into this model at the
   data-source boundary.

8. TECHNOLOGIES USED
   Pure Dart.

9. REQUIRED DATA MODELS
   ProfileFeatureModel and ProfileFeatureEntity.

10. FUTURE API ENDPOINTS
    Not specified by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified by the supplied project documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    Not applicable.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Presentation responsibility.

17. EDGE CASES
    Empty strings remain safely representable.

18. VALIDATION RULES
    No server-side validation is implemented.

19. ERROR HANDLING
    Data-source errors are represented by presentation state only.

20. LOADING STATE
    Not represented in the model.

21. EMPTY STATE
    Empty values are supported.

22. OFFLINE BEHAVIOUR
    Model can be populated entirely from local dummy data.

23. SECURITY CONSIDERATIONS
    Does not contain authentication credentials.

24. PERFORMANCE OPTIMIZATIONS
    Lightweight immutable-style data object.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify mapping and null/empty-safe values.
*/

import '../../domain/entities/profile_feature_entity.dart';

class ProfileFeatureModel {
  const ProfileFeatureModel({
    required this.displayName,
    required this.email,
    required this.preferredLanguage,
    required this.targetLanguage,
    required this.statusLabel,
    required this.initials,
  });

  final String displayName;
  final String email;
  final String preferredLanguage;
  final String targetLanguage;
  final String statusLabel;
  final String initials;

  ProfileFeatureEntity toEntity() {
    return ProfileFeatureEntity(
      displayName: displayName,
      email: email,
      preferredLanguage: preferredLanguage,
      targetLanguage: targetLanguage,
      statusLabel: statusLabel,
      initials: initials,
    );
  }
}
