/*
1. PAGE NAME
   Onboarding Progress

2. PURPOSE
   Communicates the user's position in the onboarding setup.

3. DESCRIPTION
   Compact visual and textual progress indicator.

4. UI SECTIONS
   Progress bar and progress label.

5. NAVIGATION FLOW
   Appears above the language-selection content.

6. DYNAMIC COMPONENTS
   Current step and total steps.

7. FUTURE BACKEND INTEGRATION
   None.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   None.

10. FUTURE API ENDPOINTS
    None.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    AnimatedProgressIndicator behavior through TweenAnimationBuilder.

16. ACCESSIBILITY
    Textual progress description accompanies the visual indicator.

17. EDGE CASES
    Invalid progress values are clamped.

18. VALIDATION RULES
    Current step is constrained to total steps.

19. ERROR HANDLING
    None.

20. LOADING STATE
    None.

21. EMPTY STATE
    None.

22. OFFLINE BEHAVIOUR
    Fully local.

23. SECURITY CONSIDERATIONS
    None.

24. PERFORMANCE OPTIMIZATIONS
    Lightweight implicit animation.

25. WIDGET TREE OVERVIEW
    Column → Text → TweenAnimationBuilder.

26. COMPLETE TESTING CHECKLIST
    Verify semantics, animation, dark mode, and large text.
*/

import 'package:flutter/material.dart';

class OnboardingProgress extends StatelessWidget {
  const OnboardingProgress({
    super.key,
    this.currentStep = 1,
    this.totalSteps = 1,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final int safeTotal = totalSteps <= 0 ? 1 : totalSteps;
    final int safeStep = currentStep.clamp(0, safeTotal);
    final double progress = safeStep / safeTotal;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Setup • $safeStep of $safeTotal',
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: progress),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          builder: (BuildContext context, double value, Widget? child) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: LinearProgressIndicator(
                value: value,
                minHeight: 6,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
              ),
            );
          },
        ),
      ],
    );
  }
}
