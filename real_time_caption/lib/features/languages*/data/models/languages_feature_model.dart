/*
1. PAGE NAME
   Languages Feature Data Model

2. PURPOSE
   Provides the data-layer representation of a LinguaLive language.

3. DESCRIPTION
   Converts language information into the domain entity consumed by
   the presentation layer.

4. UI SECTIONS
   Used by all language-selection sections.

5. NAVIGATION FLOW
   Mock data source → model → entity → controller → LanguagesPage.

6. DYNAMIC COMPONENTS
   Language tiles and source/target language pair.

7. FUTURE BACKEND INTEGRATION
   Future API/remote language catalog responses can be mapped here.

8. TECHNOLOGIES USED
   Pure Dart.

9. REQUIRED DATA MODELS
   LanguageFeatureModel and LanguageFeatureEntity.

10. FUTURE API ENDPOINTS
    Not implemented.

11. DATABASE COLLECTIONS/TABLES
    Not implemented.

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
    Empty strings and unavailable language resources.

18. VALIDATION RULES
    IDs and language codes should remain stable in production data.

19. ERROR HANDLING
    No remote errors are handled by this model.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Local mock data remains available.

23. SECURITY CONSIDERATIONS
    No sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Immutable model values.

25. WIDGET TREE OVERVIEW
    Model → Entity → UI.

26. COMPLETE TESTING CHECKLIST
    Verify mapping preserves every language property.
*/

import '../../domain/entities/languages_feature_entity.dart';

class LanguageFeatureModel {
  const LanguageFeatureModel({
    required this.id,
    required this.name,
    required this.nativeName,
    required this.code,
    required this.region,
    required this.available,
    required this.isPreferred,
    required this.isRecent,
  });

  final String id;
  final String name;
  final String nativeName;
  final String code;
  final String region;
  final bool available;
  final bool isPreferred;
  final bool isRecent;

  LanguageFeatureEntity toEntity() {
    return LanguageFeatureEntity(
      id: id,
      name: name,
      nativeName: nativeName,
      code: code,
      region: region,
      available: available,
      isPreferred: isPreferred,
      isRecent: isRecent,
    );
  }
}
