/*
1. PAGE NAME
   Feedback Page

2. PURPOSE
   Provides LinguaLive users with a focused interface for rating and describing
   their experience.

3. DESCRIPTION
   The page is UI-only and uses local dummy feedback configuration. It supports
   rating selection, category selection, multiline feedback, validation,
   simulated loading, success, error, and offline states.

4. UI SECTIONS
   Header
   → Intro
   → Experience rating
   → Feedback category
   → Message field
   → Submit action
   → Submission state.

5. NAVIGATION FLOW
   Existing application screen → FeedbackPage.
   Back action → supplied navigation callback / Navigator.maybePop.
   Successful submission remains on the page so the user can start another
   feedback entry.

6. DYNAMIC COMPONENTS
   Feedback rating
   Feedback category
   Feedback message
   Character counter
   Submit button
   Loading state
   Success state
   Error state
   Offline state.

7. FUTURE BACKEND INTEGRATION
   Future: connect the validated feedback payload to the application's
   feedback service from FeedbackController.submitFeedback(); this location
   owns the form state and keeps the page focused on presentation.

8. TECHNOLOGIES USED
   Flutter Material 3
   Dart null safety
   Local ChangeNotifier state.

9. REQUIRED DATA MODELS
   FeedbackFeatureModel
   FeedbackCategoryEntity
   FeedbackSubmissionState.

10. FUTURE API ENDPOINTS
    The supplied project documentation does not specify a feedback API endpoint,
    so no endpoint is invented here.

11. DATABASE COLLECTIONS/TABLES
    No feedback collection/table is specified by the supplied documentation.
    No persistence is implemented.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Arrow back
    Star
    Feedback categories
    Edit note
    Success/error/offline status icons.

14. THEME COLORS
    Uses the application's Material 3 ColorScheme.
    No hard-coded application palette is introduced.

15. ANIMATIONS
    AnimatedContainer for selectable controls.
    AnimatedSwitcher for submission states.
    Lightweight progress indicator during simulated submission.

16. ACCESSIBILITY
    Semantic rating controls
    Semantic category controls
    Tooltips for icon-only navigation
    Minimum touch target sizing
    TextField labels and hints
    Color is not the only status signal.

17. EDGE CASES
    Empty categories
    Empty message
    Maximum message length
    Invalid rating
    Missing category
    Long text
    Loading state
    Error state
    Offline state
    Large accessibility text
    Narrow width
    Landscape orientation.

18. VALIDATION RULES
    Rating must be 1–5.
    Category must be selected.
    Message must contain non-whitespace content.
    Message cannot exceed the configured maximum length.

19. ERROR HANDLING
    Invalid submission produces a local error state.
    No backend exceptions are handled because no backend exists.

20. LOADING STATE
    Submit action displays a compact progress indicator and temporarily
    disables form interaction.

21. EMPTY STATE
    Empty category configuration displays an explicit message.
    Empty message is handled by form validation.

22. OFFLINE BEHAVIOUR
    A local offline state is available for UI testing.
    No real connectivity detection is performed.

23. SECURITY CONSIDERATIONS
    Feedback is not persisted, uploaded, logged, or sent anywhere.
    No credentials or sensitive personal information are collected by this UI.

24. PERFORMANCE OPTIMIZATIONS
    Local immutable dummy data
    Lightweight widgets
    Single local controller
    No unnecessary animation controllers
    No network or database work during build.

25. WIDGET TREE OVERVIEW
    Scaffold
    └── SafeArea
        └── CustomScrollView
            └── SliverToBoxAdapter
                └── Center
                    └── ConstrainedBox
                        └── Column
                            ├── FeedbackHeader
                            ├── FeedbackRatingCard
                            ├── FeedbackCategorySelector
                            ├── FeedbackMessageField
                            ├── Submit button
                            └── FeedbackStateView.

26. COMPLETE TESTING CHECKLIST
    Layout:
    - Small phone
    - Large phone
    - Tablet
    - Portrait
    - Landscape
    - Large text
    - Keyboard open

    Interaction:
    - Rating 1–5
    - Category selection
    - Text entry
    - Character limit
    - Submit validation
    - Loading
    - Success
    - Error
    - Offline
    - Retry/reset
    - Back navigation

    Accessibility:
    - Screen reader
    - Semantic rating labels
    - Semantic category labels
    - Focus order
    - Touch target sizes
    - Contrast
    - Non-color-only status

    Quality:
    - Dark mode
    - Analyzer
    - Null safety
    - No overflow
    - No deprecated APIs
    - No backend calls
    - No persistence
    - No state-management package
    - Localization readiness
*/

import 'package:flutter/material.dart';

import '../../data/data_sources/mock_feedback_data_source.dart';
import '../../data/models/feedback_feature_model.dart';
import '../controllers/feedback_controller.dart';
import '../widgets/feedback_category_selector.dart';
import '../widgets/feedback_header.dart';
import '../widgets/feedback_message_field.dart';
import '../widgets/feedback_rating_card.dart';
import '../widgets/feedback_states.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key, this.onBackPressed});

  final VoidCallback? onBackPressed;

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  late final FeedbackController _controller;
  late final TextEditingController _messageController;

  @override
  void initState() {
    super.initState();

    _controller = FeedbackController(
      dataSource: const MockFeedbackDataSource(),
    );

    _messageController = TextEditingController();
    _controller.addListener(_handleControllerChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleControllerChanged);
    _controller.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _handleControllerChanged() {
    if (!mounted) {
      return;
    }

    final String controllerMessage = _controller.message;

    if (_messageController.text != controllerMessage) {
      _messageController.value = TextEditingValue(
        text: controllerMessage,
        selection: TextSelection.collapsed(offset: controllerMessage.length),
      );
    }

    setState(() {});
  }

  void _handleBack() {
    if (widget.onBackPressed != null) {
      widget.onBackPressed!();
      return;
    }

    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final FeedbackFeatureModel model = _controller.model;
    final bool isLoading =
        _controller.submissionState == FeedbackSubmissionState.loading;

    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double horizontalPadding = constraints.maxWidth >= 700
                ? 32
                : 20;

            return CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 860),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          16,
                          horizontalPadding,
                          32,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            FeedbackHeader(onBackPressed: _handleBack),
                            const SizedBox(height: 28),
                            _FeedbackIntro(),
                            const SizedBox(height: 20),
                            if (_controller.submissionState ==
                                FeedbackSubmissionState.idle) ...<Widget>[
                              FeedbackRatingCard(
                                rating: _controller.selectedRating,
                                onRatingSelected: _controller.selectRating,
                              ),
                              const SizedBox(height: 16),
                              FeedbackCategorySelector(
                                categories: model.categories,
                                selectedCategoryId:
                                    _controller.selectedCategoryId,
                                onCategorySelected: _controller.selectCategory,
                              ),
                              const SizedBox(height: 20),
                              FeedbackMessageField(
                                controller: _messageController,
                                placeholder: model.placeholder,
                                maxLength: model.maxMessageLength,
                                remainingCharacters:
                                    _controller.remainingCharacters,
                                enabled: !isLoading,
                                onChanged: _controller.updateMessage,
                              ),
                              const SizedBox(height: 20),
                              _SubmitFeedbackButton(
                                enabled: _controller.canSubmit,
                                loading: isLoading,
                                onPressed: _controller.submitFeedback,
                              ),
                            ] else if (_controller.submissionState ==
                                FeedbackSubmissionState.loading) ...<Widget>[
                              const _FeedbackLoadingState(),
                            ] else ...<Widget>[
                              FeedbackStateView(
                                state: _controller.submissionState,
                                onAction: () {
                                  if (_controller.submissionState ==
                                      FeedbackSubmissionState.success) {
                                    _controller.reset();
                                    return;
                                  }

                                  _controller.retry();
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _FeedbackIntro extends StatelessWidget {
  const _FeedbackIntro();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.48),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.forum_rounded, color: theme.colorScheme.primary),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              'Your perspective helps shape a better multilingual '
              'communication experience for everyone.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
                height: 1.45,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubmitFeedbackButton extends StatelessWidget {
  const _SubmitFeedbackButton({
    required this.enabled,
    required this.loading,
    required this.onPressed,
  });

  final bool enabled;
  final bool loading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: FilledButton.icon(
        onPressed: enabled && !loading ? onPressed : null,
        icon: loading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.send_rounded),
        label: Text(loading ? 'Sending…' : 'Send feedback'),
      ),
    );
  }
}

class _FeedbackLoadingState extends StatelessWidget {
  const _FeedbackLoadingState();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
        child: Column(
          children: <Widget>[
            CircularProgressIndicator(
              semanticsLabel: 'Sending feedback',
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 18),
            Text(
              'Sending your feedback…',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Just a moment.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
