/*
1. PAGE NAME
   Notification Tile

2. PURPOSE
   Displays one multilingual LinguaLive notification.

3. DESCRIPTION
   Shows notification type, title, message, time, language pair, and unread
   status in an accessible Material 3 card.

4. UI SECTIONS
   Icon, title/time row, message, language pair, unread indicator.

5. NAVIGATION FLOW
   NotificationsPage → NotificationTile → future originating feature.

6. DYNAMIC COMPONENTS
   Notification content, language chips, unread state, and icon.

7. FUTURE BACKEND INTEGRATION
   The callback can later navigate to the originating supported LinguaLive
   session, call, chat, or translation context.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   NotificationsFeatureEntity.

10. FUTURE API ENDPOINTS
    None defined.

11. DATABASE COLLECTIONS/TABLES
    None defined.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Notification icon supplied by the model.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    Material InkWell interaction feedback.

16. ACCESSIBILITY
    Semantics label contains notification status, content, time, and language pair.

17. EDGE CASES
    Long title, long message, narrow screen, large text, and multilingual labels.

18. VALIDATION RULES
    Display strings come from the domain entity.

19. ERROR HANDLING
    Not applicable to the tile.

20. LOADING STATE
    Parent page controls loading.

21. EMPTY STATE
    Parent page controls empty state.

22. OFFLINE BEHAVIOUR
    Parent page controls offline state.

23. SECURITY CONSIDERATIONS
    Dummy content only.

24. PERFORMANCE OPTIMIZATIONS
    Stateless widget with no expensive calculations.

25. WIDGET TREE OVERVIEW
    Semantics
      → Card
         → InkWell
            → Row
               → CircleAvatar
               → notification content
               → language chips.

26. COMPLETE TESTING CHECKLIST
    Long content, screen-reader semantics, dark mode, large text, touch target,
    multilingual rendering, unread/read appearance, and narrow layouts.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/notifications_feature_entity.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.notification,
    required this.onPressed,
    required this.icon,
  });

  final NotificationsFeatureEntity notification;
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Semantics(
      button: true,
      label:
          '${notification.isUnread ? 'Unread. ' : ''}'
          '${notification.title}. '
          '${notification.message}. '
          '${notification.timeLabel}. '
          '${notification.sourceLanguage} to '
          '${notification.targetLanguage}.',
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: notification.isUnread
            ? scheme.primaryContainer.withValues(alpha: 0.34)
            : scheme.surfaceContainerLow,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: notification.isUnread
                      ? scheme.primary
                      : scheme.secondaryContainer,
                  foregroundColor: notification.isUnread
                      ? scheme.onPrimary
                      : scheme.onSecondaryContainer,
                  child: Icon(icon, size: 22),
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
                              notification.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: notification.isUnread
                                    ? FontWeight.w700
                                    : FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            notification.timeLabel,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        notification.message,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Chip(
                            label: Text(notification.sourceLanguage),
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                          ),
                          const Icon(Icons.arrow_forward_rounded, size: 15),
                          Chip(
                            label: Text(notification.targetLanguage),
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                          ),
                          if (notification.isUnread)
                            Chip(
                              avatar: Icon(
                                Icons.fiber_manual_record,
                                size: 10,
                                color: scheme.primary,
                              ),
                              label: const Text('Unread'),
                              visualDensity: VisualDensity.compact,
                              padding: EdgeInsets.zero,
                            ),
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
}
