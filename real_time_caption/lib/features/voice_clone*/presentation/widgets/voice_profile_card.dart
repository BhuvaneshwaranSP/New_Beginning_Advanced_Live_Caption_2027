/*
1. PAGE NAME
   Voice Profile Card

2. PURPOSE
   Displays and selects a local dummy voice profile.

3. DESCRIPTION
   Responsive Material 3 profile card with multilingual metadata.

4. UI SECTIONS
   Avatar, profile name, language, duration, status, and selection state.

5. NAVIGATION FLOW
   Voice Clone page → profile card → selected profile.

6. DYNAMIC COMPONENTS
   VoiceCloneEntity.

7. FUTURE BACKEND INTEGRATION
   Future approved voice-profile metadata can populate this card.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   VoiceCloneEntity.

10. FUTURE API ENDPOINTS
    Not defined.

11. DATABASE COLLECTIONS/TABLES
    Not defined.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material voice-related icons.

14. THEME COLORS
    ColorScheme.

15. ANIMATIONS
    AnimatedContainer for selection.

16. ACCESSIBILITY
    Entire card is a semantic button.

17. EDGE CASES
    Long profile names and large text.

18. VALIDATION RULES
    No destructive operation.

19. ERROR HANDLING
    Error status is visibly represented.

20. LOADING STATE
    Not handled inside the card.

21. EMPTY STATE
    Handled by parent.

22. OFFLINE BEHAVIOUR
    Offline status uses both icon and text.

23. SECURITY CONSIDERATIONS
    No actual audio is exposed.

24. PERFORMANCE OPTIMIZATIONS
    Stateless widget with lightweight animation.

25. WIDGET TREE OVERVIEW
    AnimatedContainer → InkWell → Row/Column metadata.

26. COMPLETE TESTING CHECKLIST
    Verify selection, keyboard navigation where applicable, semantics,
    large text, long labels, and dark theme.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/voice_clone_entity.dart';

class VoiceProfileCard extends StatelessWidget {
  const VoiceProfileCard({
    super.key,
    required this.profile,
    required this.selected,
    required this.onTap,
  });

  final VoiceCloneEntity profile;
  final bool selected;
  final VoidCallback onTap;

  String _statusLabel() {
    switch (profile.status) {
      case VoiceProfileStatus.ready:
        return 'Ready';
      case VoiceProfileStatus.processing:
        return 'Processing';
      case VoiceProfileStatus.needsRecording:
        return 'Sample needed';
      case VoiceProfileStatus.error:
        return 'Needs attention';
      case VoiceProfileStatus.offline:
        return 'Offline copy';
    }
  }

  IconData _statusIcon() {
    switch (profile.status) {
      case VoiceProfileStatus.ready:
        return Icons.check_circle_outline_rounded;
      case VoiceProfileStatus.processing:
        return Icons.sync_rounded;
      case VoiceProfileStatus.needsRecording:
        return Icons.mic_none_rounded;
      case VoiceProfileStatus.error:
        return Icons.error_outline_rounded;
      case VoiceProfileStatus.offline:
        return Icons.cloud_off_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final duration = profile.sampleDuration.inSeconds;
    final durationLabel = '${duration}s sample';

    return Semantics(
      button: true,
      selected: selected,
      label: '${profile.name}, ${profile.language}, ${_statusLabel()}',
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: selected
              ? colors.primaryContainer
              : colors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? colors.primary : colors.outlineVariant,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: selected
                      ? colors.primary
                      : colors.secondaryContainer,
                  child: Icon(
                    Icons.record_voice_over_rounded,
                    color: selected
                        ? colors.onPrimary
                        : colors.onSecondaryContainer,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${profile.language} • $durationLabel',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(_statusIcon(), size: 16, color: colors.primary),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              _statusLabel(),
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: colors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          if (profile.isDefault) ...[
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                'Default',
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.labelMedium,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  selected
                      ? Icons.radio_button_checked_rounded
                      : Icons.radio_button_unchecked_rounded,
                  color: selected ? colors.primary : colors.outline,
                  semanticLabel: selected ? 'Selected' : 'Not selected',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
