/*
1. PAGE NAME
   Splash Feature Entity

2. PURPOSE
   Defines the pure domain representation of Splash presentation data.

3. DESCRIPTION
   Contains immutable Dart data without Flutter dependencies.

4. UI SECTIONS
   Branding and loading information.

5. NAVIGATION FLOW
   Splash entity → Splash presentation.

6. DYNAMIC COMPONENTS
   Application name, tagline, and loading label.

7. FUTURE BACKEND INTEGRATION
   None.

8. TECHNOLOGIES USED
   Dart null safety.

9. REQUIRED DATA MODELS
   SplashFeatureEntity.

10. FUTURE API ENDPOINTS
    None.

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
    Entity values are plain semantic strings.

17. EDGE CASES
    Localization can change string lengths.

18. VALIDATION RULES
    Production values should be non-empty.

19. ERROR HANDLING
    No operations are performed.

20. LOADING STATE
    Represented by loadingLabel.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Fully local.

23. SECURITY CONSIDERATIONS
    No sensitive data.

24. PERFORMANCE OPTIMIZATIONS
    Immutable final fields.

25. WIDGET TREE OVERVIEW
    Entity → Controller → Splash presentation.

26. COMPLETE TESTING CHECKLIST
    Verify values survive model-to-entity conversion without mutation.
*/

class SplashFeatureEntity {
  const SplashFeatureEntity({
    required this.appName,
    required this.tagline,
    required this.loadingLabel,
  });

  final String appName;
  final String tagline;
  final String loadingLabel;
}
