/*
1. PAGE NAME
   History Session Card

2. PURPOSE
   Displays one historical LinguaLive communication session.

3. DESCRIPTION
   Presents the session title, language direction, participant count,
   transcript preview, duration, date, and non-color-only status.

4. UI SECTIONS
   Session icon, title, language pair, metadata, preview, status,
   and action button.

5. NAVIGATION FLOW
   History list → session card → future session-detail/history playback.

6. DYNAMIC COMPONENTS
   HistoryFeatureEntity.

7. FUTURE BACKEND INTEGRATION
   The card action will later open the persisted transcript/session
   detail associated with this history record.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   HistoryFeatureEntity.

10. FUTURE API ENDPOINTS
    None implemented.

11. DATABASE COLLECTIONS/TABLES
    None implemented.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    Ink response and subtle AnimatedContainer selection feedback.

16. ACCESSIBILITY
    Card semantics expose session title, language pair, status, and
    action meaning.

17. EDGE CASES
    Long title, long preview, offline status, interrupted session,
    large participant count, and large text.

18. VALIDATION RULES
    Display fields are already validated by the local entity.

19. ERROR HANDLING
    Parent owns session-level error state.

20. LOADING STATE
    Parent displays skeleton state instead of this card.

21. EMPTY STATE
    Parent displays empty state.

22. OFFLINE BEHAVIOUR
    Offline status is explicitly labelled.

23. SECURITY CONSIDERATIONS
    Dummy transcript content only.

24. PERFORMANCE OPTIMIZATIONS
    Stateless card with const helper widgets.

25. WIDGET TREE OVERVIEW
    Card → InkWell → Row → icon + Expanded content + action.

26. COMPLETE TESTING CHECKLIST
    Verify card overflow, semantic labels, touch target size, dark mode,
    long multilingual strings, and action callback.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/history_feature_entity.dart';

class HistorySessionCard extends StatelessWidget {
  const HistorySessionCard({
    super.key,
    required this.session,
    required this.onOpen,
  });

  final HistoryFeatureEntity session;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final icon = _sessionIcon(session.type);
    final statusLabel = _statusLabel(session.status);
    final statusIcon = _statusIcon(session.status);

    return Semantics(
      container: true,
      label:
          '${session.title}. ${session.sourceLanguage} to ${session.targetLanguage}. '
          '$statusLabel. ${session.durationLabel}.',
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        child: InkWell(
          onTap: onOpen,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 12, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: theme.colorScheme.secondaryContainer,
                  foregroundColor: theme.colorScheme.onSecondaryContainer,
                  child: Icon(icon),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              session.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            statusIcon,
                            size: 18,
                            semanticLabel: statusLabel,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${session.sourceLanguage}  →  ${session.targetLanguage}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 9),
                      Text(
                        session.preview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        children: [
                          _MetaItem(
                            icon: Icons.people_alt_outlined,
                            label: session.participantLabel,
                          ),
                          _MetaItem(
                            icon: Icons.timer_outlined,
                            label: session.durationLabel,
                          ),
                          _MetaItem(
                            icon: Icons.calendar_today_outlined,
                            label:
                                '${session.dateLabel} · ${session.timeLabel}',
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _StatusBadge(icon: statusIcon, label: statusLabel),
                          const Spacer(),
                          Text(
                            '${session.messageCount} segments',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.chevron_right_rounded, size: 20),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _sessionIcon(HistorySessionType type) {
    return switch (type) {
      HistorySessionType.liveSpeech => Icons.graphic_eq_rounded,
      HistorySessionType.call => Icons.call_rounded,
      HistorySessionType.conversation => Icons.forum_outlined,
    };
  }

  IconData _statusIcon(HistorySessionStatus status) {
    return switch (status) {
      HistorySessionStatus.completed => Icons.check_circle_outline_rounded,
      HistorySessionStatus.interrupted => Icons.pause_circle_outline_rounded,
      HistorySessionStatus.offline => Icons.cloud_off_outlined,
    };
  }

  String _statusLabel(HistorySessionStatus status) {
    return switch (status) {
      HistorySessionStatus.completed => 'Completed',
      HistorySessionStatus.interrupted => 'Interrupted',
      HistorySessionStatus.offline => 'Saved offline',
    };
  }
}

class _MetaItem extends StatelessWidget {
  const _MetaItem({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 5),
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      constraints: const BoxConstraints(minHeight: 32),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, semanticLabel: label),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
