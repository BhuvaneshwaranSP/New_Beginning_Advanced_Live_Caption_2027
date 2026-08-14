/*
1. PAGE NAME
   Settings Tile

2. PURPOSE
   Displays an individual Settings preference.

3. DESCRIPTION
   Supports selection, navigation, information, and switch controls while
   keeping all actions UI-only.

4. UI SECTIONS
   Individual settings within a SettingsSection.

5. NAVIGATION FLOW
   SettingsSection → SettingsTile → local callback.

6. DYNAMIC COMPONENTS
   Title, description, value, icon, switch state, and trailing control.

7. FUTURE BACKEND INTEGRATION
   Future: connect the callback to the appropriate preference persistence
   operation; this tile is the exact UI boundary where a preference changes.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   SettingsFeatureEntity.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    None specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 color scheme.

15. ANIMATIONS
    Switch animation supplied by Material.

16. ACCESSIBILITY
    Entire tile has a descriptive semantic label.

17. EDGE CASES
    Long titles, descriptions, and values.

18. VALIDATION RULES
    Switch callbacks must be supplied for switch controls.

19. ERROR HANDLING
    No service errors.

20. LOADING STATE
    Disabled state is supported.

21. EMPTY STATE
    Empty display values are handled safely.

22. OFFLINE BEHAVIOUR
    Local controls remain interactive.

23. SECURITY CONSIDERATIONS
    No sensitive values.

24. PERFORMANCE OPTIMIZATIONS
    Stateless reusable tile.

25. WIDGET TREE OVERVIEW
    Semantics → ListTile → icon → content → trailing control.

26. COMPLETE TESTING CHECKLIST
    Test touch target, switch semantics, text scaling, long values,
    dark mode, and narrow layouts.
*/

import 'package:flutter/material.dart';

import '../../data/models/settings_feature_model.dart';
import '../../domain/entities/settings_feature_entity.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.setting,
    this.switchValue,
    this.onSwitchChanged,
    this.onTap,
  });

  final SettingsFeatureEntity setting;
  final bool? switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final VoidCallback? onTap;

  IconData _iconFor(String icon) {
    switch (icon) {
      case 'language':
        return Icons.language_rounded;
      case 'translate':
        return Icons.translate_rounded;
      case 'closed_caption':
        return Icons.closed_caption_rounded;
      case 'auto_awesome':
        return Icons.auto_awesome_rounded;
      case 'volume_up':
        return Icons.volume_up_rounded;
      case 'cloud_off':
        return Icons.cloud_off_rounded;
      case 'brightness_6':
        return Icons.brightness_6_rounded;
      case 'shield_outlined':
        return Icons.shield_outlined;
      case 'info_outline':
        return Icons.info_outline_rounded;
      default:
        return Icons.settings_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget trailing;

    switch (setting.controlType) {
      case SettingsControlType.switchControl:
        trailing = Switch(
          value: switchValue ?? false,
          onChanged: setting.enabled ? onSwitchChanged : null,
        );
      case SettingsControlType.selection:
        trailing = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                setting.value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right_rounded),
          ],
        );
      case SettingsControlType.navigation:
      case SettingsControlType.information:
        trailing = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              setting.value,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right_rounded),
          ],
        );
    }

    return Semantics(
      button: setting.controlType != SettingsControlType.switchControl,
      toggled: setting.controlType == SettingsControlType.switchControl
          ? switchValue
          : null,
      label: '${setting.title}. ${setting.description}. ${setting.value}',
      child: ListTile(
        enabled: setting.enabled,
        onTap: setting.controlType == SettingsControlType.switchControl
            ? null
            : onTap,
        minVerticalPadding: 12,
        contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 6, 12, 6),
        leading: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: theme.colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(
            _iconFor(setting.icon),
            color: theme.colorScheme.onSecondaryContainer,
            size: 21,
          ),
        ),
        title: Text(
          setting.title,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Text(
            setting.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.3,
            ),
          ),
        ),
        trailing: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 150),
          child: trailing,
        ),
      ),
    );
  }
}
