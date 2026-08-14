/*
1. PAGE NAME
   LinguaLive Splash Page

2. PURPOSE
   Provides the first visual screen displayed when LinguaLive starts.

3. DESCRIPTION
   Presents LinguaLive branding with a lightweight local startup animation.
   The screen is intentionally independent of networking, authentication,
   databases, AI inference, speech processing, or persistence.

4. UI SECTIONS
   - Responsive background
   - LinguaLive logo mark
   - LinguaLive application name
   - Multilingual communication tagline
   - Local loading progress
   - Startup status text

5. NAVIGATION FLOW
   Application startup → Splash Page → future startup destination.

   The supplied project flow begins with application startup and then moves
   into language selection. This screen therefore remains a presentation
   startup layer rather than implementing language selection itself.

6. DYNAMIC COMPONENTS
   - Local SplashController
   - Animated progress
   - Loading/ready status
   - Responsive logo sizing

7. FUTURE BACKEND INTEGRATION
   The project flow ultimately performs language detection, speech recognition,
   translation, contextual correction, database search, speaker processing,
   TTS, inference optimization, and WebSocket communication. None of those
   services belong in the Splash UI.
   
   // Future: connect application startup completion to the configured router
   // here so the splash can hand control to the next startup screen without
   // embedding navigation infrastructure inside the presentation widget.

8. TECHNOLOGIES USED
   Flutter Material 3
   Dart null safety
   ChangeNotifier for local UI state

9. REQUIRED DATA MODELS
   SplashFeatureEntity
   SplashFeatureModel

10. FUTURE API ENDPOINTS
    None specified for Splash.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    No external asset required by the current implementation.

13. REQUIRED ICONS
    Icons.language
    Icons.graphic_eq

14. THEME COLORS
    Material 3 ColorScheme:
    primary
    primaryContainer
    onPrimary
    onPrimaryContainer
    onSurfaceVariant
    surfaceContainerHighest

15. ANIMATIONS
    AnimatedScale
    AnimatedOpacity
    TweenAnimationBuilder for progress

16. ACCESSIBILITY
    Semantic branding label.
    Accessible progress representation.
    Text remains selectable by assistive technologies.
    No information is conveyed by color alone.

17. EDGE CASES
    - Small phone widths
    - Large phone widths
    - Tablets
    - Portrait
    - Landscape
    - Dark mode
    - Large system text
    - Localization expansion
    - Reduced vertical space
    - Offline startup

18. VALIDATION RULES
    No user input is collected.

19. ERROR HANDLING
    The screen does not invoke external services and therefore has no
    service-specific error state.

20. LOADING STATE
    Local progress animation communicates application preparation.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Splash presentation works without network connectivity.

23. SECURITY CONSIDERATIONS
    No credentials, tokens, user data, or network requests are handled.

24. PERFORMANCE OPTIMIZATIONS
    - Small widget tree
    - Local ChangeNotifier
    - No external state package
    - Const widgets wherever possible
    - Lightweight implicit animations
    - No image decoding or network resources

25. WIDGET TREE OVERVIEW
    Material Scaffold
      └── SafeArea
          └── LayoutBuilder
              └── Center
                  └── SingleChildScrollView
                      └── ConstrainedBox
                          └── SplashBranding

26. COMPLETE TESTING CHECKLIST
    - Layout/overflow
    - Keyboard behavior
    - Orientation
    - Phone/tablet responsiveness
    - Dark mode
    - Large text
    - Screen reader/accessibility
    - Loading state
    - Success/ready state
    - Offline presentation
    - Long localized text
    - Animation smoothness
    - Memory/performance
    - Navigation integration point
    - Localization readiness
*/

import 'package:flutter/material.dart';

import '../../data/data_sources/mock_splash_data_source.dart';
import '../../domain/entities/splash_feature_entity.dart';
import '../controllers/splash_controller.dart';
import '../widgets/splash_branding.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final SplashController _controller;
  late final SplashFeatureEntity _entity;

  @override
  void initState() {
    super.initState();

    const dataSource = MockSplashDataSource();
    _entity = dataSource.loadSplashData().toEntity();
    _controller = SplashController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final horizontalPadding = constraints.maxWidth >= 700
                    ? 56.0
                    : 28.0;

                return Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: 32,
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 560,
                        minHeight: 420,
                      ),
                      child: Center(
                        child: SplashBranding(
                          entity: _entity,
                          progress: _controller.progress,
                          isLoading: _controller.isLoading,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
