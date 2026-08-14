/*
1. PAGE NAME
   Voice Clone Feature

2. PURPOSE
   Public entry point for the LinguaLive Voice Clone feature.

3. DESCRIPTION
   Exports the feature's page, domain entity, and presentation controller.

4. UI SECTIONS
   Not applicable.

5. NAVIGATION FLOW
   Application router → VoiceClonePage.

6. DYNAMIC COMPONENTS
   Exposed through VoiceClonePage.

7. FUTURE BACKEND INTEGRATION
   No backend is connected by this barrel file.

8. TECHNOLOGIES USED
   Dart and Flutter.

9. REQUIRED DATA MODELS
   VoiceCloneEntity.

10. FUTURE API ENDPOINTS
    Not defined.

11. DATABASE COLLECTIONS/TABLES
    Not defined.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    Application theme.

15. ANIMATIONS
    Defined by presentation widgets.

16. ACCESSIBILITY
    Defined by presentation widgets.

17. EDGE CASES
    Handled by the page/controller.

18. VALIDATION RULES
    Handled by the page/controller.

19. ERROR HANDLING
    Handled by the page/controller.

20. LOADING STATE
    Handled by the page/controller.

21. EMPTY STATE
    Handled by the page/controller.

22. OFFLINE BEHAVIOUR
    Handled by the page/controller.

23. SECURITY CONSIDERATIONS
    No voice data access is performed.

24. PERFORMANCE OPTIMIZATIONS
    Barrel exports only.

25. WIDGET TREE OVERVIEW
    Application router → VoiceClonePage.

26. COMPLETE TESTING CHECKLIST
    Verify imports compile and public feature entry points resolve correctly.
*/

export 'domain/entities/voice_clone_entity.dart';
export 'presentation/controllers/voice_clone_controller.dart';
export 'presentation/pages/voice_clone_page.dart';