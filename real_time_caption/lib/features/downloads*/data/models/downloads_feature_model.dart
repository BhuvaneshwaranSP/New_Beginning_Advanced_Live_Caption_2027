/*
1. PAGE NAME
   Downloads Feature Data Model

2. PURPOSE
   Represents local UI data used by the Downloads feature.

3. DESCRIPTION
   Contains a serializable-style data object for downloaded multilingual
   resources. No serialization or persistence is implemented.

4. UI SECTIONS
   Download item cards and summary information.

5. NAVIGATION FLOW
   Mock data source → model → presentation.

6. DYNAMIC COMPONENTS
   File name, language pair, type, size, progress, and status.

7. FUTURE BACKEND INTEGRATION
   Future: map persisted download metadata into this model; the model is the
   presentation-facing data contract for downloaded resources.

8. TECHNOLOGIES USED
   Dart.

9. REQUIRED DATA MODELS
   DownloadsFeatureModel.

10. FUTURE API ENDPOINTS
    Not specified by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified for Downloads by the supplied project documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Determined by the presentation layer.

14. THEME COLORS
    None; presentation determines colors from ThemeData.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    String fields are exposed to presentation semantics.

17. EDGE CASES
    Zero-byte size, failed status, empty metadata, and multilingual filenames.

18. VALIDATION RULES
    Model accepts already-prepared local values.

19. ERROR HANDLING
    Status can represent an error state.

20. LOADING STATE
    Status can represent downloading/processing.

21. EMPTY STATE
    Represented by an empty model collection rather than a special model.

22. OFFLINE BEHAVIOUR
    Offline availability is represented through status metadata.

23. SECURITY CONSIDERATIONS
    No file contents or credentials are stored here.

24. PERFORMANCE OPTIMIZATIONS
    Immutable fields.

25. WIDGET TREE OVERVIEW
    Model → DownloadItemCard.

26. COMPLETE TESTING CHECKLIST
    Validate all fields with normal, empty, long, and multilingual values.
*/

import '../../domain/entities/downloads_feature_entity.dart';

enum DownloadItemStatus { completed, downloading, paused, failed }

enum DownloadItemType { languagePack, transcript, conversation, audio }

class DownloadsFeatureModel {
  const DownloadsFeatureModel({
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

  DownloadsFeatureEntity toEntity() {
    return DownloadsFeatureEntity(
      id: id,
      title: title,
      sourceLanguage: sourceLanguage,
      targetLanguage: targetLanguage,
      type: type,
      sizeLabel: sizeLabel,
      updatedLabel: updatedLabel,
      status: status,
      progress: progress,
      isAvailableOffline: isAvailableOffline,
    );
  }
}
