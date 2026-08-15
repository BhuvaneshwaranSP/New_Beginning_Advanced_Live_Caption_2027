/*
1. PAGE NAME
   Accessibility Preview Card

2. PURPOSE
   Shows how multilingual communication can remain readable and accessible.

3. DESCRIPTION
   Demonstrates the project's Audio → Caption → Translation → readable text
   philosophy using local dummy content.

4. UI SECTIONS
   Preview header, original speech, caption, translation, and spoken output.

5. NAVIGATION FLOW
   AccessibilityPage → Preview.

6. DYNAMIC COMPONENTS
   Text scale, caption scale, and preference states.

7. FUTURE BACKEND INTEGRATION
   Future: connect live caption and translation output here so this preview
   can represent the active multilingual communication pipeline.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   None beyond controller state.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    None specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    graphic_eq, closed_caption, translate, volume_up.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    AnimatedContainer for compact state changes.

16. ACCESSIBILITY
    Preview content uses explicit semantic labels.

17. EDGE CASES
    Large text and long multilingual content.

18. VALIDATION RULES
    Controller bounds display scales.

19. ERROR HANDLING
    Parent state handles error presentation.

20. LOADING STATE
    Parent state handles loading presentation.

21. EMPTY STATE
    Parent state handles empty presentation.

22. OFFLINE BEHAVIOUR
    Dummy preview remains visible offline.

23. SECURITY CONSIDERATIONS
    Preview uses non-sensitive example content.

24. PERFORMANCE OPTIMIZATIONS
    Small widget tree and no expensive painting.

25. WIDGET TREE OVERVIEW
    Card → source → caption → translation → spoken output.

26. COMPLETE TESTING CHECKLIST
    Verify scaling, semantics, dark mode, contrast, and multilingual wrapping.
*/

import 'package:flutter/material.dart';

class AccessibilityPreviewCard extends StatelessWidget {
  const AccessibilityPreviewCard({
    super.key,
    required this.textScale,
    required this.captionScale,
    required this.captionsEnabled,
    required this.translationEnabled,
    required this.spokenOutputEnabled,
  });

  final double textScale;
  final double captionScale;
  final bool captionsEnabled;
  final bool translationEnabled;
  final bool spokenOutputEnabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Communication preview',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'A simple example of accessible multilingual communication.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 18),
            _PreviewRow(
              icon: Icons.graphic_eq,
              label: 'Original',
              text: 'வணக்கம், நீங்கள் எப்படி இருக்கிறீர்கள்?',
              scale: textScale,
            ),
            if (captionsEnabled) ...[
              const SizedBox(height: 12),
              _PreviewRow(
                icon: Icons.closed_caption_outlined,
                label: 'Caption',
                text: 'Vanakkam, neengal eppadi irukkireergal?',
                scale: captionScale,
              ),
            ],
            if (translationEnabled) ...[
              const SizedBox(height: 12),
              _PreviewRow(
                icon: Icons.translate,
                label: 'English translation',
                text: 'Hello, how are you?',
                scale: textScale,
              ),
            ],
            if (spokenOutputEnabled) ...[
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 11,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.volume_up_outlined,
                      color: theme.colorScheme.onSecondaryContainer,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Spoken output enabled',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PreviewRow extends StatelessWidget {
  const _PreviewRow({
    required this.icon,
    required this.label,
    required this.text,
    required this.scale,
  });

  final IconData icon;
  final String label;
  final String text;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      label: '$label: $text',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 21, color: theme.colorScheme.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    text,
                    textScaler: TextScaler.linear(scale),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
