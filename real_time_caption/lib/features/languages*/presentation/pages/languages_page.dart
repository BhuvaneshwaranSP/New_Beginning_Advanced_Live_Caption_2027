/*
1. PAGE NAME
   Languages Page

2. PURPOSE
   Central language-control screen for LinguaLive.

3. DESCRIPTION
   Provides My Languages, Preferred Languages, Recent Languages,
   All Supported Languages, language availability, Auto-detect,
   and the shared source/target language pair.

4. UI SECTIONS
   App header
   Search
   Active source/target language pair
   Auto-detect
   My Languages
   Preferred Languages
   Recent Languages
   All Supported Languages

5. NAVIGATION FLOW
   Languages → select source/target → future translation,
   transcription, calls, sessions, and communication experiences.

6. DYNAMIC COMPONENTS
   Search results, selected language pair, language availability,
   selected source/target languages, and offline preview.

7. FUTURE BACKEND INTEGRATION
   Future: connect the language catalog and user preferences at the
   controller/data-source boundary. Future: synchronize the selected
   source/target pair with translation and transcription services here
   because this page is the central language-control surface.

8. TECHNOLOGIES USED
   Flutter Material 3
   ChangeNotifier
   Local dummy data

9. REQUIRED DATA MODELS
   LanguageFeatureEntity
   LanguageFeatureModel

10. FUTURE API ENDPOINTS
    Not implemented. Production endpoints for language catalogs,
    preferences, availability, and offline resources will be defined
    by the backend contract.

11. DATABASE COLLECTIONS/TABLES
    Not implemented. Production persistence is intentionally excluded
    from this UI-only implementation.

12. REQUIRED ASSETS
    None. Material icons are sufficient.

13. REQUIRED ICONS
    language, translate, swap_horiz, auto_awesome, history,
    star, check_circle, cloud_off, search.

14. THEME COLORS
    Material 3 ColorScheme only.

15. ANIMATIONS
    Lightweight language-selection transitions.

16. ACCESSIBILITY
    Semantic labels, selected states, descriptive controls,
    sufficient touch targets, scalable text, and non-color-only
    availability indicators.

17. EDGE CASES
    No search results, unavailable language, long language names,
    large text, narrow screens, landscape layouts, and empty sections.

18. VALIDATION RULES
    Source and target languages cannot intentionally be identical.

19. ERROR HANDLING
    No backend errors are implemented. Empty and unavailable states
    are represented locally.

20. LOADING STATE
    Local loading representation during initial dummy-data setup.

21. EMPTY STATE
    Search sections show a meaningful no-match message.

22. OFFLINE BEHAVIOUR
    Local offline-preview state represents availability without
    implementing actual connectivity.

23. SECURITY CONSIDERATIONS
    No credentials, authentication, networking, or private data.

24. PERFORMANCE OPTIMIZATIONS
    Local filtering, immutable dummy data, reusable widgets,
    and lightweight implicit animations.

25. WIDGET TREE OVERVIEW
    Scaffold
      └── SafeArea
          └── CustomScrollView
              ├── Header
              ├── Active language pair
              ├── Offline banner
              ├── Auto-detect
              ├── My Languages
              ├── Preferred Languages
              ├── Recent Languages
              └── All Supported Languages

26. COMPLETE TESTING CHECKLIST
    Layout/overflow
    Keyboard
    Orientation
    Phone/tablet responsiveness
    Dark mode
    Large text
    Screen reader/accessibility
    Loading
    Empty/search state
    Unavailable state
    Long language data
    Selection transitions
    Source/target swapping
    Offline preview
    Localization readiness
    Performance
    Memory
*/

import 'package:flutter/material.dart';

import '../controllers/languages_controller.dart';
import '../widgets/language_pair_card.dart';
import '../widgets/language_section.dart';
import '../widgets/languages_header.dart';
import '../widgets/languages_states.dart';

class LanguagesPage extends StatefulWidget {
  const LanguagesPage({super.key});

  @override
  State<LanguagesPage> createState() => _LanguagesPageState();
}

class _LanguagesPageState extends State<LanguagesPage> {
  late final LanguagesController _controller;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _controller = LanguagesController();
    _searchController = TextEditingController();
    _controller.addListener(_refresh);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_refresh)
      ..dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void _updateSearch(String value) {
    _controller.setSearchQuery(value);
    setState(() {});
  }

  void _selectLanguage(String languageId) {
    final sourceId = _controller.sourceLanguageId;

    if (languageId == sourceId) {
      _controller.selectSourceLanguage(languageId);
      return;
    }

    _controller.selectTargetLanguage(languageId);

    // Future: open the shared language-selection workflow here when
    // navigation is connected to the production router.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Languages'), centerTitle: false),
      body: SafeArea(
        child: _controller.isLoading
            ? const LanguagesLoadingState()
            : CustomScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                    sliver: SliverToBoxAdapter(
                      child: _LanguagesContent(
                        controller: _controller,
                        searchController: _searchController,
                        onSearchChanged: _updateSearch,
                        onSelectLanguage: _selectLanguage,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _LanguagesContent extends StatelessWidget {
  const _LanguagesContent({
    required this.controller,
    required this.searchController,
    required this.onSearchChanged,
    required this.onSelectLanguage,
  });

  final LanguagesController controller;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onSelectLanguage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LanguagesHeader(
          controller: searchController,
          onChanged: onSearchChanged,
        ),
        const SizedBox(height: 18),
        LanguagePairCard(
          source: controller.sourceLanguage,
          target: controller.targetLanguage,
          onSwap: controller.swapLanguages,
        ),
        const SizedBox(height: 12),
        if (controller.isOfflinePreview)
          LanguagesOfflineBanner(onPressed: controller.toggleOfflinePreview),
        _AutoDetectCard(
          enabled: true,
          onPressed: () {
            // Future: connect automatic source-language detection here;
            // this control belongs beside the central language pair because
            // detection determines the incoming communication language.
          },
        ),
        const SizedBox(height: 24),
        LanguageSection(
          title: 'My Languages',
          icon: Icons.collections_bookmark_rounded,
          languages: controller.myLanguages,
          selectedLanguageId: controller.sourceLanguageId,
          onLanguageSelected: onSelectLanguage,
        ),
        const SizedBox(height: 24),
        LanguageSection(
          title: 'Preferred Languages',
          icon: Icons.star_rounded,
          languages: controller.preferredLanguages,
          selectedLanguageId: controller.sourceLanguageId,
          onLanguageSelected: onSelectLanguage,
        ),
        const SizedBox(height: 24),
        LanguageSection(
          title: 'Recent Languages',
          icon: Icons.history_rounded,
          languages: controller.recentLanguages,
          selectedLanguageId: controller.targetLanguageId,
          onLanguageSelected: onSelectLanguage,
        ),
        const SizedBox(height: 24),
        LanguageSection(
          title: 'All Supported Languages',
          icon: Icons.translate_rounded,
          languages: controller.supportedLanguages,
          selectedLanguageId: controller.targetLanguageId,
          onLanguageSelected: onSelectLanguage,
        ),
        const SizedBox(height: 16),
        _AvailabilityNote(theme: theme),
      ],
    );
  }
}

class _AutoDetectCard extends StatelessWidget {
  const _AutoDetectCard({required this.enabled, required this.onPressed});

  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerLow,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.tertiaryContainer,
          foregroundColor: theme.colorScheme.onTertiaryContainer,
          child: const Icon(Icons.auto_awesome_rounded),
        ),
        title: const Text(
          'Auto-detect',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: const Text('Let LinguaLive identify the incoming language.'),
        trailing: Switch(value: enabled, onChanged: (_) => onPressed()),
      ),
    );
  }
}

class _AvailabilityNote extends StatelessWidget {
  const _AvailabilityNote({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Language availability information',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 18,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Availability can vary by language and communication mode.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
