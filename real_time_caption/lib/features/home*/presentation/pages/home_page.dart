/*
1. PAGE NAME
   Home Page

2. PURPOSE
   Main LinguaLive application dashboard and entry point for multilingual
   communication features.

3. DESCRIPTION
   Presents the selected source/target language pair, Live Speech entry point,
   core communication features, recent sessions, connection status, and
   application navigation.

4. UI SECTIONS
   - Application header
   - Welcome section
   - Language pair selector
   - Live Speech primary action
   - Communication feature grid
   - Recent sessions
   - Bottom navigation

5. NAVIGATION FLOW
   User opens application
        ↓
   Home Page
        ↓
   Choose Source & Target Language
        ↓
   Start Live Speech
        ↓
   Future communication pipeline

   Home also exposes Call Caption, Chat, Translation, QR Session, and History
   entry points.

6. DYNAMIC COMPONENTS
   - Source language
   - Target language
   - Language swap
   - Connection status
   - Communication feature cards
   - Recent sessions
   - Bottom navigation state

7. FUTURE BACKEND INTEGRATION
   Future: connect the selected language pair to the project's voice-input,
   VAD, noise reduction, audio processing, language detection, Whisper ASR,
   streaming ASR, NLLB-200 translation, Gemma contextual correction,
   speaker recognition/diarization, TTS, ONNX Runtime, MM-MO optimization,
   and WebSocket communication pipeline; Home establishes the user's initial
   language configuration and communication intent.

8. TECHNOLOGIES USED
   - Flutter
   - Dart
   - Material 3
   - ChangeNotifier for local UI state

9. REQUIRED DATA MODELS
   LanguageOptionEntity
   HomeFeatureEntity
   RecentSessionEntity
   HomeConnectionStatus

10. FUTURE API ENDPOINTS
    None implemented in this UI-only stage.

11. DATABASE COLLECTIONS/TABLES
    None implemented in this UI-only stage.
    Session History will be connected later through its dedicated feature.

12. REQUIRED ASSETS
    None. Material Icons are sufficient.

13. REQUIRED ICONS
    language, wifi, person, mic, phone_in_talk, forum, translate,
    qr_code_2, history, groups, swap_horiz.

14. THEME COLORS
    Uses the existing application's Material 3 ColorScheme.
    No application-specific hard-coded colors are required.

15. ANIMATIONS
    Material interaction feedback and responsive layout transitions.

16. ACCESSIBILITY
    - Semantic button labels
    - Material minimum touch targets
    - Text + icon communication
    - Screen-reader-friendly labels
    - Responsive large-text layout
    - No color-only state communication

17. EDGE CASES
    - Small phone
    - Large tablet
    - Landscape orientation
    - Large accessibility text
    - Long multilingual language names
    - Empty session history
    - Loading state
    - Error state
    - Offline state
    - Reconnecting state

18. VALIDATION RULES
    Language dropdown selections must come from the provided local language
    collection. Null selections are ignored.

19. ERROR HANDLING
    UI-only error representation is available through HomeErrorState.
    No real retry operation is implemented.

20. LOADING STATE
    HomeLoadingState provides the visual representation.

21. EMPTY STATE
    HomeEmptyState represents the absence of recent sessions.

22. OFFLINE BEHAVIOUR
    HomeOfflineState provides the visual representation. No real connectivity
    detection is performed.

23. SECURITY CONSIDERATIONS
    This UI does not process credentials, audio, network requests, personal
    information, or persistent session data.

24. PERFORMANCE OPTIMIZATIONS
    - Small feature-specific widgets
    - Immutable dummy data
    - Local ChangeNotifier
    - No external state-management dependency
    - No expensive computation
    - Responsive bounded layouts

25. WIDGET TREE OVERVIEW
    Scaffold
      ├── HomeHeader
      ├── SafeArea
      │   └── CustomScrollView
      │       ├── Welcome section
      │       ├── LanguagePairCard
      │       ├── Live Speech card
      │       ├── HomeFeatureGrid
      │       └── Recent sessions
      └── NavigationBar

26. COMPLETE TESTING CHECKLIST
    Layout, overflow, keyboard/resize, orientation, phone/tablet,
    dark mode, large text, screen reader, loading, empty, error, success,
    offline, long/null local data, navigation state, language swap,
    feature callbacks, animation, performance, memory, localization,
    and future AI/streaming integration points.
*/

import 'package:flutter/material.dart';

import '../../data/data_sources/mock_home_data_source.dart';
import '../../domain/entities/home_feature_entity.dart';
import '../controllers/home_controller.dart';
import '../widgets/home_feature_grid.dart';
import '../widgets/home_header.dart';
import '../widgets/home_states.dart';
import '../widgets/language_pair_card.dart';
import '../widgets/recent_session_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController _controller;

  final MockHomeDataSource _dataSource = const MockHomeDataSource();

  late final List<HomeFeatureEntity> _features;
  late final List<RecentSessionEntity> _recentSessions;

  HomeConnectionStatus _connectionStatus = HomeConnectionStatus.connected;

  @override
  void initState() {
    super.initState();

    _controller = HomeController(
      languages: _dataSource
          .getLanguages()
          .map((model) => model.toEntity())
          .toList(),
    );

    _features = _dataSource
        .getFeatures()
        .map((model) => model.toEntity())
        .toList();

    _recentSessions = _dataSource
        .getRecentSessions()
        .map((model) => model.toEntity())
        .toList();

    _controller.addListener(_handleControllerChanged);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_handleControllerChanged)
      ..dispose();

    super.dispose();
  }

  void _handleControllerChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.sizeOf(context).width >= 700;

    return Scaffold(
      appBar: HomeHeader(
        connectionStatus: _connectionStatus,
        onConnectionPressed: () {
          setState(() {
            _connectionStatus =
                _connectionStatus == HomeConnectionStatus.connected
                ? HomeConnectionStatus.reconnecting
                : HomeConnectionStatus.connected;
          });

          // Future: connect this action to the application's real connection
          // monitoring/reconnection state; this control currently demonstrates
          // the supported connection states locally.
        },
        onProfilePressed: () {
          // Future: navigate to the Profile feature through the application's
          // router; Home only exposes the profile entry point.
        },
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                isWide ? 40 : 20,
                24,
                isWide ? 40 : 20,
                32,
              ),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildWelcomeSection(context),
                        const SizedBox(height: 24),
                        LanguagePairCard(
                          sourceLanguage: _controller.sourceLanguage,
                          targetLanguage: _controller.targetLanguage,
                          languages: _controller.languages,
                          onSourceChanged: _controller.selectSourceLanguage,
                          onTargetChanged: _controller.selectTargetLanguage,
                          onSwap: _controller.swapLanguages,
                        ),
                        const SizedBox(height: 20),
                        _buildLiveSpeechCard(context),
                        const SizedBox(height: 32),
                        Text(
                          'Communication tools',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 14),
                        HomeFeatureGrid(
                          features: _features,
                          onFeaturePressed: _handleFeaturePressed,
                        ),
                        const SizedBox(height: 32),
                        _buildRecentSessionsSection(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _controller.navigationIndex,
        onDestinationSelected: (int index) {
          _controller.selectNavigationItem(index);

          // Future: connect each destination to the project's existing router;
          // NavigationBar currently represents local UI selection only.
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.forum_outlined),
            selectedIcon: Icon(Icons.forum_rounded),
            label: 'Chats',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history_rounded),
            label: 'History',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Speak freely.',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.8,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Let languages flow naturally.',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Start a multilingual conversation, join a session, '
          'or continue where you left off.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            height: 1.45,
          ),
        ),
      ],
    );
  }

  Widget _buildLiveSpeechCard(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: colors.primaryContainer,
      child: InkWell(
        onTap: _startLiveSpeech,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final bool compact = constraints.maxWidth < 560;

              final Widget description = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Start a live conversation',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: colors.onPrimaryContainer,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${_controller.sourceLanguage.name} → '
                    '${_controller.targetLanguage.name}',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colors.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Live speech, captions and multilingual communication.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.onPrimaryContainer,
                    ),
                  ),
                ],
              );

              final Widget action = FilledButton.icon(
                onPressed: _startLiveSpeech,
                icon: const Icon(Icons.mic_rounded),
                label: const Text('Start Live Speech'),
              );

              if (compact) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    description,
                    const SizedBox(height: 18),
                    action,
                  ],
                );
              }

              return Row(
                children: <Widget>[
                  Expanded(child: description),
                  const SizedBox(width: 20),
                  action,
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRecentSessionsSection(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'Recent sessions',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Future: navigate to the dedicated History feature; Home
                // provides only a compact preview of session history.
              },
              child: const Text('View history'),
            ),
          ],
        ),
        const SizedBox(height: 14),
        if (_recentSessions.isEmpty)
          const HomeEmptyState(
            message: 'Your multilingual sessions will appear here.',
          )
        else
          Column(
            children: _recentSessions
                .map(
                  (RecentSessionEntity session) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: RecentSessionCard(
                      session: session,
                      onPressed: () {
                        // Future: open the selected session through the
                        // History/Conversations feature; this card currently
                        // displays local demonstration data only.
                      },
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }

  void _startLiveSpeech() {
    // Future: connect the Live Speech action to the project's VAD, noise
    // reduction, audio processing, language detection, streaming ASR,
    // translation, contextual correction, speaker processing, TTS,
    // inference optimization, and WebSocket pipeline; this button is the
    // Home entry point for that complete workflow.
  }

  void _handleFeaturePressed(HomeFeatureEntity feature) {
    switch (feature.id) {
      case 'live_speech':
        _startLiveSpeech();
      case 'call_caption':
        // Future: navigate to Call Caption; this card is the Home entry point
        // for the project's captioned call workflow.
        break;
      case 'chat':
        // Future: navigate to Chat; this card is the Home entry point for
        // converting multilingual spoken conversations into chat.
        break;
      case 'translation':
        // Future: navigate to Translation; this card exposes the dedicated
        // translation workflow from the Home dashboard.
        break;
      case 'qr_session':
        // Future: navigate to the QR Session workflow; QR generation and
        // scanning belong to the session-joining flow rather than Home UI.
        break;
    }
  }
}
