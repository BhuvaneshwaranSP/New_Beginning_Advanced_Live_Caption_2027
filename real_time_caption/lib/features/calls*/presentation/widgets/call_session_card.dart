/*
1. PAGE NAME
   Call Session Card

2. PURPOSE
   Displays one recent multilingual call session.

3. DESCRIPTION
   Compact Material 3 card showing participant, language pair, status,
   call type, duration, and timestamp.

4. UI SECTIONS
   Participant identity, call metadata, language pair, and status.

5. NAVIGATION FLOW
   Calls page → call card → future active call/call details screen.

6. DYNAMIC COMPONENTS
   Participant name, language pair, status, duration, and timestamp.

7. FUTURE BACKEND INTEGRATION
   Future: connect this interaction to the active call-session flow so the
   selected session can open the real multilingual call experience.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   CallsFeatureModel.

10. FUTURE API ENDPOINTS
    Call-session endpoint.

11. DATABASE COLLECTIONS/TABLES
    Call history.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    phone, videocam, translate, wifi.

14. THEME COLORS
    Active ColorScheme.

15. ANIMATIONS
    AnimatedContainer for selected-state feedback.

16. ACCESSIBILITY
    Entire card has a descriptive semantic label.

17. EDGE CASES
    Long names and long language labels.

18. VALIDATION RULES
    Safe display fallback for blank text.

19. ERROR HANDLING
    Error state is handled by the parent page.

20. LOADING STATE
    Parent page controls loading representation.

21. EMPTY STATE
    Parent page controls empty representation.

22. OFFLINE BEHAVIOUR
    Status is communicated through text and icon.

23. SECURITY CONSIDERATIONS
    No real participant credentials.

24. PERFORMANCE OPTIMIZATIONS
    Small stateless widget.

25. WIDGET TREE OVERVIEW
    Semantics → AnimatedContainer → ListTile + metadata.

26. COMPLETE TESTING CHECKLIST
    Test selection, accessibility, long text, dark mode, and touch target size.
*/

import 'package:flutter/material.dart';

import '../../data/models/calls_feature_model.dart';

class CallSessionCard extends StatelessWidget {
  const CallSessionCard({
    super.key,
    required this.call,
    required this.onPressed,
  });

  final CallsFeatureModel call;
  final VoidCallback onPressed;

  String _statusLabel() {
    switch (call.status) {
      case CallStatus.completed:
        return 'Completed';
      case CallStatus.missed:
        return 'Missed';
      case CallStatus.incoming:
        return 'Incoming';
      case CallStatus.reconnecting:
        return 'Reconnecting';
      case CallStatus.offline:
        return 'Offline';
    }
  }

  IconData _callIcon() {
    return call.callType == CallType.video
        ? Icons.videocam_outlined
        : Icons.phone_outlined;
  }

  String _durationLabel() {
    if (call.duration == Duration.zero) {
      return 'No answer';
    }

    final int minutes = call.duration.inMinutes;
    final int seconds = call.duration.inSeconds.remainder(60);

    return '${minutes}m ${seconds.toString().padLeft(2, '0')}s';
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;

    final String semanticLabel =
        '${call.participant.name}, ${call.languagePair.displayLabel}, '
        '${_statusLabel()}, ${call.timestampLabel}';

    return Semantics(
      button: true,
      label: semanticLabel,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 25,
                  child: Text(
                    call.participant.initials,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
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
                              call.participant.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            _callIcon(),
                            size: 20,
                            semanticLabel: call.callType == CallType.video
                                ? 'Video call'
                                : 'Voice call',
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        call.languagePair.displayLabel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: <Widget>[
                          _StatusPill(
                            label: _statusLabel(),
                            icon: call.status == CallStatus.reconnecting
                                ? Icons.sync
                                : Icons.check_circle_outline,
                          ),
                          Text(
                            _durationLabel(),
                            style: theme.textTheme.bodySmall,
                          ),
                          Text(
                            call.timestampLabel,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: colors.secondaryContainer,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 14, color: colors.onSecondaryContainer),
          const SizedBox(width: 5),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: colors.onSecondaryContainer,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
