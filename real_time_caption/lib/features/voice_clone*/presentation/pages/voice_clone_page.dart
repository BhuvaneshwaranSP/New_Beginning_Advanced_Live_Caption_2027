/*
1. PAGE NAME
   Voice Clone Page

2. PURPOSE
   Provides LinguaLive's UI-only voice-profile preparation experience.

3. DESCRIPTION
   Users can inspect local multilingual voice profiles, select one, and
   preview recording/processing states. No microphone, audio processing,
   voice synthesis, API, persistence, or real cloning is performed.

4. UI SECTIONS
   App bar, introductory header, profile list, selected profile summary,
   controls, privacy note, and offline-safe information.

5. NAVIGATION FLOW
   Feature entry → Voice Clone page.
   Page-level callbacks are intentionally empty because no future navigation
   behavior is defined for this screen by the supplied project flow.

6. DYNAMIC COMPONENTS
   Voice profiles, selection state, recording state, processing state,
   error state, and offline information.

7. FUTURE BACKEND INTEGRATION
   A future approved voice-profile workflow can connect at the controller's
   recording and processing integration boundaries. The supplied project
   documentation does not specify a dedicated voice-cloning API, database,
   or cloning algorithm, so none is invented here.

8. TECHNOLOGIES USED
   Flutter Material 3 and built-in ChangeNotifier.

9. REQUIRED DATA MODELS
   VoiceCloneEntity and VoiceCloneModel.

10. FUTURE API ENDPOINTS
    Not defined by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not defined by the supplied project documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material voice, microphone, privacy, cloud, and status icons.

14. THEME COLORS
    Uses the application's Material 3 ColorScheme.

15. ANIMATIONS
    Lightweight AnimatedContainer and AnimatedSwitcher transitions.

16. ACCESSIBILITY
    Semantic profile selection, descriptive controls, scalable text,
    adequate touch targets, non-color-only status indicators, and
    responsive layouts.

17. EDGE CASES
    Empty profile list, long names, large text, narrow screens, offline
    profile, processing state, error state, and landscape orientation.

18. VALIDATION RULES
    Local controls are disabled when an action is not appropriate.
    No actual audio validation occurs.

19. ERROR HANDLING
    Local error presentation with retry and reset controls.

20. LOADING STATE
    Local loading state before dummy profiles appear.

21. EMPTY STATE
    Dedicated no-profile presentation.

22. OFFLINE BEHAVIOUR
    Displays an offline-safe informational state without network access.

23. SECURITY CONSIDERATIONS
    No microphone permission is requested, no voice biometric data is
    captured, and no recording is persisted or transmitted.

24. PERFORMANCE OPTIMIZATIONS
    Small immutable models, local ChangeNotifier state, const widgets where
    possible, and bounded responsive content width.

25. WIDGET TREE OVERVIEW
    Scaffold
      └── SafeArea
          └── CustomScrollView
              ├── SliverAppBar
              └── SliverToBoxAdapter
                  └── Center
                      └── ConstrainedBox
                          └── Column
                              ├── Header
                              ├── Profile section
                              ├── Selected profile summary
                              ├── Controls
                              └── Privacy information

26. COMPLETE TESTING CHECKLIST
    Layout/overflow, keyboard, orientation, phone/tablet responsiveness,
    dark mode, large text, screen reader, loading, empty, error, success,
    offline, long/null/invalid data, navigation callbacks, state transitions,
    animation, performance, memory, localization readiness, and future
    integration boundaries.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/voice_clone_entity.dart';
import '../controllers/voice_clone_controller.dart';
import '../widgets/voice_clone_controls.dart';
import '../widgets/voice_clone_header.dart';
import '../widgets/voice_clone_states.dart';
import '../widgets/voice_profile_card.dart';

class VoiceClonePage extends StatefulWidget {
  const VoiceClonePage({super.key});

  @override
  State<VoiceClonePage> createState() => _VoiceClonePageState();
}

class _VoiceClonePageState extends State<VoiceClonePage> {
  late final VoiceCloneController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VoiceCloneController()..load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Voice profile'),
            centerTitle: false,
            actions: [
              IconButton(
                tooltip: 'Reset voice profile state',
                onPressed: _controller.reset,
                icon: const Icon(Icons.restart_alt_rounded),
              ),
            ],
          ),
          body: SafeArea(
            child: CustomScrollView(
              keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 760),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                        child: _buildBody(context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_controller.isLoading) {
      return const VoiceCloneLoadingState();
    }

    if (_controller.showError) {
      return VoiceCloneErrorState(
        onRetry: _controller.retry,
      );
    }

    if (_controller.profiles.isEmpty) {
      return const VoiceCloneEmptyState();
    }

    final selectedProfile = _controller.selectedProfile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const VoiceCloneHeader(),
        const SizedBox(height: 28),
        Text(
          'Your voice profiles',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 10),
        Text(
          'Choose the profile you want to prepare.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 14),
        ...List.generate(
          _controller.profiles.length,
          (index) {
            final profile = _controller.profiles[index];

            return Padding(
              padding: EdgeInsets.only(
                bottom: index == _controller.profiles.length - 1 ? 0 : 10,
              ),
              child: VoiceProfileCard(
                profile: profile,
                selected: index == _controller.selectedIndex,
                onTap: () => _controller.selectProfile(index),
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        if (selectedProfile != null) ...[
          _SelectedProfileSummary(profile: selectedProfile),
          const SizedBox(height: 18),
          VoiceCloneControls(
            isRecording: _controller.isRecording,
            isProcessing: _controller.isProcessing,
            enabled: selectedProfile.status != VoiceProfileStatus.offline,
            onRecord: _controller.toggleRecording,
            onProcess: _controller.startProcessingPreview,
            onReset: _controller.reset,
          ),
          const SizedBox(height: 22),
          const VoiceCloneOfflineState(),
        ],
      ],
    );
  }
}

class _SelectedProfileSummary extends StatelessWidget {
  const _SelectedProfileSummary({
    required this.profile,
  });

  final VoiceCloneEntity profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final statusText = switch (profile.status) {
      VoiceProfileStatus.ready => 'Ready for the next supported step',
      VoiceProfileStatus.processing => 'Processing demonstration state',
      VoiceProfileStatus.needsRecording => 'A voice sample is needed',
      VoiceProfileStatus.error => 'Profile needs attention',
      VoiceProfileStatus.offline => 'Offline profile',
    };

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.primaryContainer.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.auto_awesome_rounded,
            color: colors.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${profile.language} • $statusText',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}