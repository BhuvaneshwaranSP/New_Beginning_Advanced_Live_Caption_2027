/*
1. PAGE NAME
   About Feature Mapper

2. PURPOSE
   Converts About data models into domain entities.

3. DESCRIPTION
   Keeps data-layer representations separate from domain-level objects.

4. UI SECTIONS
   Not directly applicable.

5. NAVIGATION FLOW
   About model → mapper → About entity → presentation.

6. DYNAMIC COMPONENTS
   Capabilities, communication modes, and technologies.

7. FUTURE BACKEND INTEGRATION
   Any future structured data source can be mapped into the same domain
   entity contract here.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   AboutFeatureModel and nested model classes.

10. FUTURE API ENDPOINTS
    None at this UI stage.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Handled by presentation.

17. EDGE CASES
    Empty nested collections and multilingual text.

18. VALIDATION RULES
    Mapping preserves all supplied model values.

19. ERROR HANDLING
    No external errors are introduced by this pure conversion.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Empty model collections become empty entity collections.

22. OFFLINE BEHAVIOUR
    Mapping works with local data without connectivity.

23. SECURITY CONSIDERATIONS
    No sensitive values are processed.

24. PERFORMANCE OPTIMIZATIONS
    Straightforward O(n) collection mapping.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify every model field maps correctly, nested collections remain
    ordered, multilingual content is preserved, and empty collections
    remain safe.
*/

import '../../domain/entities/about_feature_entity.dart';
import '../models/about_feature_model.dart';

class AboutFeatureMapper {
  const AboutFeatureMapper();

  AboutFeatureEntity toEntity(AboutFeatureModel model) {
    return AboutFeatureEntity(
      appName: model.appName,
      version: model.version,
      description: model.description,
      mission: model.mission,
      capabilities: model.capabilities
          .map(
            (item) => AboutCapabilityEntity(
              title: item.title,
              description: item.description,
            ),
          )
          .toList(growable: false),
      communicationModes: model.communicationModes
          .map(
            (item) => AboutModeEntity(
              title: item.title,
              description: item.description,
            ),
          )
          .toList(growable: false),
      technologies: model.technologies
          .map(
            (item) => AboutTechnologyEntity(name: item.name, role: item.role),
          )
          .toList(growable: false),
    );
  }
}
