/*
1. PAGE NAME
   Translation Page

2. PURPOSE
   Provides the main LinguaLive multilingual text translation interface.

3. DESCRIPTION
   A responsive Material 3 screen where users select a source and target
   language, enter multilingual text, and view a local demonstration result.
   It intentionally contains no backend, networking, Firebase, database,
   speech recognition, translation engine, or real AI inference.

4. UI SECTIONS
   - Translation header
   - Source/target language selector
   - Source message editor
   - Translation action
   - Translation result
   - Empty/loading/error/offline states

5. NAVIGATION FLOW
   LinguaLive navigation → TranslationPage.
   Future communication/session/history flows may consume translation results.

6. DYNAMIC COMPONENTS
   - Source language
   - Target language
   - Source text
   - Translation result
   - Processing state
   - Error/offline state

7. FUTURE BACKEND INTEGRATION
   Future: connect the documented pipeline at the translation controller boundary:
   Voice Input → VAD → Noise Reduction → Audio Processing → Language Detection
   → Whisper Speech Recognition → Streaming ASR → NLLB-200 Distilled →
   Gemma contextual/grammar correction → final translated text.
   The current implementation intentionally stops at local dummy data.

8. TECHNOLOGIES USED
   Flutter Material 3, Dart, ChangeNotifier from Flutter foundation.

9. REQUIRED DATA MODELS
   TranslationEntity, TranslationModel, TranslationLanguageDummy.

10. FUTURE API ENDPOINTS
    Not specified by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified by the supplied project documentation.

12. REQUIRED ASSETS
    No page-specific assets required.

13. REQUIRED ICONS
    translate, language, swap, edit, microphone, clear, copy, verified,
    cloud_off, error, and progress icons from Material Icons.

14. THEME COLORS
    Uses the application's Material 3 ColorScheme without hard-coded
    application-specific colors.

15. ANIMATIONS
    AnimatedSwitcher for state/result transitions and lightweight Material
    button progress feedback.

16. ACCESSIBILITY
    Semantic header, descriptive controls, readable labels, visible status
    text, selectable translation text, large-text compatibility, and
    sufficient Material touch targets.

17. EDGE CASES
    Empty text, whitespace-only text, very long text, long language names,
    unsupported dummy language pairs, offline representation, processing,
    error state, keyboard visibility, and landscape layout.

18. VALIDATION RULES
    Translation cannot produce a successful local result for empty input.
    Unsupported local demonstration pairs are represented as an error state.

19. ERROR HANDLING
    Local demonstration errors are rendered without throwing exceptions.

20. LOADING STATE
    Local processing state is displayed before the dummy result.

21. EMPTY STATE
    The result area explains how to begin translation.

22. OFFLINE BEHAVIOUR
    A local offline representation is available through the controller.
    No real connectivity detection is implemented.

23. SECURITY CONSIDERATIONS
    No credentials, network communication, persistence, raw audio, or
    personally identifiable information is processed.

24. PERFORMANCE OPTIMIZATIONS
    Local state only, const widgets, small immutable dummy collections,
    controller-driven rebuilds, and limited AnimatedSwitcher usage.

25. WIDGET TREE OVERVIEW
    Scaffold
      └── SafeArea
          └── CustomScrollView
              └── SliverToBoxAdapter
                  └── Center
                      └── ConstrainedBox
                          └── Column
                              ├── TranslationHeader
                              ├── LanguagePairSelector
                              ├── TranslationInputCard
                              ├── TranslationResultCard
                              └── TranslationStates

26. COMPLETE TESTING CHECKLIST
    - Layout/overflow
    - Keyboard
    - Phone/tablet responsiveness
    - Portrait/landscape
    - Dark mode
    - Large text
    - Screen reader/accessibility
    - Loading/empty/error/offline/success
    - Long and invalid text
    - Language switching
    - Language swap
    - Clear action
    - Translation state transitions
    - Future AI/streaming integration boundary
    - Animation smoothness
    - Performance
    - Memory
    - Localization readiness
*/

import 'package:flutter/material.dart';

import '../../data/dummy/translation_dummy_data.dart';
import '../controllers/translation_controller.dart';
import '../widgets/language_pair_selector.dart';
import '../widgets/translation_header.dart';
import '../widgets/translation_input_card.dart';
import '../widgets/translation_result_card.dart';
import '../widgets/translation_states.dart';

class TranslationPage extends StatefulWidget {
  const TranslationPage({super.key});

  @override
  State<TranslationPage> createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  late final TranslationController _controller;
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();

    _controller = TranslationController();
    _textController = TextEditingController(text: defaultTranslationInput);

    _controller.addListener(_handleControllerChanged);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_handleControllerChanged)
      ..dispose();
    _textController.dispose();
    super.dispose();
  }

  void _handleControllerChanged() {
    if (!mounted) {
      return;
    }

    if (_textController.text != _controller.sourceText) {
      _textController.value = TextEditingValue(
        text: _controller.sourceText,
        selection: TextSelection.collapsed(
          offset: _controller.sourceText.length,
        ),
      );
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('LinguaLive'),
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: 'More translation options',
            onPressed: () {},
            icon: const Icon(Icons.more_horiz_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TranslationHeader(),
                        const SizedBox(height: 24),
                        _buildWorkspace(context),
                        const SizedBox(height: 20),
                        TranslationStates(
                          translation: _controller.translation,
                          isProcessing: _controller.isProcessing,
                        ),
                        if (_controller.translation != null &&
                            !_controller.isProcessing &&
                            _controller.translation!.status !=
                                _TranslationStatusProxy.error &&
                            _controller.translation!.status !=
                                _TranslationStatusProxy.offline &&
                            _controller.translation!.status !=
                                _TranslationStatusProxy.empty)
                          const SizedBox.shrink(),
                        SizedBox(
                          height: MediaQuery.viewInsetsOf(context).bottom > 0
                              ? 12
                              : 0,
                        ),
                        Text(
                          'LinguaLive Translation',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkspace(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 820;

        final languageSelector = LanguagePairSelector(
          sourceLanguageCode: _controller.sourceLanguageCode,
          targetLanguageCode: _controller.targetLanguageCode,
          onSourceChanged: (value) {
            if (value != null) {
              _controller.setSourceLanguage(value);
            }
          },
          onTargetChanged: (value) {
            if (value != null) {
              _controller.setTargetLanguage(value);
            }
          },
          onSwap: _controller.swapLanguages,
        );

        final inputCard = TranslationInputCard(
          controller: _textController,
          onChanged: _controller.setSourceText,
          onClear: _controller.clear,
          onTranslate: _controller.translate,
          isProcessing: _controller.isProcessing,
        );

        final result = _controller.translation;
        final resultCard = result == null
            ? const SizedBox.shrink()
            : TranslationResultCard(translation: result);

        if (wide) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              languageSelector,
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: inputCard),
                  const SizedBox(width: 16),
                  Expanded(
                    child: result == null
                        ? TranslationStates(
                            translation: result,
                            isProcessing: _controller.isProcessing,
                          )
                        : resultCard,
                  ),
                ],
              ),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            languageSelector,
            const SizedBox(height: 16),
            inputCard,
            if (result != null) ...[const SizedBox(height: 16), resultCard],
          ],
        );
      },
    );
  }
}

/// Keeps the page implementation independent from concrete enum comparisons
/// in its responsive layout code.
abstract final class _TranslationStatusProxy {
  static const error = Object();
  static const offline = Object();
  static const empty = Object();
}
