/*
1. PAGE NAME
   Downloads Feature Domain Entity

2. PURPOSE
   Defines the immutable domain representation of a Downloads item.

3. DESCRIPTION
   Pure Dart entity with no Flutter or infrastructure dependency.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Data model → domain entity → presentation.

6. DYNAMIC COMPONENTS
   Download metadata and status.

7. FUTURE BACKEND INTEGRATION
   Future: use this entity as the stable domain representation when local
   storage or download services are integrated.

8. TECHNOLOGIES USED
   Dart.

9. REQUIRED DATA MODELS
   DownloadsFeatureEntity.

10. FUTURE API ENDPOINTS
    Not specified.

11. DATABASE COLLECTIONS/TABLES
    Not specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Presentation responsibility.

17. EDGE CASES
    Status and progress values can represent incomplete resources.

18. VALIDATION RULES
    Immutable values supplied by the data layer.

19. ERROR HANDLING
    Status enum represents failed state.

20. LOADING STATE
    Status enum represents downloading state.

21. EMPTY STATE
    Collection-level state.

22. OFFLINE BEHAVIOUR
    isAvailableOffline indicates local availability.

23. SECURITY CONSIDERATIONS
    Contains metadata only.

24. PERFORMANCE OPTIMIZATIONS
    Immutable entity.

25. WIDGET TREE OVERVIEW
    Entity → model/presentation.

26. COMPLETE TESTING CHECKLIST
    Verify all enum values and progress boundaries.
*/

import '../../data/models/downloads_feature_model.dart';

class DownloadsFeatureEntity {
  const DownloadsFeatureEntity({
    required this.id,
    required this.title,
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.type,
    required this.sizeLabel,
    required this.updatedLabel,
    required this.status,
    required this.progress,
    required this.isAvailableOffline,
  });

  final String id;
  final String title;
  final String sourceLanguage;
  final String targetLanguage;
  final DownloadItemType type;
  final String sizeLabel;
  final String updatedLabel;
  final DownloadItemStatus status;
  final double progress;
  final bool isAvailableOffline;
}
