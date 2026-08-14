/*
1. PAGE NAME
   AI Models Page

2. PURPOSE
   Provides the LinguaLive interface for exploring the AI components used
   throughout the multilingual communication pipeline.

3. DESCRIPTION
   The screen presents the speech recognition, machine translation,
   contextual-language, text-to-speech, runtime, and model-optimization
   components identified in the LinguaLive processing flow. It is a UI-only
   implementation using local dummy data.

4. UI SECTIONS
   - App bar
   - AI Models introduction
   - Search field
   - Model category filters
   - Model catalog
   - Loading state
   - Error/retry state
   - Empty search state
   - Offline information state

5. NAVIGATION FLOW
   Home/settings/application navigation → AI Models → model catalog.
   Individual model actions currently remain local UI interactions.

6. DYNAMIC COMPONENTS
   - AI model catalog
   - Search query
   - Category filter
   - Selected model
   - Loading state
   - Error state
   - Empty state

7. FUTURE BACKEND INTEGRATION
   Future: connect the model catalog loading boundary to the project's
   model-management/inference configuration so the displayed availability
   reflects actual installed or remotely available components.
   
   Future: connect model selection to the AI pipeline configuration so the
   selected component can participate in its intended processing stage.

8. TECHNOLOGIES USED
   - Flutter
   - Material 3
   - ChangeNotifier from Flutter foundation

9. REQUIRED DATA MODELS
   - AiModelEntity
   - AiModelModel

10. FUTURE API ENDPOINTS
   No endpoint is defined by the current source documentation.

11. DATABASE COLLECTIONS/TABLES
   No database collection/table is defined specifically for this screen.

12. REQUIRED ASSETS
   None. Material Icons are sufficient.

13. REQUIRED ICONS
   - Auto Awesome
   - Graphic Equalizer
   - Translate
   - Psychology
   - Record Voice Over
   - Memory
   - Speed
   - Search
   - Cloud Off
   - Refresh

14. THEME COLORS
   Uses the application's Material 3 ColorScheme without introducing
   feature-specific hard-coded colors.

15. ANIMATIONS
   - Animated model-card selection
   - Animated loading placeholders
   - Standard Material interactions

16. ACCESSIBILITY
   - Semantic icon labels
   - Text hierarchy
   - Accessible search field
   - Adequate touch targets
   - No status communicated by color alone
   - Supports large text through flexible layouts

17. EDGE CASES
   - Empty model catalog
   - Empty search result
   - Long model name
   - Long description
   - Many supported languages
   - Model unavailable
   - Model processing
   - Offline-ready model
   - Small screen width
   - Tablet/landscape layout
   - Dark mode
   - Large system text

18. VALIDATION RULES
   Search is optional and accepts arbitrary local text.
   Category filtering is optional.
   No backend model configuration is performed.

19. ERROR HANDLING
   The UI provides a local error representation and retry action.

20. LOADING STATE
   A local loading representation is displayed while the dummy catalog is
   loaded into the controller.

21. EMPTY STATE
   Search-specific empty state is displayed separately from catalog errors.

22. OFFLINE BEHAVIOUR
   The screen displays offline-ready model metadata and an offline information
   section. No actual connectivity detection or network access is implemented.

23. SECURITY CONSIDERATIONS
   No API keys, tokens, credentials, private endpoints, audio, or user data
   are handled by this UI-only page.

24. PERFORMANCE OPTIMIZATIONS
   - Local immutable dummy data
   - Small reusable widgets
   - Bounded language chip display
   - Controller-level filtering
   - Responsive grid rather than deeply nested fixed-width layouts

25. WIDGET TREE OVERVIEW
   Scaffold
   ├── AppBar
   └── SafeArea
       └── LayoutBuilder
           └── CustomScrollView
               ├── SliverToBoxAdapter
               │   └── AiModelsHeader
               ├── SliverToBoxAdapter
               │   └── AiModelFilterBar
               └── SliverPadding
                   └── SliverGrid / SliverList
                       └── AiModelCard

26. COMPLETE TESTING CHECKLIST
   - Small phone portrait
   - Large phone portrait
   - Phone landscape
   - Tablet portrait
   - Tablet landscape
   - Dark mode
   - Large text
   - Screen reader
   - Search keyboard
   - Search clearing
   - Category filtering
   - Empty results
   - Loading state
   - Error/retry state
   - Offline representation
   - Long model names
   - Long descriptions
   - Long language labels
   - Selection state
   - Card animation
   - Scroll performance
   - Memory stability
   - Localization/RTL readiness
*/

import 'package:flutter/material.dart';

import '../controllers/ai_models_controller.dart';
import '../widgets/ai_model_card.dart';
import '../widgets/ai_model_filter_bar.dart';
import '../widgets/ai_models_header.dart';
import '../widgets/ai_models_states.dart';

class AiModelsPage extends StatefulWidget {
  const AiModelsPage({super.key});

  @override
  State<AiModelsPage> createState() => _AiModelsPageState();
}

class _AiModelsPageState extends State<AiModelsPage> {
  late final AiModelsController _controller;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _controller = AiModelsController();
    _searchController = TextEditingController();

    _controller.loadModels();
  }

  @override
  void dispose() {
    _searchController.dispose();
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
            title: const Text('AI Models'),
            actions: [
              IconButton(
                tooltip: 'Offline model information',
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    showDragHandle: true,
                    builder: (context) {
                      return const SafeArea(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 8, 20, 24),
                          child: AiModelsOfflineState(),
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.cloud_off_outlined),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return CustomScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        horizontal: _horizontalPadding(constraints.maxWidth),
                        vertical: 20,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: AiModelsHeader(
                          modelCount: _controller.models.length,
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        horizontal: _horizontalPadding(constraints.maxWidth),
                      ),
                      sliver: SliverToBoxAdapter(
                        child: AiModelFilterBar(
                          searchController: _searchController,
                          selectedCategory: _controller.selectedCategory,
                          onSearchChanged: _controller.updateSearch,
                          onCategoryChanged: _controller.selectCategory,
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 20)),
                    if (_controller.isLoading)
                      const SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        sliver: SliverToBoxAdapter(
                          child: AiModelsLoadingState(),
                        ),
                      )
                    else if (_controller.errorMessage != null)
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                          horizontal: _horizontalPadding(constraints.maxWidth),
                        ),
                        sliver: SliverToBoxAdapter(
                          child: AiModelsErrorState(
                            message: _controller.errorMessage!,
                            onRetry: () => _controller.loadModels(),
                          ),
                        ),
                      )
                    else if (_controller.filteredModels.isEmpty)
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                          horizontal: _horizontalPadding(constraints.maxWidth),
                        ),
                        sliver: SliverToBoxAdapter(
                          child: AiModelsEmptyState(
                            isFiltered:
                                _controller.searchQuery.isNotEmpty ||
                                _controller.selectedCategory != null,
                            onClearFilters: _clearFilters,
                          ),
                        ),
                      )
                    else
                      _buildModelGrid(constraints.maxWidth),
                    const SliverToBoxAdapter(child: SizedBox(height: 32)),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildModelGrid(double width) {
    final models = _controller.filteredModels;
    final horizontalPadding = _horizontalPadding(width);

    final columns = width >= 1100
        ? 3
        : width >= 700
        ? 2
        : 1;

    if (columns == 1) {
      return SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        sliver: SliverList.separated(
          itemCount: models.length,
          itemBuilder: (context, index) {
            final model = models[index];

            return AiModelCard(
              model: model,
              isSelected: model.id == _controller.selectedModelId,
              onSelect: () => _controller.selectModel(model.id),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 12),
        ),
      );
    }

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          final model = models[index];

          return AiModelCard(
            model: model,
            isSelected: model.id == _controller.selectedModelId,
            onSelect: () => _controller.selectModel(model.id),
          );
        }, childCount: models.length),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: width >= 1100 ? 0.88 : 0.82,
        ),
      ),
    );
  }

  void _clearFilters() {
    _searchController.clear();
    _controller.clearFilters();
  }

  static double _horizontalPadding(double width) {
    if (width >= 1200) {
      return 56;
    }
    if (width >= 700) {
      return 32;
    }
    return 16;
  }
}
