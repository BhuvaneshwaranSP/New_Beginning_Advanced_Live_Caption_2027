/*
1. PAGE NAME
   Transcription Page

2. PURPOSE
   Provides the main LinguaLive multilingual transcription workspace.

3. DESCRIPTION
   Displays source/target languages, live transcription status, speaker-wise
   transcript segments, translated text, confidence, and local controls.
   All displayed content is dummy UI data. No speech recognition, translation,
   networking, persistence, audio processing, or backend functionality exists.

4. UI SECTIONS
   - Transcription header
   - Source/target language pair
   - Session information
   - Transcript list
   - Live/paused status
   - Bottom control panel

5. NAVIGATION FLOW
   Application → Transcription Page.
   The back callback is intentionally empty because application routing is
   outside this UI-only module.

6. DYNAMIC COMPONENTS
   - Loading state
   - Live state
   - Paused state
   - Empty state
   - Error state
   - Offline state
   - Speaker transcript cards
   - Confidence indicators

7. FUTURE BACKEND INTEGRATION
   Future: connect microphone input, streaming ASR, language detection,
   translation, contextual correction, and real-time transcript events at
   the controller/data-source boundary; those services belong outside the
   presentation widgets.

8. TECHNOLOGIES USED
   Flutter Material 3, Dart local state, ChangeNotifier.

9. REQUIRED DATA MODELS
   TranscriptionEntity and TranscriptionModel.

10. FUTURE API ENDPOINTS
    Not defined in the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not defined for this screen's UI-only implementation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Application Material 3 ColorScheme; no hard-coded brand palette.

15. ANIMATIONS
    AnimatedContainer for transcript cards and AnimatedSwitcher for state
    changes.

16. ACCESSIBILITY
    - Semantic status labels
    - Text-based confidence information
    - Tooltips on icon buttons
    - Large touch targets
    - Flexible text layout
    - No color-only status communication

17. EDGE CASES
    - Empty transcript
    - Long multilingual transcript
    - Error state
    - Offline state
    - Paused processing
    - Large accessibility text
    - Small phone width
    - Tablet width
    - Landscape orientation

18. VALIDATION RULES
    UI-only validation. No server or audio validation.

19. ERROR HANDLING
    Local error state with retry callback.

20. LOADING STATE
    Local preparation state before dummy data is displayed.

21. EMPTY STATE
    Informative no-transcript state.

22. OFFLINE BEHAVIOUR
    Offline preview state is available locally. No connectivity detection
    is implemented.

23. SECURITY CONSIDERATIONS
    No authentication, network communication, audio capture, persistence,
    or real personal data.

24. PERFORMANCE OPTIMIZATIONS
    - Immutable dummy data
    - Reusable stateless widgets
    - Constrained content width
    - ListView.builder
    - Minimal controller notifications

25. WIDGET TREE OVERVIEW
    Scaffold
      └── SafeArea
          └── LayoutBuilder
              └── Center
                  └── ConstrainedBox
                      └── Column
                          ├── TranscriptionHeader
                          ├── LanguagePairCard
                          └── Expanded
                              └── AnimatedSwitcher
                                  ├── Loading/Empty/Error/Offline
                                  └── Column
                                      ├── Session summary
                                      ├── Transcript list
                                      └── Controls

26. COMPLETE TESTING CHECKLIST
    - Layout/overflow
    - Keyboard interaction
    - Orientation
    - Phone/tablet responsiveness
    - Dark mode
    - Large text
    - Screen reader/accessibility
    - Loading
    - Empty
    - Error/retry
    - Success/live
    - Offline
    - Long/null/invalid data
    - Navigation callback
    - State transitions
    - Future streaming integration boundary
    - Animation
    - Performance
    - Memory
    - Localization readiness
*/

import 'package:flutter/material.dart';

import '../controllers/transcription_controller.dart';
import '../widgets/language_pair_card.dart';
import '../widgets/transcript_segment_card.dart';
import '../widgets/transcription_header.dart';
import '../widgets/transcription_states.dart';

class TranscriptionPage extends StatefulWidget {
  const TranscriptionPage({
    super.key,
  });

  @override
  State<TranscriptionPage> createState() => _TranscriptionPageState();
}

class _TranscriptionPageState extends State<TranscriptionPage> {
  late final TranscriptionController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TranscriptionController();
    _controller.load();
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
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final horizontalPadding =
                    constraints.maxWidth >= 900 ? 32.0 : 18.0;

                return Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 980,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: 18,
                      ),
                      child: Column(
                        children: [
                          TranscriptionHeader(
                            statusLabel: _statusLabel,
                            statusIcon: _statusIcon,
                            onBack: () {},
                          ),
                          const SizedBox(height: 18),
                          const LanguagePairCard(
                            sourceLanguage: 'English',
                            targetLanguage: 'Tamil',
                          ),
                          const SizedBox(height: 18),
                          Expanded(
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 220),
                              child: _buildContent(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent() {
    switch (_controller.status) {
      case TranscriptionStatus.loading:
        return const TranscriptionLoadingState();

      case TranscriptionStatus.empty:
        return Column(
          key: const ValueKey('empty'),
          children: [
            const Expanded(
              child: TranscriptionEmptyState(),
            ),
            _buildControls(),
          ],
        );

      case TranscriptionStatus.error:
        return Column(
          key: const ValueKey('error'),
          children: [
            Expanded(
              child: TranscriptionErrorState(
                onRetry: _controller.retry,
              ),
            ),
            _buildControls(),
          ],
        );

      case TranscriptionStatus.offline:
        return Column(
          key: const ValueKey('offline'),
          children: [
            const TranscriptionOfflineState(),
            const Spacer(),
            Expanded(
              child: _buildTranscriptList(),
            ),
            _buildControls(),
          ],
        );

      case TranscriptionStatus.live:
      case TranscriptionStatus.paused:
        return Column(
          key: ValueKey(_controller.status),
          children: [
            _buildSessionSummary(),
            const SizedBox(height: 12),
            Expanded(
              child: _buildTranscriptList(),
            ),
            const SizedBox(height: 10),
            _buildControls(),
          ],
        );
    }
  }

  Widget _buildSessionSummary() {
    final theme = Theme.of(context);
    final isLive = _controller.status == TranscriptionStatus.live;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: isLive
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outline,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              isLive
                  ? 'Listening • Translating in real time'
                  : 'Transcription paused',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            '${_controller.segments.length} segments',
            style: theme.textTheme.labelMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildTranscriptList() {
    return ListView.builder(
      key: const PageStorageKey<String>('transcript-list'),
      padding: const EdgeInsets.only(top: 2),
      itemCount: _controller.segments.length,
      itemBuilder: (context, index) {
        return TranscriptSegmentCard(
          segment: _controller.segments[index],
          index: index,
        );
      },
    );
  }

  Widget _buildControls() {
    final theme = Theme.of(context);
    final isLive = _controller.status == TranscriptionStatus.live;

    return Material(
      color: theme.colorScheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(22),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _controller.clearTranscript,
                icon: const Icon(Icons.delete_outline_rounded),
                label: const Text('Clear'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: FilledButton.icon(
                onPressed: _controller.toggleRecording,
                icon: Icon(
                  isLive
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
                ),
                label: Text(
                  isLive ? 'Pause' : 'Resume',
                ),
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: _controller.showOfflineState,
              tooltip: 'Preview offline state',
              icon: const Icon(Icons.cloud_off_rounded),
            ),
          ],
        ),
      ),
    );
  }

  String get _statusLabel {
    switch (_controller.status) {
      case TranscriptionStatus.loading:
        return 'Preparing';
      case TranscriptionStatus.live:
        return 'Live';
      case TranscriptionStatus.paused:
        return 'Paused';
      case TranscriptionStatus.empty:
        return 'Ready';
      case TranscriptionStatus.error:
        return 'Error';
      case TranscriptionStatus.offline:
        return 'Offline';
    }
  }

  IconData get _statusIcon {
    switch (_controller.status) {
      case TranscriptionStatus.loading:
        return Icons.hourglass_top_rounded;
      case TranscriptionStatus.live:
        return Icons.graphic_eq_rounded;
      case TranscriptionStatus.paused:
        return Icons.pause_circle_outline_rounded;
      case TranscriptionStatus.empty:
        return Icons.notes_rounded;
      case TranscriptionStatus.error:
        return Icons.error_outline_rounded;
      case TranscriptionStatus.offline:
        return Icons.cloud_off_rounded;
    }
  }
}