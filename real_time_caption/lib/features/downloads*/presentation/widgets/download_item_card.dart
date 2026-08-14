/*
1. PAGE NAME
   Download Item Card

2. PURPOSE
   Presents one downloaded or downloading LinguaLive resource.

3. DESCRIPTION
   Shows multilingual resource metadata, status, progress, offline availability,
   and safe UI-only actions.

4. UI SECTIONS
   Resource icon, title, language pair, metadata, status, and action.

5. NAVIGATION FLOW
   Downloads page → Download item.

6. DYNAMIC COMPONENTS
   Status icon, progress indicator, language pair, size, and action label.

7. FUTURE BACKEND INTEGRATION
   Future: connect item actions to the project's intended local download and
   offline resource services; this card currently performs no file operation.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   DownloadsFeatureModel.

10. FUTURE API ENDPOINTS
    Not specified.

11. DATABASE COLLECTIONS/TABLES
    Not specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    AnimatedContainer for status emphasis.

16. ACCESSIBILITY
    Semantic labels and explicit status text.

17. EDGE CASES
    Failed, paused, downloading, and completed resources.

18. VALIDATION RULES
    Progress is clamped visually between 0 and 1.

19. ERROR HANDLING
    Failed state includes retry action callback.

20. LOADING STATE
    Downloading state displays progress.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Explicit offline availability label.

23. SECURITY CONSIDERATIONS
    No actual file access is performed.

24. PERFORMANCE OPTIMIZATIONS
    Lightweight stateless widget and implicit animation.

25. WIDGET TREE OVERVIEW
    Card → ListTile/content → progress/action.

26. COMPLETE TESTING CHECKLIST
    Test every status, long title, dark mode, large text, and screen reader.
*/

import 'package:flutter/material.dart';

import '../../data/models/downloads_feature_model.dart';

class DownloadItemCard extends StatelessWidget {
  const DownloadItemCard({
    super.key,
    required this.item,
    required this.onActionPressed,
  });

  final DownloadsFeatureModel item;
  final VoidCallback onActionPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final _StatusPresentation status = _statusPresentation(item.status);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  _typeIcon(item.type),
                  color: theme.colorScheme.onSecondaryContainer,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${item.sourceLanguage}  →  ${item.targetLanguage}',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(status.icon, semanticLabel: status.label, size: 21),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              _MetadataPill(
                icon: Icons.data_usage_outlined,
                label: item.sizeLabel,
              ),
              _MetadataPill(
                icon: Icons.schedule_outlined,
                label: item.updatedLabel,
              ),
              if (item.isAvailableOffline)
                const _MetadataPill(
                  icon: Icons.offline_pin_outlined,
                  label: 'Available offline',
                ),
            ],
          ),
          const SizedBox(height: 14),
          Semantics(
            label: '${status.label}, ${item.title}',
            child: Text(
              status.label,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          if (item.status == DownloadItemStatus.downloading ||
              item.status == DownloadItemStatus.paused ||
              item.status == DownloadItemStatus.failed) ...[
            const SizedBox(height: 8),
            LinearProgressIndicator(value: item.progress.clamp(0.0, 1.0)),
          ],
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.tonalIcon(
              onPressed: onActionPressed,
              icon: Icon(status.actionIcon),
              label: Text(status.actionLabel),
            ),
          ),
        ],
      ),
    );
  }

  IconData _typeIcon(DownloadItemType type) {
    return switch (type) {
      DownloadItemType.languagePack => Icons.translate_rounded,
      DownloadItemType.transcript => Icons.article_outlined,
      DownloadItemType.conversation => Icons.forum_outlined,
      DownloadItemType.audio => Icons.graphic_eq_rounded,
    };
  }

  _StatusPresentation _statusPresentation(DownloadItemStatus status) {
    return switch (status) {
      DownloadItemStatus.completed => const _StatusPresentation(
        label: 'Ready for offline use',
        icon: Icons.check_circle_outline_rounded,
        actionLabel: 'Open',
        actionIcon: Icons.open_in_new_rounded,
      ),
      DownloadItemStatus.downloading => const _StatusPresentation(
        label: 'Downloading · 68%',
        icon: Icons.downloading_rounded,
        actionLabel: 'Pause',
        actionIcon: Icons.pause_rounded,
      ),
      DownloadItemStatus.paused => const _StatusPresentation(
        label: 'Paused · 42%',
        icon: Icons.pause_circle_outline_rounded,
        actionLabel: 'Resume',
        actionIcon: Icons.play_arrow_rounded,
      ),
      DownloadItemStatus.failed => const _StatusPresentation(
        label: 'Download failed',
        icon: Icons.error_outline_rounded,
        actionLabel: 'Retry',
        actionIcon: Icons.refresh_rounded,
      ),
    };
  }
}

class _StatusPresentation {
  const _StatusPresentation({
    required this.label,
    required this.icon,
    required this.actionLabel,
    required this.actionIcon,
  });

  final String label;
  final IconData icon;
  final String actionLabel;
  final IconData actionIcon;
}

class _MetadataPill extends StatelessWidget {
  const _MetadataPill({required this.icon, required this.label});

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
        children: [
          Icon(icon, size: 15),
          const SizedBox(width: 5),
          Text(label, style: theme.textTheme.labelMedium),
        ],
      ),
    );
  }
}
