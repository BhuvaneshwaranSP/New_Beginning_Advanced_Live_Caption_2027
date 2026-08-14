/*
1. PAGE NAME
   History Feature Data Model

2. PURPOSE
   Provides the data-layer representation of a history session.

3. DESCRIPTION
   Converts dummy/local data into the pure HistoryFeatureEntity used by
   the presentation layer.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Mock data source → HistoryFeatureModel → HistoryFeatureEntity → UI.

6. DYNAMIC COMPONENTS
   Session metadata, language pair, participant information, status,
   duration, timestamp, and transcript preview.

7. FUTURE BACKEND INTEGRATION
   Backend DTOs or local persistence models can later be mapped into
   this model before conversion to the domain entity.

8. TECHNOLOGIES USED
   Dart.

9. REQUIRED DATA MODELS
   HistoryFeatureModel and HistoryFeatureEntity.

10. FUTURE API ENDPOINTS
    No endpoint is implemented.

11. DATABASE COLLECTIONS/TABLES
    No database is implemented.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Presentation receives readable labels from the entity.

17. EDGE CASES
    Empty participant labels and interrupted/offline sessions.

18. VALIDATION RULES
    Required display fields are initialized through the constructor.

19. ERROR HANDLING
    No external parsing is performed.

20. LOADING STATE
    Not represented here.

21. EMPTY STATE
    Not represented here.

22. OFFLINE BEHAVIOUR
    Offline sessions can be represented through status.

23. SECURITY CONSIDERATIONS
    Dummy content only.

24. PERFORMANCE OPTIMIZATIONS
    Immutable fields and direct mapping.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Verify every model field maps correctly into its domain entity.
*/

import '../../domain/entities/history_feature_entity.dart';

class HistoryFeatureModel {
  const HistoryFeatureModel({
    required this.id,
    required this.title,
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.sourceLanguageCode,
    required this.targetLanguageCode,
    required this.participantLabel,
    required this.preview,
    required this.durationLabel,
    required this.dateLabel,
    required this.timeLabel,
    required this.type,
    required this.status,
    required this.messageCount,
  });

  final String id;
  final String title;
  final String sourceLanguage;
  final String targetLanguage;
  final String sourceLanguageCode;
  final String targetLanguageCode;
  final String participantLabel;
  final String preview;
  final String durationLabel;
  final String dateLabel;
  final String timeLabel;
  final HistorySessionType type;
  final HistorySessionStatus status;
  final int messageCount;

  HistoryFeatureEntity toEntity() {
    return HistoryFeatureEntity(
      id: id,
      title: title,
      sourceLanguage: sourceLanguage,
      targetLanguage: targetLanguage,
      sourceLanguageCode: sourceLanguageCode,
      targetLanguageCode: targetLanguageCode,
      participantLabel: participantLabel,
      preview: preview,
      durationLabel: durationLabel,
      dateLabel: dateLabel,
      timeLabel: timeLabel,
      type: type,
      status: status,
      messageCount: messageCount,
    );
  }
}
