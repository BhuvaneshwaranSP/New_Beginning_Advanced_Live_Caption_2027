/*
1. PAGE NAME
   Contacts Header

2. PURPOSE
   Provides the premium LinguaLive Contacts screen header.

3. DESCRIPTION
   Displays the page title, contact count, and an add-contact action.

4. UI SECTIONS
   Title, subtitle, and add action.

5. NAVIGATION FLOW
   ContactsPage → ContactsHeader.

6. DYNAMIC COMPONENTS
   Contact count.

7. FUTURE BACKEND INTEGRATION
   The add-contact callback can later open the intended contact/session
   creation flow. No functionality is implemented here.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   Integer contact count.

10. FUTURE API ENDPOINTS
    Not specified.

11. DATABASE COLLECTIONS/TABLES
    Not specified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Icons.person_add_alt_1.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Tooltip and semantic label on the action.

17. EDGE CASES
    Zero contacts.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    Not applicable.

20. LOADING STATE
    Count can be zero while loading.

21. EMPTY STATE
    Handled by page state widgets.

22. OFFLINE BEHAVIOUR
    Handled by page state widgets.

23. SECURITY CONSIDERATIONS
    No personal information is created.

24. PERFORMANCE OPTIMIZATIONS
    Stateless widget and const children.

25. WIDGET TREE OVERVIEW
    Row → title column + IconButton.

26. COMPLETE TESTING CHECKLIST
    Verify title, count, action semantics, and narrow-width behavior.
*/

import 'package:flutter/material.dart';

class ContactsHeader extends StatelessWidget {
  const ContactsHeader({
    super.key,
    required this.contactCount,
    required this.onAddContact,
  });

  final int contactCount;
  final VoidCallback onAddContact;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Contacts',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$contactCount people ready to connect',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        IconButton.filledTonal(
          tooltip: 'Add contact',
          onPressed: onAddContact,
          icon: const Icon(Icons.person_add_alt_1_rounded),
        ),
      ],
    );
  }
}
