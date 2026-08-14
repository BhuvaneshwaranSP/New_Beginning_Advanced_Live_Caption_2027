/*
1. PAGE NAME
   Home Feature Domain Entities

2. PURPOSE
   Defines immutable domain-level objects used by the LinguaLive Home feature.

3. DESCRIPTION
   Contains pure Dart entities without Flutter or infrastructure dependencies.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Home presentation → domain entities.

6. DYNAMIC COMPONENTS
   Language options, home actions, recent sessions, connection status.

7. FUTURE BACKEND INTEGRATION
   Domain entities can later receive data mapped from repository models.

8. TECHNOLOGIES USED
   Dart only.

9. REQUIRED DATA MODELS
   LanguageOptionEntity, HomeFeatureEntity, RecentSessionEntity.

10. FUTURE API ENDPOINTS
    None at this UI stage.

11. DATABASE COLLECTIONS/TABLES
    None at this UI stage.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None; IconData remains outside the domain layer.

14. THEME COLORS
    None.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Handled by presentation widgets.

17. EDGE CASES
    Long names, empty descriptions, zero participants.

18. VALIDATION RULES
    Required strings must be non-empty for meaningful UI presentation.

19. ERROR HANDLING
    Handled by presentation/data layers.

20. LOADING STATE
    Handled by presentation.

21. EMPTY STATE
    Handled by presentation.

22. OFFLINE BEHAVIOUR
    Represented through connection status.

23. SECURITY CONSIDERATIONS
    No sensitive information is stored here.

24. PERFORMANCE OPTIMIZATIONS
    Immutable const-compatible entities.

25. WIDGET TREE OVERVIEW
    Not applicable.

26. COMPLETE TESTING CHECKLIST
    Entity construction, equality expectations, multilingual strings,
    zero participant sessions, and connection-state values.
*/

enum HomeConnectionStatus { connected, reconnecting, offline }

class LanguageOptionEntity {
  final String code;
  final String name;
  final String nativeName;

  const LanguageOptionEntity({
    required this.code,
    required this.name,
    required this.nativeName,
  });
}

class HomeFeatureEntity {
  final String id;
  final String title;
  final String subtitle;
  final String status;

  const HomeFeatureEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.status,
  });
}

class RecentSessionEntity {
  final String id;
  final String title;
  final String languagePair;
  final String timeLabel;
  final int participantCount;

  const RecentSessionEntity({
    required this.id,
    required this.title,
    required this.languagePair,
    required this.timeLabel,
    required this.participantCount,
  });
}
