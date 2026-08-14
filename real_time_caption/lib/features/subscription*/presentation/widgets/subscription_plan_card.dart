/*
1. PAGE NAME
   Subscription Plan Card

2. PURPOSE
   Displays one selectable LinguaLive subscription plan.

3. DESCRIPTION
   Material 3 card with pricing, plan information, included capabilities,
   popularity indication, and selection state.

4. UI SECTIONS
   Badge, plan name, description, price, feature list, selection button.

5. NAVIGATION FLOW
   SubscriptionPage → SubscriptionPlanCard.

6. DYNAMIC COMPONENTS
   Plan entity, billing cycle, selected state.

7. FUTURE BACKEND INTEGRATION
   Future: connect the selection/upgrade action here to the supported
   subscription purchase flow; this location represents the user's explicit
   intent to choose the displayed plan.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   SubscriptionPlanEntity.

10. FUTURE API ENDPOINTS
    Not specified.

11. DATABASE COLLECTIONS/TABLES
    Not specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Icons.check_rounded.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    AnimatedContainer for selection emphasis.

16. ACCESSIBILITY
    Entire card communicates selected status and plan name.

17. EDGE CASES
    Long names, long descriptions, and many features.

18. VALIDATION RULES
    Plan identifier determines selection.

19. ERROR HANDLING
    None; page-level local state may represent an error.

20. LOADING STATE
    Parent may represent local loading.

21. EMPTY STATE
    Parent handles empty plan catalog.

22. OFFLINE BEHAVIOUR
    Selection remains local; no purchase occurs.

23. SECURITY CONSIDERATIONS
    No payment details collected.

24. PERFORMANCE OPTIMIZATIONS
    Stateless card and limited implicit animation.

25. WIDGET TREE OVERVIEW
    AnimatedContainer → Column → pricing → features → button.

26. COMPLETE TESTING CHECKLIST
    Verify selection, text scaling, overflow, semantics, and dark mode.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/subscription_plan_entity.dart';

class SubscriptionPlanCard extends StatelessWidget {
  const SubscriptionPlanCard({
    super.key,
    required this.plan,
    required this.billingCycle,
    required this.isSelected,
    required this.onSelect,
  });

  final SubscriptionPlanEntity plan;
  final SubscriptionBillingCycle billingCycle;
  final bool isSelected;
  final VoidCallback onSelect;

  String get _formattedPrice {
    final price = billingCycle == SubscriptionBillingCycle.monthly
        ? plan.monthlyPrice
        : plan.annualPrice;

    if (price == 0) {
      return 'Free';
    }

    final display = price == price.roundToDouble()
        ? price.toStringAsFixed(0)
        : price.toStringAsFixed(2);

    return '${plan.currency}$display';
  }

  String get _billingLabel {
    if (plan.monthlyPrice == 0 && plan.annualPrice == 0) {
      return 'No payment required';
    }

    return billingCycle == SubscriptionBillingCycle.monthly
        ? 'per month'
        : 'per year';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Semantics(
      container: true,
      selected: isSelected,
      label: '${plan.name} plan, ${isSelected ? 'selected' : 'not selected'}',
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: isSelected
              ? colors.primaryContainer.withValues(alpha: 0.45)
              : colors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? colors.primary : colors.outlineVariant,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (plan.badge != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: colors.secondaryContainer,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      plan.badge!,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colors.onSecondaryContainer,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              if (plan.badge != null) const SizedBox(height: 14),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      plan.name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (plan.isPopular)
                    Icon(
                      Icons.star_rounded,
                      color: colors.primary,
                      semanticLabel: 'Popular plan',
                    ),
                ],
              ),
              const SizedBox(height: 7),
              Text(
                plan.description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                spacing: 7,
                children: [
                  Text(
                    _formattedPrice,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      _billingLabel,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Divider(color: colors.outlineVariant),
              const SizedBox(height: 12),
              Text(
                'Includes',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              ...plan.features.map(
                (feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 9),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_rounded,
                        size: 19,
                        color: colors.primary,
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: Text(
                          feature,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 7),
              SizedBox(
                width: double.infinity,
                child: isSelected
                    ? FilledButton.tonalIcon(
                        onPressed: onSelect,
                        icon: const Icon(Icons.check_circle_rounded),
                        label: const Text('Selected'),
                      )
                    : OutlinedButton(
                        onPressed: onSelect,
                        child: const Text('Choose plan'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum SubscriptionBillingCycle {
  monthly,
  annual,
}