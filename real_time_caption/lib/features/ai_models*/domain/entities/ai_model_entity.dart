/*
1. PAGE NAME
   AI Model Domain Entity

2. PURPOSE
   Defines the immutable domain object representing an AI model used by
   LinguaLive's multilingual communication pipeline.

3. DESCRIPTION
   Contains pure Dart data without Flutter or infrastructure dependencies.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   AI Models data → domain entity → presentation.

6. DYNAMIC COMPONENTS
   Model name, family, purpose, capability, status, language support,
   performance label, and recommended state.

7. FUTURE BACKEND INTEGRATION
   Future model metadata sources can map their responses into this entity
   before the presentation layer consumes them.

8. TECHNOLOGIES USED
   Pure Dart.

9. REQUIRED DATA MODELS
   AiModelEntity.

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
   Text values are exposed directly to the presentation layer.

17. EDGE CASES
   Empty language lists and unavailable status are supported.

18. VALIDATION RULES
   Required descriptive fields are non-null.

19. ERROR HANDLING
   Not applicable to a pure entity.

20. LOADING STATE
   Not applicable.

21. EMPTY STATE
   Not applicable.

22. OFFLINE BEHAVIOUR
   Model status can represent offline availability.

23. SECURITY CONSIDERATIONS
   No credentials or private model configuration are stored.

24. PERFORMANCE OPTIMIZATIONS
   Immutable final fields avoid unnecessary mutation.

25. WIDGET TREE OVERVIEW
   Not applicable.

26. COMPLETE TESTING CHECKLIST
   Verify immutability, null safety, enum values, and empty language support.
*/

enum AiModelCategory {
  speechRecognition,
  translation,
  contextualLanguage,
  textToSpeech,
  runtime,
  optimization,
}

enum AiModelStatus { active, available, offlineReady, processing, unavailable }

class AiModelEntity {
  const AiModelEntity({
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
}
