/*
1. PAGE NAME
   Analytics Feature Data Models

2. PURPOSE
   Represents analytics data at the data layer.

3. DESCRIPTION
   These models are intentionally local and dependency-free for the
   current UI-only implementation.

4. UI SECTIONS
   Summary, usage chart, language usage, sessions, translations.

5. NAVIGATION FLOW
   Mock data source → models → controller → presentation.

6. DYNAMIC COMPONENTS
   All analytics values displayed by the screen.

7. FUTURE BACKEND INTEGRATION
   API responses can later be deserialized into these models before
   being mapped to domain entities.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   All model classes in this file.

10. FUTURE API ENDPOINTS
    Not specified.

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
    Presentation responsibility.

17. EDGE CASES
    Empty arrays and zero-valued analytics.

18. VALIDATION RULES
    Values should remain valid for presentation.

19. ERROR HANDLING
    Data source responsibility.

20. LOADING STATE
    Controller responsibility.

21. EMPTY STATE
    Controller/presentation responsibility.

22. OFFLINE BEHAVIOUR
    Controller/presentation responsibility.

23. SECURITY CONSIDERATIONS
    No credentials or private data.

24. PERFORMANCE OPTIMIZATIONS
    Simple immutable model objects.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Model construction, mapping, zero values, empty lists,
    and multilingual content.
*/

import '../../domain/entities/analytics_feature_entity.dart';

class AnalyticsMetricModel {
  final String id;
  final String label;
  final String value;
  final String changeLabel;
  final bool positive;
  final String description;

  const AnalyticsMetricModel({
    required this.id,
    required this.label,
    required this.value,
    required this.changeLabel,
    required this.positive,
    required this.description,
  });

  AnalyticsMetricEntity toEntity() {
    return AnalyticsMetricEntity(
      id: id,
      label: label,
      value: value,
      changeLabel: changeLabel,
      positive: positive,
      description: description,
    );
  }
}

class UsagePointModel {
  final String label;
  final double value;

  const UsagePointModel({required this.label, required this.value});

  UsagePointEntity toEntity() {
    return UsagePointEntity(label: label, value: value);
  }
}

class LanguageUsageModel {
  final String languageCode;
  final String languageName;
  final String nativeName;
  final int sessions;
  final double percentage;

  const LanguageUsageModel({
    required this.languageCode,
    required this.languageName,
    required this.nativeName,
    required this.sessions,
    required this.percentage,
  });

  LanguageUsageEntity toEntity() {
    return LanguageUsageEntity(
      languageCode: languageCode,
      languageName: languageName,
      nativeName: nativeName,
      sessions: sessions,
      percentage: percentage,
    );
  }
}

class SessionAnalyticsModel {
  final int totalSessions;
  final int completedSessions;
  final int averageMinutes;
  final String mostUsedPair;

  const SessionAnalyticsModel({
    required this.totalSessions,
    required this.completedSessions,
    required this.averageMinutes,
    required this.mostUsedPair,
  });

  SessionAnalyticsEntity toEntity() {
    return SessionAnalyticsEntity(
      totalSessions: totalSessions,
      completedSessions: completedSessions,
      averageMinutes: averageMinutes,
      mostUsedPair: mostUsedPair,
    );
  }
}

class TranslationAnalyticsModel {
  final int translatedWords;
  final int translatedSegments;
  final double averageConfidence;
  final String mostActiveLanguage;

  const TranslationAnalyticsModel({
    required this.translatedWords,
    required this.translatedSegments,
    required this.averageConfidence,
    required this.mostActiveLanguage,
  });

  TranslationAnalyticsEntity toEntity() {
    return TranslationAnalyticsEntity(
      translatedWords: translatedWords,
      translatedSegments: translatedSegments,
      averageConfidence: averageConfidence,
      mostActiveLanguage: mostActiveLanguage,
    );
  }
}

class AnalyticsFeatureModel {
  final List<AnalyticsMetricModel> metrics;
  final List<UsagePointModel> usagePoints;
  final List<LanguageUsageModel> languages;
  final SessionAnalyticsModel sessions;
  final TranslationAnalyticsModel translations;

  const AnalyticsFeatureModel({
    required this.metrics,
    required this.usagePoints,
    required this.languages,
    required this.sessions,
    required this.translations,
  });

  AnalyticsFeatureEntity toEntity() {
    return AnalyticsFeatureEntity(
      metrics: metrics.map((item) => item.toEntity()).toList(growable: false),
      usagePoints: usagePoints
          .map((item) => item.toEntity())
          .toList(growable: false),
      languages: languages
          .map((item) => item.toEntity())
          .toList(growable: false),
      sessions: sessions.toEntity(),
      translations: translations.toEntity(),
    );
  }
}
