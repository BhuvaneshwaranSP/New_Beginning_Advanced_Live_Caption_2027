/*
1. PAGE NAME
   Chat Message Bubble

2. PURPOSE
   Displays an individual multilingual LinguaLive conversation message.

3. DESCRIPTION
   Shows original speech/text, translated content, language direction,
   timestamp, delivery status, and optional confidence.

4. UI SECTIONS
   Original message, translation, metadata, and status.

5. NAVIGATION FLOW
   ChatPage → ChatMessageBubble.

6. DYNAMIC COMPONENTS
   Incoming/outgoing alignment, translation, confidence, and delivery status.

7. FUTURE BACKEND INTEGRATION
   Future: display live translated output here as the multilingual
   conversation pipeline produces finalized message segments.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   ChatFeatureEntity.

10. FUTURE API ENDPOINTS
    Not specified in supplied documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified in supplied documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    AnimatedContainer for lightweight message appearance.

16. ACCESSIBILITY
    Entire message is represented by a descriptive Semantics node.

17. EDGE CASES
    Long multilingual text and missing confidence.

18. VALIDATION RULES
    Empty translated text is handled gracefully.

19. ERROR HANDLING
    Translation availability is communicated without relying only on color.

20. LOADING STATE
    Translating status is visually represented.

21. EMPTY STATE
    Not applicable to individual message.

22. OFFLINE BEHAVIOUR
    Offline status is shown explicitly.

23. SECURITY CONSIDERATIONS
    No sensitive data processing.

24. PERFORMANCE OPTIMIZATIONS
    Stateless widget and compact layout.

25. WIDGET TREE OVERVIEW
    Semantics → AnimatedContainer → Column → text and metadata.

26. COMPLETE TESTING CHECKLIST
    Test long text, RTL/Unicode text, large font, dark mode, semantics,
    translation status, confidence, and offline status.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/chat_feature_entity.dart';

class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({super.key, required this.message});

  final ChatFeatureEntity message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isMine = message.isMine;

    final bubbleColor = isMine
        ? colorScheme.primaryContainer
        : colorScheme.surfaceContainerHighest;

    final titleColor = isMine
        ? colorScheme.onPrimaryContainer
        : colorScheme.onSurface;

    return Semantics(
      container: true,
      label: _semanticLabel(),
      child: Align(
        alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            margin: EdgeInsets.only(
              left: isMine ? 56 : 12,
              right: isMine ? 12 : 56,
              bottom: 10,
            ),
            padding: const EdgeInsets.fromLTRB(16, 13, 16, 11),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: Radius.circular(isMine ? 20 : 6),
                bottomRight: Radius.circular(isMine ? 6 : 20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isMine)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      message.senderName,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                Text(
                  message.originalText,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: titleColor,
                    height: 1.35,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (message.translatedText.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      color: colorScheme.surface.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${message.targetLanguage} translation',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          message.translatedText,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            height: 1.35,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      '${message.sourceLanguage} → ${message.targetLanguage}',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      message.timestamp,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    _StatusIndicator(status: message.status),
                    if (message.confidence != null)
                      Text(
                        '${(message.confidence! * 100).round()}%',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _semanticLabel() {
    final translation = message.translatedText.isEmpty
        ? 'No translation available'
        : 'Translated as ${message.translatedText}';

    return '${message.senderName}. ${message.originalText}. '
        '$translation. ${message.timestamp}.';
  }
}

class _StatusIndicator extends StatelessWidget {
  const _StatusIndicator({required this.status});

  final ChatMessageStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final (IconData icon, String label) = switch (status) {
      ChatMessageStatus.sent => (Icons.check_rounded, 'Sent'),
      ChatMessageStatus.delivered => (Icons.done_all_rounded, 'Delivered'),
      ChatMessageStatus.read => (Icons.done_all_rounded, 'Read'),
      ChatMessageStatus.translating => (Icons.translate_rounded, 'Translating'),
      ChatMessageStatus.offline => (Icons.cloud_off_rounded, 'Offline'),
    };

    return Semantics(
      label: label,
      child: Icon(icon, size: 15, color: theme.colorScheme.onSurfaceVariant),
    );
  }
}
