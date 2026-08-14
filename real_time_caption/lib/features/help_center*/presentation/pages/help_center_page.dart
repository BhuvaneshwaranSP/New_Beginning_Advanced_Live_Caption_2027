/*
1. PAGE NAME
   Help Center Page

2. PURPOSE
   Provides the searchable LinguaLive Help Center interface.

3. DESCRIPTION
   Presents categories, searchable FAQs, expandable answers, and local UI
   representations of loading, error, offline, and empty states.

4. UI SECTIONS
   Header, search, categories, frequently asked questions, state views.

5. NAVIGATION FLOW
   Application navigation → Help Center page.

6. DYNAMIC COMPONENTS
   Search query, filtered articles, expanded article, UI state.

7. FUTURE BACKEND INTEGRATION
   Future: connect supported Help Center content retrieval through the
   controller/data boundary; no network functionality is implemented here.

8. TECHNOLOGIES USED
   Flutter Material 3 and built-in ChangeNotifier.

9. REQUIRED DATA MODELS
   HelpCenterCategoryEntity
   HelpCenterArticleEntity

10. FUTURE API ENDPOINTS
    Not specified.

11. DATABASE COLLECTIONS/TABLES
    Not specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Application ColorScheme.

15. ANIMATIONS
    FAQ expansion.

16. ACCESSIBILITY
    Semantic FAQ controls, readable labels, touch targets, responsive text.

17. EDGE CASES
    Empty results, long text, small screens, large screens, dark mode,
    large text, loading, error, and offline states.

18. VALIDATION RULES
    Search matches title, description, and keywords.

19. ERROR HANDLING
    Local retry state.

20. LOADING STATE
    Local loading representation.

21. EMPTY STATE
    Local empty-search representation.

22. OFFLINE BEHAVIOUR
    Local offline representation.

23. SECURITY CONSIDERATIONS
    No private or network data.

24. PERFORMANCE OPTIMIZATIONS
    Small local collections and lightweight widgets.

25. WIDGET TREE OVERVIEW
    Scaffold → SafeArea → CustomScrollView → Header/Search/Content.

26. COMPLETE TESTING CHECKLIST
    Test responsive layout, keyboard, search, expansion, states, accessibility,
    dark mode, localization readiness, and overflow.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/help_center_feature_entity.dart';
import '../controllers/help_center_controller.dart';
import '../widgets/help_center_article_tile.dart';
import '../widgets/help_center_category_card.dart';
import '../widgets/help_center_header.dart';
import '../widgets/help_center_search.dart';
import '../widgets/help_center_states.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  late final HelpCenterController _controller;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _controller = HelpCenterController();
    _searchController = TextEditingController();

    _controller.addListener(_refresh);
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_refresh)
      ..dispose();

    _searchController.dispose();

    super.dispose();
  }

  void _onSearchChanged(String value) {
    _controller.updateSearch(value);
  }

  void _clearSearch() {
    _searchController.clear();
    _controller.clearSearch();

    FocusManager.instance.primaryFocus?.unfocus();
  }

  HelpCenterCategoryEntity? _categoryFor(HelpCenterArticleEntity article) {
    for (final category in _controller.categories) {
      if (category.id == article.categoryId) {
        return category;
      }
    }

    return null;
  }

  Widget _buildStateContent() {
    switch (_controller.state) {
      case HelpCenterViewState.loading:
        return const SliverFillRemaining(
          hasScrollBody: false,
          child: HelpCenterLoadingState(),
        );

      case HelpCenterViewState.error:
        return SliverFillRemaining(
          hasScrollBody: false,
          child: HelpCenterErrorState(onRetry: _controller.retry),
        );

      case HelpCenterViewState.offline:
        return SliverFillRemaining(
          hasScrollBody: false,
          child: HelpCenterOfflineState(onRestore: _controller.restoreContent),
        );

      case HelpCenterViewState.success:
        return _buildSuccessContent();
    }
  }

  Widget _buildSuccessContent() {
    final articles = _controller.filteredArticles;

    if (articles.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: HelpCenterEmptyState(
          query: _controller.query,
          onClear: _clearSearch,
        ),
      );
    }

    return SliverList(
      delegate: SliverChildListDelegate([
        const SizedBox(height: 24),
        const _SectionTitle(
          title: 'Browse by topic',
          subtitle: 'Start with a category or search directly.',
        ),
        const SizedBox(height: 12),
        _buildCategorySection(),
        const SizedBox(height: 28),
        _SectionTitle(
          title: 'Frequently asked',
          subtitle: _controller.query.isEmpty
              ? 'Quick answers to common LinguaLive questions.'
              : '${articles.length} matching topic${articles.length == 1 ? '' : 's'}',
        ),
        const SizedBox(height: 12),
        ...articles.map(_buildArticle),
        const SizedBox(height: 24),
      ]),
    );
  }

  Widget _buildCategorySection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 680;

        if (!isWide) {
          return Column(
            children: [
              for (var i = 0; i < _controller.categories.length; i++) ...[
                HelpCenterCategoryCard(category: _controller.categories[i]),
                if (i < _controller.categories.length - 1)
                  const SizedBox(height: 10),
              ],
            ],
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _controller.categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 3.3,
          ),
          itemBuilder: (context, index) {
            return HelpCenterCategoryCard(
              category: _controller.categories[index],
            );
          },
        );
      },
    );
  }

  Widget _buildArticle(HelpCenterArticleEntity article) {
    final category = _categoryFor(article);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: HelpCenterArticleTile(
        article: article,
        categoryTitle: category?.title ?? 'Help topic',
        expanded: _controller.expandedArticleId == article.id,
        onPressed: () {
          _controller.toggleArticle(article.id);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help Center')),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth >= 900
                ? 40.0
                : constraints.maxWidth >= 600
                ? 28.0
                : 16.0;

            final maxContentWidth = 980.0;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxContentWidth),
                child: CustomScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        20,
                        horizontalPadding,
                        0,
                      ),
                      sliver: const SliverToBoxAdapter(
                        child: HelpCenterHeader(),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        20,
                        horizontalPadding,
                        0,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: HelpCenterSearch(
                          controller: _searchController,
                          onChanged: _onSearchChanged,
                          onClear: _clearSearch,
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                      ),
                      sliver: _buildStateContent(),
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

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
