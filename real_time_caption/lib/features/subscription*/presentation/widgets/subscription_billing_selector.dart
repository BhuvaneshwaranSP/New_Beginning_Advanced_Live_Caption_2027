/*
1. PAGE NAME
   Subscription Billing Selector

2. PURPOSE
   Lets the user preview monthly or annual subscription pricing.

3. DESCRIPTION
   Local UI-only billing-cycle selection.

4. UI SECTIONS
   Monthly and annual options.

5. NAVIGATION FLOW
   SubscriptionPage → SubscriptionBillingSelector.

6. DYNAMIC COMPONENTS
   Selected billing cycle.

7. FUTURE BACKEND INTEGRATION
   Future: pass the selected billing cycle into the supported purchase flow
   after the user confirms a subscription.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   SubscriptionBillingCycle.

10. FUTURE API ENDPOINTS
    Not specified.

11. DATABASE COLLECTIONS/TABLES
    Not specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    Material segmented-control state animation.

16. ACCESSIBILITY
    SegmentedButton communicates the selected value.

17. EDGE CASES
    Large text and narrow widths.

18. VALIDATION RULES
    Exactly one billing cycle is selected.

19. ERROR HANDLING
    None.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Selection remains local.

23. SECURITY CONSIDERATIONS
    No financial information.

24. PERFORMANCE OPTIMIZATIONS
    Stateless widget.

25. WIDGET TREE OVERVIEW
    SegmentedButton.

26. COMPLETE TESTING CHECKLIST
    Verify both selections and accessibility semantics.
*/

import 'package:flutter/material.dart';

import 'subscription_plan_card.dart';

class SubscriptionBillingSelector extends StatelessWidget {
  const SubscriptionBillingSelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final SubscriptionBillingCycle value;
  final ValueChanged<SubscriptionBillingCycle> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<SubscriptionBillingCycle>(
      segments: const [
        ButtonSegment(
          value: SubscriptionBillingCycle.monthly,
          label: Text('Monthly'),
          icon: Icon(Icons.calendar_month_rounded),
        ),
        ButtonSegment(
          value: SubscriptionBillingCycle.annual,
          label: Text('Annual'),
          icon: Icon(Icons.event_available_rounded),
        ),
      ],
      selected: {value},
      onSelectionChanged: (selection) {
        if (selection.isNotEmpty) {
          onChanged(selection.first);
        }
      },
      showSelectedIcon: false,
    );
  }
}