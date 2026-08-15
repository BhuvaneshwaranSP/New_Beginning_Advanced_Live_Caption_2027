/*
1. PAGE NAME
   Accessibility Page

2. PURPOSE
   Provides LinguaLive's first-class accessibility configuration experience.

3. DESCRIPTION
   Allows users to adjust text size, caption size, high contrast, reduced
   motion, screen-reader support, spoken output, visual alerts, haptic
   feedback, and communication preferences.

4. UI SECTIONS
   Header
   Accessibility introduction
   Communication preview
   Accessibility settings
   Communication preferences
   Local state feedback

5. NAVIGATION FLOW
   Settings/Profile/Onboarding → Accessibility → Back to previous screen.

6. DYNAMIC COMPONENTS
   Text size slider, caption size slider, switches, communication preferences,
   and local state demonstrations.

7. FUTURE BACKEND INTEGRATION
   Future: connect controller preference changes to the project's supported
   preference repository so settings can be restored across sessions.
   Future: connect live communication presentation to these preferences so
   captions, translations, readable text, and optional spoken output follow
   the user's selected accessibility mode.

8. TECHNOLOGIES USED
   Flutter Material 3, local ChangeNotifier state.

9. REQUIRED DATA MODELS
   AccessibilitySettingEntity and CommunicationPreferenceEntity.

10. FUTURE API ENDPOINTS
    None are defined by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    None are defined for the UI-only implementation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons only.

14. THEME COLORS
    Material 3 ColorScheme; no hard-coded brand colors.

15. ANIMATIONS
    Lightweight AnimatedSwitcher and AnimatedContainer transitions.

16. ACCESSIBILITY
    Semantic labels, explicit control descriptions, readable contrast,
    large-text compatibility, touch-friendly controls, and non-color-only
    selection states.

17. EDGE CASES
    Narrow phones, tablets, landscape, dark mode, large system text,
    long multilingual strings, disabled communication modalities, and
    reduced-motion preference.

18. VALIDATION RULES
    Text and caption scales remain between 0.85× and 1.35×.

19. ERROR HANDLING
    A local error state can be demonstrated and reset through retry.

20. LOADING STATE
    A local loading state can be demonstrated without external services.

21. EMPTY STATE
    A local empty state can be demonstrated without external services.

22. OFFLINE BEHAVIOUR
    Accessibility controls remain usable because this implementation has
    no network dependency.

23. SECURITY CONSIDERATIONS
    No accessibility preference is transmitted or persisted by this UI-only
    implementation.

24. PERFORMANCE OPTIMIZATIONS
    Uses local ChangeNotifier state, const widgets where possible, bounded
    lists, and lightweight implicit animations.

25. WIDGET TREE OVERVIEW
    Scaffold
      → SafeArea
        → LayoutBuilder
          → CustomScrollView
            → Header
            → Intro
            → Preview
            → Accessibility settings
            → Communication preferences
            → State feedback

26. COMPLETE TESTING CHECKLIST
    Test layout/overflow, keyboard independence, phone/tablet sizes,
    portrait/landscape, dark mode, large text, screen reader semantics,
    loading/error/empty/ready states, controls, preference transitions,
    reduced motion, localization wrapping, navigation, performance,
    and offline usability.
*/

import 'package:flutter/material.dart';

import '../controllers/accessibility_controller.dart';
import '../widgets/accessibility_header.dart';
import '../widgets/accessibility_preview_card.dart';
import '../widgets/accessibility_setting_tile.dart';
import '../widgets/accessibility_states.dart';
import '../widgets/communication_preferences_card.dart';

class AccessibilityPage extends StatefulWidget {
  const AccessibilityPage({super.key});

  @override
  State<AccessibilityPage> createState() => _AccessibilityPageState();
}

class _AccessibilityPageState extends State<AccessibilityPage> {
  late final AccessibilityController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AccessibilityController()..addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onControllerChanged)
      ..dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  AccessibilityViewState get _viewState {
    if (_controller.isLoading) {
      return AccessibilityViewState.loading;
    }

    if (_controller.hasError) {
      return AccessibilityViewState.error;
    }

    if (_controller.isEmpty) {
      return AccessibilityViewState.empty;
    }

    return AccessibilityViewState.ready;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Accessibility'), centerTitle: false),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth >= 700 ? 32.0 : 18.0;
            final maxWidth = constraints.maxWidth >= 1000 ? 820.0 : 760.0;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        18,
                        horizontalPadding,
                        36,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          AccessibilityHeader(
                            onBack: () {
                              Navigator.of(context).maybePop();
                            },
                          ),
                          const SizedBox(height: 22),
                          Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer
                                  .withValues(alpha: 0.55),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.forum_outlined,
                                  color: theme.colorScheme.onPrimaryContainer,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'LinguaLive can combine captions, translation, '
                                    'readable text, and optional spoken output so '
                                    'communication does not depend on one sense alone.',
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color:
                                          theme.colorScheme.onPrimaryContainer,
                                      height: 1.45,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 18),
                          AccessibilityPreviewCard(
                            textScale: _controller.textScale,
                            captionScale: _controller.captionScale,
                            captionsEnabled:
                                _controller.isEnabled('screen_reader') ||
                                _controller.preferences.any(
                                  (item) =>
                                      item.id == 'captions' && item.selected,
                                ),
                            translationEnabled: _controller.preferences.any(
                              (item) =>
                                  item.id == 'translation' && item.selected,
                            ),
                            spokenOutputEnabled: _controller.isEnabled(
                              'spoken_output',
                            ),
                          ),
                          const SizedBox(height: 26),
                          Text(
                            'Accessibility controls',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10),
                          AccessibilitySettingTile(
                            setting: _controller.settings.firstWhere(
                              (item) => item.id == 'text_size',
                            ),
                            value: _controller.textScale,
                            valueLabel:
                                '${_controller.textScale.toStringAsFixed(2)}×',
                            onToggle: () {
                              _controller.toggleSetting('text_size');
                            },
                            onValueChanged: _controller.setTextScale,
                          ),
                          const SizedBox(height: 10),
                          AccessibilitySettingTile(
                            setting: _controller.settings.firstWhere(
                              (item) => item.id == 'caption_size',
                            ),
                            value: _controller.captionScale,
                            valueLabel:
                                '${_controller.captionScale.toStringAsFixed(2)}×',
                            onToggle: () {
                              _controller.toggleSetting('caption_size');
                            },
                            onValueChanged: _controller.setCaptionScale,
                          ),
                          const SizedBox(height: 10),
                          for (final setting in _controller.settings.skip(
                            2,
                          )) ...[
                            AccessibilitySettingTile(
                              setting: setting,
                              onToggle: () {
                                _controller.toggleSetting(setting.id);
                              },
                            ),
                            const SizedBox(height: 10),
                          ],
                          const SizedBox(height: 12),
                          CommunicationPreferencesCard(
                            preferences: _controller.preferences,
                            onToggle: _controller.togglePreference,
                          ),
                          const SizedBox(height: 18),
                          AccessibilityStates(
                            state: _viewState,
                            onRetry: _controller.retry,
                          ),
                          const SizedBox(height: 18),
                          _LocalStateDemoBar(
                            onLoading: _controller.simulateLoading,
                            onError: _controller.simulateError,
                            onReset: _controller.retry,
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LocalStateDemoBar extends StatelessWidget {
  const _LocalStateDemoBar({
    required this.onLoading,
    required this.onError,
    required this.onReset,
  });

  final VoidCallback onLoading;
  final VoidCallback onError;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: 'Local accessibility state preview controls',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          OutlinedButton.icon(
            onPressed: onLoading,
            icon: const Icon(Icons.sync),
            label: const Text('Preview loading'),
          ),
          OutlinedButton.icon(
            onPressed: onError,
            icon: const Icon(Icons.error_outline),
            label: const Text('Preview error'),
          ),
          TextButton(onPressed: onReset, child: const Text('Reset preview')),
        ],
      ),
    );
  }
}
