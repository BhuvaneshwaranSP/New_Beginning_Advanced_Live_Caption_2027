/*
1. PAGE NAME
   Home Feature Data Models

2. PURPOSE
   Provides data-layer representations for Home feature dummy content.

3. DESCRIPTION
   Converts data objects into domain entities without introducing backend
   functionality.

4. UI SECTIONS
   Supports Home feature cards, language selectors, and recent sessions.

5. NAVIGATION FLOW
   Dummy data source → models → Home presentation.

6. DYNAMIC COMPONENTS
   Language, feature, and recent-session data.

7. FUTURE BACKEND INTEGRATION
   Future: map API/database response objects into these models; this layer
   belongs between external data and the domain layer.

8. TECHNOLOGIES USED
   Dart.

9. REQUIRED DATA MODELS
   LanguageOptionModel, HomeFeatureModel, RecentSessionModel.

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
    Handled by presentation.

17. EDGE CASES
    Long multilingual strings and zero participants.

18. VALIDATION RULES
    Model fields are required.

19. ERROR HANDLING
    Not applicable for local constants.

20. LOADING STATE
    Presentation only.

21. EMPTY STATE
    Presentation only.

22. OFFLINE BEHAVIOUR
    Presentation only.

23. SECURITY CONSIDERATIONS
    No sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Immutable const models.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Model construction and entity conversion.
*/

import '../../domain/entities/home_feature_entity.dart';

class LanguageOptionModel {
  final String code;
  final String name;
  final String nativeName;

  const LanguageOptionModel({
    required this.code,
    required this.name,
    required this.nativeName,
  });

  LanguageOptionEntity toEntity() {
    return LanguageOptionEntity(code: code, name: name, nativeName: nativeName);
  }
}

class HomeFeatureModel {
  final String id;
  final String title;
  final String subtitle;
  final String status;

  const HomeFeatureModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.status,
  });

  HomeFeatureEntity toEntity() {
    return HomeFeatureEntity(
      id: id,
      title: title,
      subtitle: subtitle,
      status: status,
    );
  }
}

class RecentSessionModel {
  final String id;
  final String title;
  final String languagePair;
  final String timeLabel;
  final int participantCount;

  const RecentSessionModel({
    required this.id,
    required this.title,
    required this.languagePair,
    required this.timeLabel,
    required this.participantCount,
  });

  RecentSessionEntity toEntity() {
    return RecentSessionEntity(
      id: id,
      title: title,
      languagePair: languagePair,
      timeLabel: timeLabel,
      participantCount: participantCount,
    );
  }
}
