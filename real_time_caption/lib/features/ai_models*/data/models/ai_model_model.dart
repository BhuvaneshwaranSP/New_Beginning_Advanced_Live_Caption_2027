/*
1. PAGE NAME
   AI Model Data Model

2. PURPOSE
   Represents AI model catalog data used by the UI-only AI Models feature.

3. DESCRIPTION
   Extends the domain representation with a simple conversion into an
   AiModelEntity.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Mock data source → AiModelModel → AiModelEntity → controller → UI.

6. DYNAMIC COMPONENTS
   Model metadata and display status.

7. FUTURE BACKEND INTEGRATION
   Future API/database response models can replace the local constructor
   without changing the presentation model contract.

8. TECHNOLOGIES USED
   Pure Dart.

9. REQUIRED DATA MODELS
   AiModelModel and AiModelEntity.

10. FUTURE API ENDPOINTS
   Not defined.

11. DATABASE COLLECTIONS/TABLES
   Not defined.

12. REQUIRED ASSETS
   None.

13. REQUIRED ICONS
   None.

14. THEME COLORS
   None.

15. ANIMATIONS
   None.

16. ACCESSIBILITY
   Presentation layer exposes model metadata through accessible widgets.

17. EDGE CASES
   Empty language collections are supported.

18. VALIDATION RULES
   Required fields are non-null.

19. ERROR HANDLING
   Data source errors are represented by the presentation state.

20. LOADING STATE
   Managed by the controller.

21. EMPTY STATE
   Managed by the controller/page.

22. OFFLINE BEHAVIOUR
   Offline readiness is represented by model metadata.

23. SECURITY CONSIDERATIONS
   No secrets or credentials are contained in this model.

24. PERFORMANCE OPTIMIZATIONS
   Immutable model fields and lightweight conversion.

25. WIDGET TREE OVERVIEW
   Not applicable.

26. COMPLETE TESTING CHECKLIST
   Verify entity conversion and preservation of all model metadata.
*/

import '../../domain/entities/ai_model_entity.dart';

class AiModelModel {
  const AiModelModel({
    required this.id,
    required this.name,
    required this.family,
    required this.description,
    required this.category,
    required this.status,
    required this.languages,
    required this.primaryUse,
    required this.performanceLabel,
    required this.isRecommended,
    required this.isOfflineReady,
  });

  final String id;
  final String name;
  final String family;
  final String description;
  final AiModelCategory category;
  final AiModelStatus status;
  final List<String> languages;
  final String primaryUse;
  final String performanceLabel;
  final bool isRecommended;
  final bool isOfflineReady;

  AiModelEntity toEntity() {
    return AiModelEntity(
      id: id,
      name: name,
      family: family,
      description: description,
      category: category,
      status: status,
      languages: List.unmodifiable(languages),
      primaryUse: primaryUse,
      performanceLabel: performanceLabel,
      isRecommended: isRecommended,
      isOfflineReady: isOfflineReady,
    );
  }
}
