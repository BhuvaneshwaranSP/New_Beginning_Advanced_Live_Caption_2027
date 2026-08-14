/*
1. PAGE NAME
   Subscription Benefits

2. PURPOSE
   Explains the broader value of LinguaLive subscription access.

3. DESCRIPTION
   Provides a concise feature-oriented summary rather than repeating every plan
   feature.

4. UI SECTIONS
   Three benefit rows.

5. NAVIGATION FLOW
   SubscriptionPage → SubscriptionBenefits.

6. DYNAMIC COMPONENTS
   Static local UI content.

7. FUTURE BACKEND INTEGRATION
   Future: benefit availability can reflect the user's actual entitlement
   after subscription status is connected.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   None.

10. FUTURE API ENDPOINTS
    Not specified.

11. DATABASE COLLECTIONS/TABLES
    Not specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Icons.record_voice_over_rounded, Icons.language_rounded,
    Icons.history_rounded.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Each benefit has descriptive text.

17. EDGE CASES
    Large text scaling.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    None.

20. LOADING STATE
    None.

21. EMPTY STATE
    None.

22. OFFLINE BEHAVIOUR
    Static content remains available.

23. SECURITY CONSIDERATIONS
    No sensitive data.

24. PERFORMANCE OPTIMIZATIONS
    Static const data.

25. WIDGET TREE OVERVIEW
    Card → Column → benefit rows.

26. COMPLETE TESTING CHECKLIST
    Verify text scaling and screen-reader ordering.
*/

import 'package:flutter/material.dart';

class SubscriptionBenefits extends StatelessWidget {
  const SubscriptionBenefits({super.key});

  static const _benefits = [
    (
      Icons.record_voice_over_rounded,
      'Communicate naturally',
      'Designed around live multilingual conversations and captions.',
    ),
    (
      Icons.language_rounded,
      'Go beyond one language pair',
      'Choose the language combinations that fit your conversations.',
    ),
    (
      Icons.history_rounded,
      'Keep conversations organized',
      'Higher plans provide broader access to conversation history.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      elevation: 0,
      color: colors.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Built for multilingual communication',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            ..._benefits.map(
              (benefit) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      benefit.$1,
                      color: colors.primary,
                      size: 23,
                    ),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            benefit.$2,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            benefit.$3,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colors.onSurfaceVariant,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}