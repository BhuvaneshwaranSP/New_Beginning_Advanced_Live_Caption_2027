/*
1. PAGE NAME
   Settings Page

2. PURPOSE
   Provides the main LinguaLive Settings interface.

3. DESCRIPTION
   A responsive Material 3 settings experience focused on the preferences
   directly relevant to LinguaLive's multilingual communication workflow:
   source and target languages, live captions, contextual translation,
   translated speech, offline preference, and appearance.

4. UI SECTIONS
   - Settings introduction
   - Language
   - Communication
   - Connectivity
   - Appearance
   - Information
   - Offline preview state

5. NAVIGATION FLOW
   Application → SettingsPage.
   Individual selection/information tiles currently expose empty UI callbacks.
   No future navigation behavior is implemented.

6. DYNAMIC COMPONENTS
   - Source language
   - Target language
   - Live captions switch
   - Context-aware translation switch
   - Translated speech switch
   - Offline preference
   - Appearance mode
   - Local offline preview

7. FUTURE BACKEND INTEGRATION
   Future: connect settings changes to the project's persistence layer so
   selected languages and communication preferences survive app restarts.
   Future: connect language selection to the project's supported language
   configuration when the real language catalog is available.
   Future: connect communication preferences to the intended speech,
   translation, and caption processing pipeline.

8. TECHNOLOGIES USED
   Dart, Flutter, Material 3, ValueNotifier.

9. REQUIRED DATA MODELS
   SettingsFeatureModel and SettingsFeatureEntity.

10. FUTURE API ENDPOINTS
    None specified by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    None specified by the supplied project documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Uses the active application's Material 3 ColorScheme.

15. ANIMATIONS
    Lightweight AnimatedSwitcher for the offline preview.

16. ACCESSIBILITY
    - Semantic page header
    - Semantic setting descriptions
    - Native Switch controls
    - Adequate touch targets
    - No status communicated by color alone
    - Responsive text layout

17. EDGE CASES
    - Small phone width
    - Tablet width
    - Landscape orientation
    - Large text
    - Long setting labels
    - Empty data
    - Loading state
    - Error state
    - Offline preview
    - Dark theme

18. VALIDATION RULES
    Only predefined local appearance and connectivity values are accepted.
    No real language validation or backend validation is performed.

19. ERROR HANDLING
    Local presentation error state with retry callback.

20. LOADING STATE
    Local loading representation is available.

21. EMPTY STATE
    Local empty representation is available.

22. OFFLINE BEHAVIOUR
    The UI remains usable with an explicit local offline preview.

23. SECURITY CONSIDERATIONS
    No authentication credentials, tokens, personal data, or secrets
    are processed by this UI.

24. PERFORMANCE OPTIMIZATIONS
    - ValueNotifier for focused state changes
    - Const widgets where possible
    - No external state-management package
    - No network operations
    - No expensive custom painting

25. WIDGET TREE OVERVIEW
    Scaffold
      → AppBar
      → SafeArea
        → CustomScrollView
          → Header
          → Offline banner
          → Language section
          → Communication section
          → Connectivity section
          → Appearance section
          → Information section

26. COMPLETE TESTING CHECKLIST
    - Layout/overflow
    - Keyboard
    - Orientation
    - Phone/tablet responsiveness
    - Dark mode
    - Large text
    - Screen reader
    - Loading
    - Empty
    - Error/retry
    - Offline
    - Long labels
    - Switch transitions
    - Appearance selection
    - Connectivity selection
    - Accessibility semantics
    - Animation smoothness
    - Performance
    - Memory/disposal
    - Localization readiness
*/

import 'package:flutter/material.dart';

import '../../domain/entities/settings_feature_entity.dart';
import '../controllers/settings_controller.dart';
import '../widgets/settings_header.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_states.dart';
import '../widgets/settings_tile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final SettingsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SettingsController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showSelectionSheet({
    required String title,
    required List<String> options,
    required String currentValue,
    required ValueChanged<String> onSelected,
  }) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 4),
              ...options.map(
                (option) => RadioListTile<String>(
                  value: option,
                  groupValue: currentValue,
                  title: Text(option),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }

                    onSelected(value);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageSection() {
    final settings = _controller.languageSettings;

    return SettingsSection(
      title: 'Language',
      children: [
        SettingsTile(
          setting: settings.firstWhere((item) => item.id == 'source_language'),
          onTap: () {
            _showSelectionSheet(
              title: 'Source language',
              options: const [
                'English',
                'Tamil',
                'Telugu',
                'Hindi',
                'Malayalam',
              ],
              currentValue: 'English',
              onSelected: (value) {
                // Future: connect the selected source language to the project's
                // language configuration used by the recognition pipeline.
              },
            );
          },
        ),
        const Divider(height: 1),
        SettingsTile(
          setting: settings.firstWhere((item) => item.id == 'target_language'),
          onTap: () {
            _showSelectionSheet(
              title: 'Target language',
              options: const [
                'Tamil',
                'English',
                'Telugu',
                'Hindi',
                'Malayalam',
              ],
              currentValue: 'Tamil',
              onSelected: (value) {
                // Future: connect the selected target language to the project's
                // translation pipeline for translated text and speech output.
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildCommunicationSection() {
    final settings = _controller.communicationSettings;

    return SettingsSection(
      title: 'Communication',
      children: [
        ValueListenableBuilder<bool>(
          valueListenable: _controller.liveCaptionsEnabled,
          builder: (context, enabled, child) {
            return SettingsTile(
              setting: settings.firstWhere(
                (item) => item.id == 'live_captions',
              ),
              switchValue: enabled,
              onSwitchChanged: _controller.setLiveCaptions,
            );
          },
        ),
        const Divider(height: 1),
        ValueListenableBuilder<bool>(
          valueListenable: _controller.contextTranslationEnabled,
          builder: (context, enabled, child) {
            return SettingsTile(
              setting: settings.firstWhere(
                (item) => item.id == 'context_translation',
              ),
              switchValue: enabled,
              onSwitchChanged: _controller.setContextTranslation,
            );
          },
        ),
        const Divider(height: 1),
        ValueListenableBuilder<bool>(
          valueListenable: _controller.translatedSpeechEnabled,
          builder: (context, enabled, child) {
            return SettingsTile(
              setting: settings.firstWhere(
                (item) => item.id == 'text_to_speech',
              ),
              switchValue: enabled,
              onSwitchChanged: _controller.setTranslatedSpeech,
            );
          },
        ),
      ],
    );
  }

  Widget _buildConnectivitySection() {
    final settings = _controller.connectivitySettings;

    return ValueListenableBuilder<String>(
      valueListenable: _controller.offlinePreference,
      builder: (context, preference, child) {
        return SettingsSection(
          title: 'Connectivity',
          children: [
            SettingsTile(
              setting: settings.firstWhere((item) => item.id == 'offline_mode'),
              onTap: () {
                _showSelectionSheet(
                  title: 'Offline mode preference',
                  options: const ['Automatic', 'Offline first', 'Online first'],
                  currentValue: preference,
                  onSelected: _controller.setOfflinePreference,
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildAppearanceSection() {
    final settings = _controller.appearanceSettings;

    return ValueListenableBuilder<String>(
      valueListenable: _controller.appearance,
      builder: (context, appearance, child) {
        return SettingsSection(
          title: 'Appearance',
          children: [
            SettingsTile(
              setting: SettingsFeatureEntity(
                id: settings.first.id,
                title: settings.first.title,
                description: settings.first.description,
                value: appearance,
                icon: settings.first.icon,
                controlType: settings.first.controlType,
                enabled: settings.first.enabled,
              ),
              onTap: () {
                _showSelectionSheet(
                  title: 'Appearance',
                  options: const ['System', 'Light', 'Dark'],
                  currentValue: appearance,
                  onSelected: _controller.setAppearance,
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildInformationSection() {
    final settings = _controller.informationSettings;

    return SettingsSection(
      title: 'Information',
      children: [
        SettingsTile(
          setting: settings.firstWhere((item) => item.id == 'privacy'),
          onTap: () {
            // Future: open the project's privacy information surface when
            // the corresponding application route is defined.
          },
        ),
        const Divider(height: 1),
        SettingsTile(
          setting: settings.firstWhere((item) => item.id == 'about'),
          onTap: () {
            // Future: open the project's About feature route when navigation
            // integration for the About module is connected.
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: false),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxContentWidth = constraints.maxWidth >= 900
                ? 760.0
                : double.infinity;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxContentWidth),
                child: ValueListenableBuilder<bool>(
                  valueListenable: _controller.isLoading,
                  builder: (context, loading, child) {
                    if (loading) {
                      return const SettingsLoadingState();
                    }

                    return ValueListenableBuilder<bool>(
                      valueListenable: _controller.isOffline,
                      builder: (context, offline, child) {
                        return CustomScrollView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          slivers: [
                            SliverPadding(
                              padding: const EdgeInsets.fromLTRB(
                                20,
                                20,
                                20,
                                32,
                              ),
                              sliver: SliverList(
                                delegate: SliverChildListDelegate([
                                  const SettingsHeader(),
                                  const SizedBox(height: 18),
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 220),
                                    child: offline
                                        ? const SettingsOfflineBanner(
                                            key: ValueKey('offline'),
                                          )
                                        : const SizedBox.shrink(
                                            key: ValueKey('online'),
                                          ),
                                  ),
                                  if (offline) const SizedBox(height: 18),
                                  _buildLanguageSection(),
                                  const SizedBox(height: 24),
                                  _buildCommunicationSection(),
                                  const SizedBox(height: 24),
                                  _buildConnectivitySection(),
                                  const SizedBox(height: 24),
                                  _buildAppearanceSection(),
                                  const SizedBox(height: 24),
                                  _buildInformationSection(),
                                  const SizedBox(height: 28),
                                  _buildPreviewControls(),
                                ]),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPreviewControls() {
    return ValueListenableBuilder<bool>(
      valueListenable: _controller.isOffline,
      builder: (context, offline, child) {
        final theme = Theme.of(context);

        return Semantics(
          container: true,
          label: 'UI-only offline preview control',
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 0,
            color: theme.colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    offline ? Icons.wifi_off_rounded : Icons.wifi_rounded,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Offline preview',
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: theme.colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Preview how the settings screen communicates local availability.',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onPrimaryContainer,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Switch(
                    value: offline,
                    onChanged: _controller.setOfflinePreview,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
