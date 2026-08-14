/*
1. PAGE NAME
   Home Feature Grid

2. PURPOSE
   Presents LinguaLive's main communication entry points.

3. DESCRIPTION
   Responsive Material 3 feature cards for Live Speech, Call Caption, Chat,
   Translation, and QR Session.

4. UI SECTIONS
   Feature cards.

5. NAVIGATION FLOW
   Home → selected communication feature.

6. DYNAMIC COMPONENTS
   Feature title, subtitle, status, and action.

7. FUTURE BACKEND INTEGRATION
   Future: route each selected feature to its dedicated module; the Home grid
   is the primary feature-discovery surface.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   HomeFeatureEntity.

10. FUTURE API ENDPOINTS
    None.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    mic, phone_in_talk, forum, translate, qr_code.

14. THEME COLORS
    Active Material 3 ColorScheme.

15. ANIMATIONS
    Material InkWell feedback.

16. ACCESSIBILITY
    Entire card is actionable with text labels.

17. EDGE CASES
    Long subtitles and narrow layouts.

18. VALIDATION RULES
    Each feature must have a valid callback.

19. ERROR HANDLING
    Not applicable.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Empty list displays nothing; parent can supply an empty state.

22. OFFLINE BEHAVIOUR
    Cards remain visual entry points; real availability is future functionality.

23. SECURITY CONSIDERATIONS
    No data processing.

24. PERFORMANCE OPTIMIZATIONS
    Small stateless cards and bounded Wrap layout.

25. WIDGET TREE OVERVIEW
    LayoutBuilder → Wrap → FeatureCard.

26. COMPLETE TESTING CHECKLIST
    Responsive columns, overflow, touch targets, semantics, dark mode,
    large text, all feature callbacks.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/home_feature_entity.dart';

class HomeFeatureGrid extends StatelessWidget {
  final List<HomeFeatureEntity> features;
  final ValueChanged<HomeFeatureEntity> onFeaturePressed;

  const HomeFeatureGrid({
    super.key,
    required this.features,
    required this.onFeaturePressed,
  });

  IconData _iconFor(String id) {
    switch (id) {
      case 'live_speech':
        return Icons.mic_rounded;
      case 'call_caption':
        return Icons.phone_in_talk_rounded;
      case 'chat':
        return Icons.forum_rounded;
      case 'translation':
        return Icons.translate_rounded;
      case 'qr_session':
        return Icons.qr_code_2_rounded;
      default:
        return Icons.extension_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final int columns;

        if (constraints.maxWidth >= 900) {
          columns = 3;
        } else if (constraints.maxWidth >= 560) {
          columns = 2;
        } else {
          columns = 1;
        }

        const double spacing = 12;
        final double width =
            (constraints.maxWidth - (spacing * (columns - 1))) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: features
              .map(
                (HomeFeatureEntity feature) => SizedBox(
                  width: width,
                  child: _FeatureCard(
                    feature: feature,
                    icon: _iconFor(feature.id),
                    onPressed: () => onFeaturePressed(feature),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final HomeFeatureEntity feature;
  final IconData icon;
  final VoidCallback onPressed;

  const _FeatureCard({
    required this.feature,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: <Widget>[
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: theme.colorScheme.onSecondaryContainer,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      feature.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      feature.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      feature.status,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_rounded, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
