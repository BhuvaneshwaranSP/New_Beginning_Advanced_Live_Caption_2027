/*
1. PAGE NAME
   About Page

2. PURPOSE
   Introduces LinguaLive, its documented communication capabilities,
   supported communication modes, and major technologies.

3. DESCRIPTION
   Premium Material 3 About screen using only local dummy data.
   No backend, API, authentication, Firebase, database, networking,
   AI inference, speech recognition, translation, or persistence is used.

4. UI SECTIONS
   - Application identity
   - Project description
   - Mission statement
   - Core capabilities
   - Communication modes
   - Technology overview
   - Offline/local information note

5. NAVIGATION FLOW
   Settings/Profile/other application entry point → About Page → back.

6. DYNAMIC COMPONENTS
   Application metadata, capabilities, communication modes,
   and technology list are supplied through local dummy models.

7. FUTURE BACKEND INTEGRATION
   // Future: replace the local About metadata source with the approved
   // application configuration/repository source if About information
   // becomes remotely configurable; this page only renders the result.

8. TECHNOLOGIES USED
   - Flutter
   - Material 3
   - Dart
   No additional packages are required.

9. REQUIRED DATA MODELS
   AboutFeatureEntity, AboutCapabilityEntity, AboutModeEntity,
   AboutTechnologyEntity.

10. FUTURE API ENDPOINTS
    None specified for the current page.
    No unsupported endpoint is invented.

11. DATABASE COLLECTIONS/TABLES
    None required by this page.

12. REQUIRED ASSETS
    No external assets are required. The LinguaLive visual identity is
    represented with Material icons so the screen remains self-contained.

13. REQUIRED ICONS
    Icons.translate_outlined
    Icons.auto_awesome_outlined
    Icons.record_voice_over_outlined
    Icons.call_outlined
    Icons.chat_bubble_outline
    Icons.memory_outlined
    Icons.offline_bolt_outlined

14. THEME COLORS
    Uses Material 3 ColorScheme from the application's active theme.
    No hard-coded application palette is introduced.

15. ANIMATIONS
    AnimatedSwitcher provides a lightweight entrance transition for the
    main content. No expensive animation or continuous animation is used.

16. ACCESSIBILITY
    - Meaningful semantic labels
    - Adequate touch targets
    - No color-only status communication
    - Text remains readable under large font settings
    - Flexible layouts avoid clipping
    - Icons are supplementary to visible text

17. EDGE CASES
    - Very large text scale
    - Small phone width
    - Tablet and landscape layouts
    - Long multilingual strings
    - Empty capability/mode/technology collections
    - Dark mode
    - Reduced available vertical space

18. VALIDATION RULES
    Empty collections produce a compact informational empty state.
    Long text must wrap instead of overflow.

19. ERROR HANDLING
    There is no external operation capable of failing in the current UI-only
    implementation. Empty local collections are handled gracefully.

20. LOADING STATE
    Not required because all content is local dummy data and is immediately
    available.

21. EMPTY STATE
    Individual collection sections display a concise empty message when
    their local list contains no items.

22. OFFLINE BEHAVIOUR
    About content remains available because it is local UI data.
    No network state is queried or simulated.

23. SECURITY CONSIDERATIONS
    The page does not display credentials, tokens, private conversations,
    user identifiers, or sensitive account information.

24. PERFORMANCE OPTIMIZATIONS
    - const widgets wherever possible
    - immutable domain entities
    - local static dummy data
    - no unnecessary controllers
    - no continuous animation
    - ListView.builder for technology items
    - responsive layout based on available width

25. WIDGET TREE OVERVIEW
    Scaffold
    └── CustomScrollView
        ├── SliverAppBar
        └── SliverToBoxAdapter
            └── Responsive content
                ├── Identity card
                ├── Description section
                ├── Mission card
                ├── Capabilities
                ├── Communication modes
                ├── Technology overview
                └── Local availability note

26. COMPLETE TESTING CHECKLIST
    - Compile with null safety.
    - Run analyzer and verify no deprecated APIs.
    - Test phone portrait and landscape.
    - Test tablet portrait and landscape.
    - Test light and dark themes.
    - Test large system font size.
    - Test screen-reader navigation.
    - Test long English and multilingual strings.
    - Test empty capability/mode/technology lists.
    - Test scrolling from top to bottom.
    - Test back navigation.
    - Test reduced-height screens.
    - Verify no RenderFlex overflow.
    - Verify no clipped text.
    - Verify Material touch targets.
    - Verify animation remains smooth.
    - Verify no backend or package dependency has been introduced.
*/

import 'package:flutter/material.dart';

import '../../data/dummy/about_dummy_data.dart';
import '../../data/mappers/about_feature_mapper.dart';
import '../../domain/entities/about_feature_entity.dart';
import '../widgets/about_capability_card.dart';
import '../widgets/about_technology_tile.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    const mapper = AboutFeatureMapper();
    final AboutFeatureEntity about = mapper.toEntity(aboutDummyData);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: const Text('About LinguaLive'),
            centerTitle: false,
            actions: [
              IconButton(
                tooltip: 'About LinguaLive',
                onPressed: () {},
                icon: const Icon(Icons.info_outline),
              ),
            ],
          ),
          SliverToBoxAdapter(child: _AboutContent(about: about)),
        ],
      ),
    );
  }
}

class _AboutContent extends StatelessWidget {
  final AboutFeatureEntity about;

  const _AboutContent({required this.about});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWide = constraints.maxWidth >= 700;
        final double horizontalPadding = isWide ? 40 : 20;
        final double contentWidth = isWide
            ? 900
            : constraints.maxWidth - (horizontalPadding * 2);

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: contentWidth),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                24,
                horizontalPadding,
                40,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 280),
                child: Column(
                  key: ValueKey(about.appName),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _IdentitySection(about: about),
                    const SizedBox(height: 28),
                    _SectionHeading(
                      icon: Icons.language_outlined,
                      title: 'About the platform',
                    ),
                    const SizedBox(height: 12),
                    Text(
                      about.description,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(height: 1.6),
                    ),
                    const SizedBox(height: 24),
                    _MissionCard(mission: about.mission),
                    const SizedBox(height: 32),
                    _SectionHeading(
                      icon: Icons.auto_awesome_outlined,
                      title: 'Core capabilities',
                    ),
                    const SizedBox(height: 12),
                    _CapabilitiesSection(
                      capabilities: about.capabilities,
                      isWide: isWide,
                    ),
                    const SizedBox(height: 32),
                    _SectionHeading(
                      icon: Icons.hub_outlined,
                      title: 'Communication modes',
                    ),
                    const SizedBox(height: 12),
                    _ModesSection(
                      modes: about.communicationModes,
                      isWide: isWide,
                    ),
                    const SizedBox(height: 32),
                    _SectionHeading(
                      icon: Icons.memory_outlined,
                      title: 'Technology overview',
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Key technologies documented for the LinguaLive '
                      'communication pipeline.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _TechnologySection(technologies: about.technologies),
                    const SizedBox(height: 28),
                    _LocalAvailabilityCard(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _IdentitySection extends StatelessWidget {
  final AboutFeatureEntity about;

  const _IdentitySection({required this.about});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      header: true,
      label: '${about.appName}, version ${about.version}',
      child: Card(
        margin: EdgeInsets.zero,
        color: colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.translate_outlined,
                  size: 34,
                  color: colorScheme.onPrimary,
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      about.appName,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: colorScheme.onPrimaryContainer,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Version ${about.version}',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Communication without language barriers.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MissionCard extends StatelessWidget {
  final String mission;

  const _MissionCard({required this.mission});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.public_outlined, color: colorScheme.primary, size: 28),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Our mission',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    mission,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CapabilitiesSection extends StatelessWidget {
  final List<AboutCapabilityEntity> capabilities;
  final bool isWide;

  const _CapabilitiesSection({
    required this.capabilities,
    required this.isWide,
  });

  @override
  Widget build(BuildContext context) {
    if (capabilities.isEmpty) {
      return const _EmptySectionMessage(
        message: 'No capabilities are currently listed.',
      );
    }

    if (!isWide) {
      return Column(
        children: [
          for (int index = 0; index < capabilities.length; index++) ...[
            AboutCapabilityCard(capability: capabilities[index]),
            if (index != capabilities.length - 1) const SizedBox(height: 12),
          ],
        ],
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: capabilities.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 430,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        mainAxisExtent: 142,
      ),
      itemBuilder: (context, index) {
        return AboutCapabilityCard(capability: capabilities[index]);
      },
    );
  }
}

class _ModesSection extends StatelessWidget {
  final List<AboutModeEntity> modes;
  final bool isWide;

  const _ModesSection({required this.modes, required this.isWide});

  @override
  Widget build(BuildContext context) {
    if (modes.isEmpty) {
      return const _EmptySectionMessage(
        message: 'No communication modes are currently listed.',
      );
    }

    final cards = [
      for (final mode in modes) _CommunicationModeCard(mode: mode),
    ];

    if (!isWide) {
      return Column(
        children: [
          for (int index = 0; index < cards.length; index++) ...[
            cards[index],
            if (index != cards.length - 1) const SizedBox(height: 12),
          ],
        ],
      );
    }

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: cards.map((card) => SizedBox(width: 280, child: card)).toList(),
    );
  }
}

class _CommunicationModeCard extends StatelessWidget {
  final AboutModeEntity mode;

  const _CommunicationModeCard({required this.mode});

  IconData _iconForMode() {
    switch (mode.title) {
      case 'Live Speech':
        return Icons.record_voice_over_outlined;
      case 'Call Caption':
        return Icons.call_outlined;
      case 'Chat':
        return Icons.chat_bubble_outline;
      default:
        return Icons.forum_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(_iconForMode(), color: colorScheme.primary, size: 28),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mode.title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    mode.description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TechnologySection extends StatelessWidget {
  final List<AboutTechnologyEntity> technologies;

  const _TechnologySection({required this.technologies});

  @override
  Widget build(BuildContext context) {
    if (technologies.isEmpty) {
      return const _EmptySectionMessage(
        message: 'No technology information is currently available.',
      );
    }

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: technologies.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (context, index) {
            return AboutTechnologyTile(technology: technologies[index]);
          },
        ),
      ),
    );
  }
}

class _LocalAvailabilityCard extends StatelessWidget {
  const _LocalAvailabilityCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      label: 'About information is available locally',
      child: Card(
        margin: EdgeInsets.zero,
        color: colorScheme.surfaceContainerHighest,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.offline_bolt_outlined, color: colorScheme.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'This information is part of the application interface '
                  'and remains available without an active connection.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(height: 1.45),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SectionHeading({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(icon, size: 22, color: colorScheme.primary),
        const SizedBox(width: 9),
        Expanded(
          child: Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class _EmptySectionMessage extends StatelessWidget {
  final String message;

  const _EmptySectionMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            const Icon(Icons.info_outline),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
  }
}
