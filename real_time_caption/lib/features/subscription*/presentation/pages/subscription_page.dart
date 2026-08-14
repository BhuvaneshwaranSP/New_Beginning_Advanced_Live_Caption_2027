/*
1. PAGE NAME
   Subscription Page

2. PURPOSE
   Presents LinguaLive subscription options in a clear, multilingual-
   communication-focused Material 3 experience.

3. DESCRIPTION
   The page displays local dummy subscription plans, monthly/annual pricing,
   benefits, current selection, and UI-only loading/empty/error/offline/success
   representations. No real purchase or subscription functionality is included.

4. UI SECTIONS
   - App bar
   - Subscription introduction
   - Current plan status
   - Billing-cycle selector
   - Subscription plan cards
   - Communication benefits
   - Local UI disclaimer

5. NAVIGATION FLOW
   Existing application navigation
        ↓
   SubscriptionPage
        ↓
   Select billing cycle
        ↓
   Select plan
        ↓
   Future subscription purchase integration point

6. DYNAMIC COMPONENTS
   - Local subscription plans
   - Selected plan
   - Billing cycle
   - Local view state
   - Responsive plan layout

7. FUTURE BACKEND INTEGRATION
   Future: connect subscription entitlement and purchase handling at the
   plan-selection action so the selected plan can be sent to the supported
   subscription/billing layer without coupling payment behavior to the UI.

8. TECHNOLOGIES USED
   - Flutter
   - Material 3
   - Local StatefulWidget state
   - Immutable local Dart models

9. REQUIRED DATA MODELS
   - SubscriptionPlanModel
   - SubscriptionPlanEntity
   - SubscriptionBillingCycle
   - SubscriptionViewState

10. FUTURE API ENDPOINTS
    Not specified by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified by the supplied project documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons only.

14. THEME COLORS
    Uses Theme.of(context).colorScheme so the screen automatically follows
    the application's existing light/dark Material 3 themes.

15. ANIMATIONS
    SubscriptionPlanCard uses a lightweight AnimatedContainer selection
    transition.

16. ACCESSIBILITY
    - Semantic selected states
    - Descriptive plan labels
    - Material controls
    - Screen-reader-readable status messages
    - Color-independent selected indication
    - Responsive text wrapping

17. EDGE CASES
    - Empty plan catalog
    - Local loading state
    - Local error state
    - Offline representation
    - Long plan descriptions
    - Many features
    - Large accessibility text
    - Small phone widths
    - Tablet widths
    - Landscape orientation

18. VALIDATION RULES
    - A selected plan must come from the local plan catalog.
    - A billing selector always has exactly one value.
    - No payment information is accepted by this UI.

19. ERROR HANDLING
    UI-only error representation is available through SubscriptionViewState.
    No real service errors are generated or handled.

20. LOADING STATE
    Local loading representation is available through SubscriptionViewState.

21. EMPTY STATE
    Local empty-plan representation is available through SubscriptionViewState.

22. OFFLINE BEHAVIOUR
    The page can represent an offline state, but does not detect connectivity.
    Local dummy plan information remains usable.

23. SECURITY CONSIDERATIONS
    No credentials, payment card data, authentication, billing provider,
    transaction information, or persistent subscription state is processed.

24. PERFORMANCE OPTIMIZATIONS
    - Local immutable dummy data
    - One-time controller data loading
    - Small reusable widgets
    - Limited implicit animation
    - Responsive layout without expensive custom painting

25. WIDGET TREE OVERVIEW
    Scaffold
      ├── AppBar
      └── SafeArea
          └── LayoutBuilder
              └── CustomScrollView
                  ├── Header
                  ├── Current Status Card
                  ├── Billing Selector
                  ├── Plan Section
                  │   └── SubscriptionPlanCard(s)
                  ├── Benefits
                  └── Disclaimer

26. COMPLETE TESTING CHECKLIST
    - Layout and overflow
    - Keyboard/orientation behavior
    - Phone/tablet responsiveness
    - Dark mode
    - Large text
    - Screen reader/accessibility
    - Loading state
    - Empty state
    - Error state
    - Success state
    - Offline state
    - Long/null/invalid local data
    - Plan selection
    - Billing-cycle switching
    - Navigation callback readiness
    - Animation performance
    - Localization readiness
    - Memory/build performance
    - No deprecated APIs
    - No analyzer warnings
*/

import 'package:flutter/material.dart';

import '../../domain/entities/subscription_plan_entity.dart';
import '../controllers/subscription_controller.dart';
import '../widgets/subscription_benefits.dart';
import '../widgets/subscription_billing_selector.dart';
import '../widgets/subscription_header.dart';
import '../widgets/subscription_plan_card.dart';
import '../widgets/subscription_states.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  final SubscriptionController _controller = SubscriptionController();

  late List<SubscriptionPlanEntity> _plans;
  SubscriptionBillingCycle _billingCycle = SubscriptionBillingCycle.monthly;
  SubscriptionViewState _viewState = SubscriptionViewState.ready;
  String? _selectedPlanId;

  @override
  void initState() {
    super.initState();
    _loadLocalPlans();
  }

  void _loadLocalPlans() {
    final plans = _controller.loadPlans();

    setState(() {
      _plans = plans;
      _selectedPlanId = plans.isNotEmpty ? plans.first.id : null;
      _viewState = plans.isEmpty
          ? SubscriptionViewState.empty
          : SubscriptionViewState.ready;
    });
  }

  void _selectPlan(SubscriptionPlanEntity plan) {
    setState(() {
      _selectedPlanId = plan.id;
      _viewState = SubscriptionViewState.ready;
    });

    // Future: connect subscription purchase/entitlement handling here after
    // the user explicitly selects a plan; this callback represents plan choice
    // without performing payment or network operations.
  }

  void _showLocalSuccess() {
    setState(() {
      _viewState = SubscriptionViewState.success;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription'),
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: 'Subscription information',
            onPressed: () {
              setState(() {
                _viewState = SubscriptionViewState.ready;
              });
            },
            icon: const Icon(Icons.info_outline_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 760;
            final horizontalPadding = constraints.maxWidth >= 1100
                ? 48.0
                : constraints.maxWidth >= 600
                ? 32.0
                : 20.0;

            if (_viewState != SubscriptionViewState.ready &&
                _viewState != SubscriptionViewState.success) {
              return SubscriptionStateView(
                state: _viewState,
                onAction: _viewState == SubscriptionViewState.error
                    ? _loadLocalPlans
                    : () {
                        setState(() {
                          _viewState = SubscriptionViewState.ready;
                        });
                      },
              );
            }

            return CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    24,
                    horizontalPadding,
                    40,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1120),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SubscriptionHeader(),
                            const SizedBox(height: 24),
                            _CurrentPlanCard(
                              selectedPlan: _selectedPlan,
                              onChangePlan: () {
                                setState(() {
                                  _viewState = SubscriptionViewState.ready;
                                });
                              },
                              onPreviewSuccess: _showLocalSuccess,
                            ),
                            const SizedBox(height: 28),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Plans',
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SubscriptionBillingSelector(
                                  value: _billingCycle,
                                  onChanged: (cycle) {
                                    setState(() {
                                      _billingCycle = cycle;
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            if (_plans.isEmpty)
                              const SubscriptionStateView(
                                state: SubscriptionViewState.empty,
                              )
                            else
                              _buildPlanLayout(isWide),
                            const SizedBox(height: 28),
                            const SubscriptionBenefits(),
                            const SizedBox(height: 18),
                            _DisclaimerCard(),
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

  SubscriptionPlanEntity? get _selectedPlan {
    for (final plan in _plans) {
      if (plan.id == _selectedPlanId) {
        return plan;
      }
    }

    return null;
  }

  Widget _buildPlanLayout(bool isWide) {
    if (!isWide) {
      return Column(
        children: [
          for (var index = 0; index < _plans.length; index++) ...[
            SubscriptionPlanCard(
              plan: _plans[index],
              billingCycle: _billingCycle,
              isSelected: _plans[index].id == _selectedPlanId,
              onSelect: () => _selectPlan(_plans[index]),
            ),
            if (index != _plans.length - 1) const SizedBox(height: 16),
          ],
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var index = 0; index < _plans.length; index++) ...[
          Expanded(
            child: SubscriptionPlanCard(
              plan: _plans[index],
              billingCycle: _billingCycle,
              isSelected: _plans[index].id == _selectedPlanId,
              onSelect: () => _selectPlan(_plans[index]),
            ),
          ),
          if (index != _plans.length - 1) const SizedBox(width: 16),
        ],
      ],
    );
  }
}

class _CurrentPlanCard extends StatelessWidget {
  const _CurrentPlanCard({
    required this.selectedPlan,
    required this.onChangePlan,
    required this.onPreviewSuccess,
  });

  final SubscriptionPlanEntity? selectedPlan;
  final VoidCallback onChangePlan;
  final VoidCallback onPreviewSuccess;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      elevation: 0,
      color: colors.primaryContainer.withValues(alpha: 0.42),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.workspace_premium_rounded,
              color: colors.primary,
              size: 28,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selected plan',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: colors.onPrimaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    selectedPlan?.name ?? 'No plan selected',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    selectedPlan == null
                        ? 'Choose a plan below to continue.'
                        : 'This is a local UI preview. No purchase has been made.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Wrap(
              spacing: 8,
              children: [
                OutlinedButton(
                  onPressed: onChangePlan,
                  child: const Text('Change'),
                ),
                FilledButton(
                  onPressed: onPreviewSuccess,
                  child: const Text('Preview'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DisclaimerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Semantics(
      container: true,
      label: 'Subscription preview information',
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: colors.outlineVariant),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.lock_outline_rounded,
              size: 20,
              color: colors.onSurfaceVariant,
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Text(
                'This screen is currently a UI preview. Pricing, entitlement, payment, and subscription status are represented with local dummy data only.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.onSurfaceVariant,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
