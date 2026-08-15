/*
1. PAGE NAME
   Accessibility Setting Tile

2. PURPOSE
   Provides a reusable control for accessibility preferences.

3. DESCRIPTION
   Supports switches and bounded scale controls without external state
   management.

4. UI SECTIONS
   Icon, title, description, and optional slider.

5. NAVIGATION FLOW
   AccessibilityPage → setting tile.

6. DYNAMIC COMPONENTS
   Switch and slider.

7. FUTURE BACKEND INTEGRATION
   Future: persist the changed preference through the supported application
   preference repository at the controller callback.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   AccessibilitySettingEntity.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    None specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Supplied by the entity.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    Native switch and slider transitions.

16. ACCESSIBILITY
    Entire control has readable semantic labels.

17. EDGE CASES
    Narrow layouts and large text.

18. VALIDATION RULES
    Slider values are bounded by the controller.

19. ERROR HANDLING
    None required locally.

20. LOADING STATE
    Parent controls loading representation.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Local state remains interactive.

23. SECURITY CONSIDERATIONS
    No data transmission.

24. PERFORMANCE OPTIMIZATIONS
    Stateless reusable widget.

25. WIDGET TREE OVERVIEW
    ListTile → icon/title/description → control.

26. COMPLETE TESTING CHECKLIST
    Verify touch target, semantics, large text, dark mode, and slider labels.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/accessibility_feature_entity.dart';

class AccessibilitySettingTile extends StatelessWidget {
  const AccessibilitySettingTile({
    super.key,
    required this.setting,
    required this.onToggle,
    this.value,
    this.onValueChanged,
    this.valueLabel,
  });

  final AccessibilitySettingEntity setting;
  final VoidCallback onToggle;
  final double? value;
  final ValueChanged<double>? onValueChanged;
  final String? valueLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isSlider = value != null && onValueChanged != null;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          children: [
            Semantics(
              container: true,
              label: '${setting.title}. ${setting.description}',
              child: ListTile(
                minVerticalPadding: 8,
                leading: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(setting.icon),
                ),
                title: Text(
                  setting.title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(setting.description),
                ),
                trailing: isSlider
                    ? Text(
                        valueLabel ?? '${value!.toStringAsFixed(1)}×',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    : Switch(
                        value: setting.enabled,
                        onChanged: (_) => onToggle(),
                      ),
              ),
            ),
            if (isSlider)
              Padding(
                padding: const EdgeInsets.fromLTRB(58, 0, 12, 4),
                child: Slider(
                  value: value!,
                  min: 0.85,
                  max: 1.35,
                  divisions: 5,
                  label: '${value!.toStringAsFixed(2)}×',
                  onChanged: onValueChanged,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
