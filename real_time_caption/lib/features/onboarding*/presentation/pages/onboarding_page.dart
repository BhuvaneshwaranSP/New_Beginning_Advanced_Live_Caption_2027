/*
1. PAGE NAME
   Onboarding Page

2. PURPOSE
   Introduces LinguaLive and lets the user establish the source and target
   languages used as the initial communication context.

3. DESCRIPTION
   Responsive Material 3 onboarding screen using local dummy language data.
   The screen intentionally contains no backend, networking, authentication,
   persistence, speech processing, translation, or AI functionality.

4. UI SECTIONS
   - LinguaLive introduction
   - Setup progress
   - Source language selection
   - Target language selection
   - Source/target swap control
   - Validation feedback
   - Continue action
   - Small offline/local-data note

5. NAVIGATION FLOW
   Application opens → Onboarding → source/target language selection →
   continue callback supplied by the parent/router.

6. DYNAMIC COMPONENTS
   Language list, selected source language, selected target language,
   validation state, swap action, and responsive layout.

7. FUTURE BACKEND INTEGRATION
   Future: pass the selected language pair into the next application flow;
   onboarding establishes the language context used by later communication
   screens.

8. TECHNOLOGIES USED
   Flutter Material 3 and local ChangeNotifier state.

9. REQUIRED DATA MODELS
   OnboardingFeatureModel and OnboardingEntity.

10. FUTURE API ENDPOINTS
    None are specified by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    None are specified by the supplied project documentation.

12. REQUIRED ASSETS
    None required for this screen.

13. REQUIRED ICONS
    translate, language, swap, check, arrow-forward, and offline-related
    Material icons.

14. THEME COLORS
    Uses the application's Material 3 ColorScheme rather than hard-coded
    application colors.

15. ANIMATIONS
    Animated language selection, button state transitions, and lightweight
    progress animation.

16. ACCESSIBILITY
    - Semantic language controls
    - Explicit selected-state announcements
    - Text labels accompanying visual states
    - Adequate touch targets
    - Responsive text layout
    - No status communicated only through color

17. EDGE CASES
    - Small phones
    - Tablets
    - Landscape orientation
    - Large text
    - Long language names
    - Multilingual Unicode scripts
    - Same source and target language
    - Empty local language list

18. VALIDATION RULES
    Both source and target languages must be selected and they must be
    different.

19. ERROR HANDLING
    Local validation feedback is shown below the language controls.

20. LOADING STATE
    No asynchronous loading is necessary because onboarding uses local dummy
    data only.

21. EMPTY STATE
    An empty state widget exists for an empty local language collection.

22. OFFLINE BEHAVIOUR
    The onboarding screen remains usable offline because its language data is
    local. No connectivity detection is implemented.

23. SECURITY CONSIDERATIONS
    No credentials, personal data, audio, or network information is processed.

24. PERFORMANCE OPTIMIZATIONS
    - Immutable local language data
    - Small reusable widgets
    - Limited ChangeNotifier updates
    - No expensive layout or animation
    - Responsive GridView with bounded content width

25. WIDGET TREE OVERVIEW
    OnboardingPage
      └── SafeArea
          └── LayoutBuilder
              └── Center
                  └── ConstrainedBox
                      └── CustomScrollView
                          ├── OnboardingHeader
                          ├── OnboardingProgress
                          ├── Source language section
                          │   └── LanguageSelectionCard grid
                          ├── Swap control
                          ├── Target language section
                          │   └── LanguageSelectionCard grid
                          ├── Validation message
                          ├── Continue button
                          └── Local/offline information

26. COMPLETE TESTING CHECKLIST
    - Layout and overflow
    - Keyboard/focus navigation
    - Portrait/landscape
    - Phone/tablet responsiveness
    - Dark mode
    - Large text
    - Screen reader/accessibility
    - Source selection
    - Target selection
    - Same-language validation
    - Swap behavior
    - Empty/error UI
    - Long/null-like display values
    - Continue callback
    - Animation smoothness
    - Performance
    - Memory
    - Localization readiness
*/

import 'package:flutter/material.dart';

import '../../data/data_sources/mock_onboarding_data_source.dart';
import '../../domain/entities/onboarding_feature_entity.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/language_selection_card.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/onboarding_progress.dart';
import '../widgets/onboarding_states.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key, this.onContinue});

  final VoidCallback? onContinue;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final OnboardingController _controller;

  @override
  void initState() {
    super.initState();

    const MockOnboardingDataSource dataSource = MockOnboardingDataSource();

    final List<OnboardingEntity> languages = dataSource
        .getLanguages()
        .map(
          (language) => OnboardingEntity(
            code: language.code,
            name: language.name,
            nativeName: language.nativeName,
            icon: language.icon,
          ),
        )
        .toList(growable: false);

    _controller = OnboardingController(languages: languages)
      ..addListener(_handleControllerChanged);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_handleControllerChanged)
      ..dispose();

    super.dispose();
  }

  void _handleControllerChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _continue() {
    if (!_controller.validate()) {
      return;
    }

    // Future: provide the selected source and target languages to the next
    // application route because later live communication flows depend on this pair.

    widget.onContinue?.call();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _ = Theme.of(context);
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final bool isWide = constraints.maxWidth >= 700;
            final double horizontalPadding = isWide ? 40 : 20;
            final double maxContentWidth = isWide ? 980 : 640;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxContentWidth),
                child: CustomScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: <Widget>[
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        28,
                        horizontalPadding,
                        mediaQuery.padding.bottom + 28,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(<Widget>[
                          const OnboardingHeader(),
                          const SizedBox(height: 28),
                          const OnboardingProgress(
                            currentStep: 1,
                            totalSteps: 1,
                          ),
                          const SizedBox(height: 32),
                          _SectionHeading(
                            eyebrow: 'SOURCE LANGUAGE',
                            title: 'What will you speak?',
                            description:
                                'Choose the language you will speak or type.',
                          ),
                          const SizedBox(height: 14),
                          _LanguageGrid(
                            languages: _controller.languages,
                            selectedCode: _controller.sourceLanguage?.code,
                            onSelected: _controller.selectSource,
                          ),
                          const SizedBox(height: 18),
                          Center(
                            child: Semantics(
                              button: true,
                              label: 'Swap source and target languages',
                              child: IconButton.filledTonal(
                                tooltip: 'Swap source and target languages',
                                onPressed:
                                    _controller.sourceLanguage != null &&
                                        _controller.targetLanguage != null
                                    ? _controller.swapLanguages
                                    : null,
                                icon: const Icon(Icons.swap_vert_rounded),
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          _SectionHeading(
                            eyebrow: 'TARGET LANGUAGE',
                            title: 'What should LinguaLive understand?',
                            description:
                                'Choose the language you want to receive.',
                          ),
                          const SizedBox(height: 14),
                          _LanguageGrid(
                            languages: _controller.languages,
                            selectedCode: _controller.targetLanguage?.code,
                            onSelected: _controller.selectTarget,
                          ),
                          if (_controller.validationMessage !=
                              null) ...<Widget>[
                            const SizedBox(height: 16),
                            _ValidationMessage(
                              message: _controller.validationMessage!,
                            ),
                          ],
                          const SizedBox(height: 28),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton.icon(
                              onPressed: _controller.canContinue
                                  ? _continue
                                  : null,
                              icon: const Icon(Icons.arrow_forward_rounded),
                              label: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: Text('Continue'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _LocalDataNote(),
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

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({
    required this.eyebrow,
    required this.title,
    required this.description,
  });

  final String eyebrow;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          eyebrow,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _LanguageGrid extends StatelessWidget {
  const _LanguageGrid({
    required this.languages,
    required this.selectedCode,
    required this.onSelected,
  });

  final List<OnboardingEntity> languages;
  final String? selectedCode;
  final ValueChanged<OnboardingEntity> onSelected;

  @override
  Widget build(BuildContext context) {
    if (languages.isEmpty) {
      return const OnboardingEmptyState();
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final int columns = constraints.maxWidth >= 700
            ? 3
            : constraints.maxWidth >= 440
            ? 2
            : 1;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: languages.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 78,
          ),
          itemBuilder: (BuildContext context, int index) {
            final OnboardingEntity language = languages[index];

            return LanguageSelectionCard(
              language: language,
              selected: language.code == selectedCode,
              onTap: () => onSelected(language),
            );
          },
        );
      },
    );
  }
}

class _ValidationMessage extends StatelessWidget {
  const _ValidationMessage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Semantics(
      liveRegion: true,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: theme.colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.info_outline_rounded,
              color: theme.colorScheme.onErrorContainer,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onErrorContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LocalDataNote extends StatelessWidget {
  const _LocalDataNote();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Semantics(
      label: 'Language choices are available locally while onboarding.',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.offline_bolt_rounded,
            size: 17,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 7),
          Flexible(
            child: Text(
              'Language setup is available offline.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
