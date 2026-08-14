/*
1. PAGE NAME
   Transcript Segment Card

2. PURPOSE
   Displays one speaker's transcription and translated text.

3. DESCRIPTION
   Presents original speech, translated output, speaker identity,
   timestamp, language, and confidence.

4. UI SECTIONS
   Speaker header, original text, translated text, metadata.

5. NAVIGATION FLOW
   TranscriptionPage → TranscriptSegmentCard.

6. DYNAMIC COMPONENTS
   Speaker, language, text, confidence, timestamp, final status.

7. FUTURE BACKEND INTEGRATION
   Future: bind streaming ASR hypotheses and final segments here;
   this widget is the visual representation of each transcription result.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   TranscriptionEntity.

10. FUTURE API ENDPOINTS
    Not defined.

11. DATABASE COLLECTIONS/TABLES
    Not defined.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    Subtle AnimatedContainer state transition.

16. ACCESSIBILITY
    Speaker and confidence are represented through text as well as icons.

17. EDGE CASES
    Long text, low confidence, mixed languages.

18. VALIDATION RULES
    Confidence is clamped visually between 0 and 100%.

19. ERROR HANDLING
    Parent handles overall transcription errors.

20. LOADING STATE
    Parent handles loading.

21. EMPTY STATE
    Parent handles empty results.

22. OFFLINE BEHAVIOUR
    Existing dummy segments remain readable.

23. SECURITY CONSIDERATIONS
    No real personal data.

24. PERFORMANCE OPTIMIZATIONS
    Stateless rendering and compact layout.

25. WIDGET TREE OVERVIEW
    Card → speaker row → original text → translated text → metadata.

26. COMPLETE TESTING CHECKLIST
    Test long multilingual text, large font, dark mode, and accessibility.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/transcription_entity.dart';

class TranscriptSegmentCard extends StatelessWidget {
  const TranscriptSegmentCard({
    super.key,
    required this.segment,
    required this.index,
  });

  final TranscriptionEntity segment;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final confidence = (segment.confidence * 100).round();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: index.isEven
            ? theme.colorScheme.surfaceContainerLow
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 19,
                  child: Text(
                    segment.speakerName.characters.first.toUpperCase(),
                    semanticsLabel: 'Speaker ${segment.speakerName}',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        segment.speakerName,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${segment.languageCode} • ${segment.timestamp}',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Semantics(
                  label: '$confidence percent transcription confidence',
                  child: Chip(
                    avatar: const Icon(
                      Icons.verified_rounded,
                      size: 16,
                    ),
                    label: Text('$confidence%'),
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              segment.originalText,
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.45,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withValues(
                  alpha: 0.45,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.translate_rounded,
                    size: 19,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      segment.translatedText,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  segment.isFinal
                      ? Icons.check_circle_outline_rounded
                      : Icons.more_horiz_rounded,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  segment.isFinal ? 'Final transcript' : 'Processing',
                  style: theme.textTheme.labelMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}