/*
1. PAGE NAME
   AI Model Card

2. PURPOSE
   Presents one AI pipeline component in a compact, premium LinguaLive card.

3. DESCRIPTION
   Displays model identity, purpose, category, status, language coverage,
   performance characteristics, offline availability, and recommendation.

4. UI SECTIONS
   Model identity, status, description, metadata, language chips, and action.

5. NAVIGATION FLOW
   AI Models page → AI Model Card.

6. DYNAMIC COMPONENTS
   All displayed model metadata and selected state.

7. FUTURE BACKEND INTEGRATION
   The selection callback can later activate the selected AI component in
   the project's intended inference pipeline.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   AiModelEntity.

10. FUTURE API ENDPOINTS
   None defined.

11. DATABASE COLLECTIONS/TABLES
   None defined.

12. REQUIRED ASSETS
   None.

13. REQUIRED ICONS
   Material Icons.

14. THEME COLORS
   Active Material 3 ColorScheme.

15. ANIMATIONS
   AnimatedContainer for selection emphasis.

16. ACCESSIBILITY
   Buttons have tooltips and semantic labels.

17. EDGE CASES
   Long names, many languages, unavailable status, and selected state.

18. VALIDATION RULES
   No user input.

19. ERROR HANDLING
   Status presentation is local.

20. LOADING STATE
   Parent page controls loading representation.

21. EMPTY STATE
   Parent page controls empty results.

22. OFFLINE BEHAVIOUR
   Offline-ready status is shown as a non-color-only label.

23. SECURITY CONSIDERATIONS
   No credentials or private configuration shown.

24. PERFORMANCE OPTIMIZATIONS
   Stateless reusable card with bounded language chip display.

25. WIDGET TREE OVERVIEW
   AnimatedContainer → ListTile/header → description → metadata → languages.

26. COMPLETE TESTING CHECKLIST
   Verify responsive width, long text, touch targets, screen reader labels,
   dark mode, selection animation, and large text.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/ai_model_entity.dart';

class AiModelCard extends StatelessWidget {
  const AiModelCard({
    super.key,
    required this.model,
    required this.isSelected,
    required this.onSelect,
  });

  final AiModelEntity model;
  final bool isSelected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: isSelected ? scheme.primaryContainer : scheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isSelected
              ? scheme.primary
              : scheme.outlineVariant.withValues(alpha: 0.75),
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ModelIcon(category: model.category),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        model.family,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                if (model.isRecommended)
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Icon(
                      Icons.star_rounded,
                      semanticLabel: 'Recommended model',
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              model.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.45,
                color: scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 7,
              runSpacing: 7,
              children: [
                _InfoPill(
                  icon: Icons.category_outlined,
                  label: _categoryLabel(model.category),
                ),
                _InfoPill(
                  icon: Icons.bolt_outlined,
                  label: model.performanceLabel,
                ),
                _InfoPill(
                  icon: _statusIcon(model.status),
                  label: _statusLabel(model.status),
                ),
                if (model.isOfflineReady)
                  const _InfoPill(
                    icon: Icons.cloud_off_outlined,
                    label: 'Offline ready',
                  ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              model.primaryUse,
              style: theme.textTheme.labelLarge?.copyWith(
                color: scheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 9),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: model.languages
                  .take(5)
                  .map(
                    (language) => Chip(
                      label: Text(language),
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                    ),
                  )
                  .toList(growable: false),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: FilledButton.tonalIcon(
                onPressed: onSelect,
                icon: Icon(
                  isSelected ? Icons.check_circle_outline : Icons.tune_outlined,
                ),
                label: Text(isSelected ? 'Selected' : 'View model'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _categoryLabel(AiModelCategory category) {
    switch (category) {
      case AiModelCategory.speechRecognition:
        return 'Speech';
      case AiModelCategory.translation:
        return 'Translation';
      case AiModelCategory.contextualLanguage:
        return 'Context';
      case AiModelCategory.textToSpeech:
        return 'Voice';
      case AiModelCategory.runtime:
        return 'Runtime';
      case AiModelCategory.optimization:
        return 'Optimization';
    }
  }

  IconData _statusIcon(AiModelStatus status) {
    switch (status) {
      case AiModelStatus.active:
        return Icons.check_circle_outline;
      case AiModelStatus.available:
        return Icons.download_done_outlined;
      case AiModelStatus.offlineReady:
        return Icons.cloud_off_outlined;
      case AiModelStatus.processing:
        return Icons.sync_outlined;
      case AiModelStatus.unavailable:
        return Icons.error_outline;
    }
  }

  String _statusLabel(AiModelStatus status) {
    switch (status) {
      case AiModelStatus.active:
        return 'Active';
      case AiModelStatus.available:
        return 'Available';
      case AiModelStatus.offlineReady:
        return 'Offline ready';
      case AiModelStatus.processing:
        return 'Processing';
      case AiModelStatus.unavailable:
        return 'Unavailable';
    }
  }
}

class _ModelIcon extends StatelessWidget {
  const _ModelIcon({required this.category});

  final AiModelCategory category;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(
        _icon,
        color: scheme.onSecondaryContainer,
        semanticLabel: 'AI model category',
      ),
    );
  }

  IconData get _icon {
    switch (category) {
      case AiModelCategory.speechRecognition:
        return Icons.graphic_eq;
      case AiModelCategory.translation:
        return Icons.translate;
      case AiModelCategory.contextualLanguage:
        return Icons.psychology_outlined;
      case AiModelCategory.textToSpeech:
        return Icons.record_voice_over_outlined;
      case AiModelCategory.runtime:
        return Icons.memory_outlined;
      case AiModelCategory.optimization:
        return Icons.speed_outlined;
    }
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
