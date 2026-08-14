/*
1. PAGE NAME
   Splash Branding

2. PURPOSE
   Presents the central LinguaLive identity on the Splash screen.

3. DESCRIPTION
   A compact, responsive Material 3 branding composition with a language
   communication motif and multilingual messaging.

4. UI SECTIONS
   Logo mark, application name, tagline, and loading indicator.

5. NAVIGATION FLOW
   Displayed by SplashPage during application startup.

6. DYNAMIC COMPONENTS
   Loading progress, loading label, and animated branding scale.

7. FUTURE BACKEND INTEGRATION
   No backend functionality belongs inside this widget.
   // Future: provide live startup status here if application initialization
   // later exposes meaningful preparation stages; this widget is responsible
   // for communicating startup status visually.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   SplashFeatureEntity.

10. FUTURE API ENDPOINTS
    None.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    No external image is required.

13. REQUIRED ICONS
    Icons.language, Icons.graphic_eq, Icons.translate.

14. THEME COLORS
    Uses Material 3 ColorScheme.

15. ANIMATIONS
    AnimatedScale and AnimatedOpacity.

16. ACCESSIBILITY
    Semantics labels identify the brand and startup status.

17. EDGE CASES
    Handles narrow widths and large text using flexible constraints.

18. VALIDATION RULES
    Text must fit within flexible available width.

19. ERROR HANDLING
    No external errors.

20. LOADING STATE
    LinearProgressIndicator communicates local startup progress.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Branding renders without connectivity.

23. SECURITY CONSIDERATIONS
    No user information is shown.

24. PERFORMANCE OPTIMIZATIONS
    Lightweight implicit animations and const decorations.

25. WIDGET TREE OVERVIEW
    Semantics → Column → logo container → brand text → tagline →
    progress indicator.

26. COMPLETE TESTING CHECKLIST
    Verify responsiveness, large text, dark mode, semantics, animation,
    and localization readiness.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/splash_feature_entity.dart';

class SplashBranding extends StatelessWidget {
  const SplashBranding({
    super.key,
    required this.entity,
    required this.progress,
    required this.isLoading,
  });

  final SplashFeatureEntity entity;
  final double progress;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Semantics(
      container: true,
      label: '${entity.appName}. ${entity.loadingLabel}.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 380;
          final markSize = compact ? 92.0 : 108.0;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedScale(
                scale: isLoading ? 1.0 : 1.04,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
                child: _SplashLogoMark(
                  size: markSize,
                  colorScheme: colorScheme,
                ),
              ),
              const SizedBox(height: 28),
              Text(
                entity.appName,
                textAlign: TextAlign.center,
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1.1,
                ),
              ),
              const SizedBox(height: 10),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 320),
                child: Text(
                  entity.tagline,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.45,
                  ),
                ),
              ),
              const SizedBox(height: 34),
              SizedBox(
                width: compact ? 170 : 190,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(end: progress),
                        duration: const Duration(milliseconds: 160),
                        curve: Curves.easeOut,
                        builder: (context, value, child) {
                          return LinearProgressIndicator(
                            value: value,
                            minHeight: 5,
                            backgroundColor:
                                colorScheme.surfaceContainerHighest,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    AnimatedOpacity(
                      opacity: isLoading ? 1.0 : 0.65,
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        isLoading ? entity.loadingLabel : 'Ready',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SplashLogoMark extends StatelessWidget {
  const _SplashLogoMark({required this.size, required this.colorScheme});

  final double size;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(size * 0.31),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.language,
            size: size * 0.48,
            color: colorScheme.onPrimaryContainer,
          ),
          Positioned(
            right: size * 0.17,
            bottom: size * 0.15,
            child: Container(
              width: size * 0.29,
              height: size * 0.29,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: colorScheme.primaryContainer,
                  width: 3,
                ),
              ),
              child: Icon(
                Icons.graphic_eq,
                size: size * 0.15,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
