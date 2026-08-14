/*
1. PAGE NAME
   Conversation Card

2. PURPOSE
   Displays one historical multilingual conversation.

3. DESCRIPTION
   Presents title, participant count, language direction, preview,
   timestamp, duration, and status.

4. UI SECTIONS
   Leading identity, title, preview, metadata, language pair, and status.

5. NAVIGATION FLOW
   Conversation list → selected conversation callback.

6. DYNAMIC COMPONENTS
   Conversation model.

7. FUTURE BACKEND INTEGRATION
   Selecting a card will later open the corresponding stored session;
   this callback is the integration boundary.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   ConversationsFeatureModel.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    Future session-history storage.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    Ink ripple interaction.

16. ACCESSIBILITY
    Entire card has a semantic label and sufficient touch target.

17. EDGE CASES
    Long multilingual titles, many participants, and long previews.

18. VALIDATION RULES
    Display values are already supplied by the local model.

19. ERROR HANDLING
    Missing future metadata falls back to readable labels.

20. LOADING STATE
    Parent handles loading.

21. EMPTY STATE
    Parent handles empty content.

22. OFFLINE BEHAVIOUR
    Local conversation cards remain displayable.

23. SECURITY CONSIDERATIONS
    Fictional demonstration data only.

24. PERFORMANCE OPTIMIZATIONS
    Stateless card with lightweight layout.

25. WIDGET TREE OVERVIEW
    Card → ListTile → title/preview → metadata → language/status.

26. COMPLETE TESTING CHECKLIST
    Test taps, semantics, long text, multilingual strings, dark mode,
    large text, and responsive card width.
*/

import 'package:flutter/material.dart';

import '../../data/models/conversations_feature_model.dart';

class ConversationCard extends StatelessWidget {
  const ConversationCard({
    super.key,
    required this.conversation,
    required this.onTap,
    required this.onMorePressed,
  });

  final ConversationsFeatureModel conversation;
  final VoidCallback onTap;
  final VoidCallback onMorePressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Semantics(
      button: true,
      label:
          '${conversation.title}. ${conversation.sourceLanguage} to '
          '${conversation.targetLanguage}. ${conversation.durationLabel}.',
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 8, 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _ConversationAvatar(
                  title: conversation.title,
                  color: theme.colorScheme.primaryContainer,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              conversation.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          if (conversation.isPinned)
                            Padding(
                              padding: const EdgeInsets.only(left: 6),
                              child: Icon(
                                Icons.push_pin_rounded,
                                size: 18,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        conversation.preview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 7,
                        children: <Widget>[
                          _MetaPill(
                            icon: Icons.translate_rounded,
                            label:
                                '${conversation.sourceLanguage} → '
                                '${conversation.targetLanguage}',
                          ),
                          _MetaPill(
                            icon: Icons.schedule_rounded,
                            label: conversation.durationLabel,
                          ),
                          _MetaPill(
                            icon: Icons.people_alt_outlined,
                            label:
                                '${conversation.participants.length} '
                                'participants',
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          _StatusIndicator(status: conversation.status),
                          const SizedBox(width: 7),
                          Expanded(
                            child: Text(
                              _statusLabel(conversation.status),
                              style: theme.textTheme.labelMedium,
                            ),
                          ),
                          Text(
                            conversation.timestampLabel,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'More options',
                  onPressed: onMorePressed,
                  icon: const Icon(Icons.more_vert_rounded),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _statusLabel(ConversationStatus status) {
    switch (status) {
      case ConversationStatus.completed:
        return 'Session complete';
      case ConversationStatus.translated:
        return 'Translation available';
      case ConversationStatus.processing:
        return 'Processing preview';
    }
  }
}

class _ConversationAvatar extends StatelessWidget {
  const _ConversationAvatar({required this.title, required this.color});

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final String initial = title.trim().isEmpty
        ? '?'
        : title.trim().characters.first.toUpperCase();

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
      ),
    );
  }
}

class _MetaPill extends StatelessWidget {
  const _MetaPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 15),
          const SizedBox(width: 5),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}

class _StatusIndicator extends StatelessWidget {
  const _StatusIndicator({required this.status});

  final ConversationStatus status;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final IconData icon;
    switch (status) {
      case ConversationStatus.completed:
        icon = Icons.check_circle_rounded;
      case ConversationStatus.translated:
        icon = Icons.translate_rounded;
      case ConversationStatus.processing:
        icon = Icons.hourglass_top_rounded;
    }

    return Icon(icon, size: 16, color: theme.colorScheme.primary);
  }
}
