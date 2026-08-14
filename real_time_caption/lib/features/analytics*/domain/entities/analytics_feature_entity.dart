/*
1. PAGE NAME
   Analytics Feature Domain Entities

2. PURPOSE
   Defines immutable domain-level objects used by LinguaLive Analytics.

3. DESCRIPTION
   Contains pure Dart entities without Flutter or infrastructure dependencies.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Analytics presentation → domain entities.

6. DYNAMIC COMPONENTS
   Summary metrics, usage trend, language usage, sessions, translations.

7. FUTURE BACKEND INTEGRATION
   Repository implementations can map API/database models into these
   domain entities.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   AnalyticsMetricEntity, UsagePointEntity, LanguageUsageEntity,
   SessionAnalyticsEntity, TranslationAnalyticsEntity.

10. FUTURE API ENDPOINTS
    Not defined at this UI stage.

11. DATABASE COLLECTIONS/TABLES
    None at this UI stage.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None; IconData belongs to presentation.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Handled by presentation widgets.

17. EDGE CASES
    Zero values, empty collections, multilingual strings, and long names.

18. VALIDATION RULES
    Identifiers and labels should be meaningful non-empty values.

19. ERROR HANDLING
    Handled by data/presentation layers.

20. LOADING STATE
    Handled by presentation.

21. EMPTY STATE
    Handled by presentation.

22. OFFLINE BEHAVIOUR
    Represented by presentation state.

23. SECURITY CONSIDERATIONS
    No sensitive credentials or private storage.

24. PERFORMANCE OPTIMIZATIONS
    Immutable const-compatible entities.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Construction, zero values, multilingual labels, empty collections,
    and immutable field access.
*/

enum AnalyticsViewState { loading, success, empty, error, offline }

class AnalyticsMetricEntity {
  final String id;
  final String label;
  final String value;
  final String changeLabel;
  final bool positive;
  final String description;

  const AnalyticsMetricEntity({
    required this.id,
    required this.label,
    required this.value,
    required this.changeLabel,
    required this.positive,
    required this.description,
  });
}

class UsagePointEntity {
  final String label;
  final double value;

  const UsagePointEntity({required this.label, required this.value});
}

class LanguageUsageEntity {
  final String languageCode;
  final String languageName;
  final String nativeName;
  final int sessions;
  final double percentage;

  const LanguageUsageEntity({
    required this.languageCode,
    required this.languageName,
    required this.nativeName,
    required this.sessions,
    required this.percentage,
  });
}

class SessionAnalyticsEntity {
  final int totalSessions;
  final int completedSessions;
  final int averageMinutes;
  final String mostUsedPair;

  const SessionAnalyticsEntity({
    required this.totalSessions,
    required this.completedSessions,
    required this.averageMinutes,
    required this.mostUsedPair,
  });
}

class TranslationAnalyticsEntity {
  final int translatedWords;
  final int translatedSegments;
  final double averageConfidence;
  final String mostActiveLanguage;

  const TranslationAnalyticsEntity({
    required this.translatedWords,
    required this.translatedSegments,
    required this.averageConfidence,
    required this.mostActiveLanguage,
  });
}

class AnalyticsFeatureEntity {
  final List<AnalyticsMetricEntity> metrics;
  final List<UsagePointEntity> usagePoints;
  final List<LanguageUsageEntity> languages;
  final SessionAnalyticsEntity sessions;
  final TranslationAnalyticsEntity translations;

  const AnalyticsFeatureEntity({
    required this.metrics,
    required this.usagePoints,
    required this.languages,
    required this.sessions,
    required this.translations,
  });
}
