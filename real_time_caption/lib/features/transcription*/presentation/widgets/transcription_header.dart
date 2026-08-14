/*
1. PAGE NAME
   Transcription Header

2. PURPOSE
   Displays the title, session context, and connection indicator.

3. DESCRIPTION
   Compact Material 3 header for the transcription workspace.

4. UI SECTIONS
   Back affordance, title, session label, status indicator.

5. NAVIGATION FLOW
   TranscriptionPage → Header.

6. DYNAMIC COMPONENTS
   Status label and status icon.

7. FUTURE BACKEND INTEGRATION
   Future: display the actual streaming connection state here;
   this header communicates the current transcription session state.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   None.

10. FUTURE API ENDPOINTS
    None defined.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    Animated status indicator.

16. ACCESSIBILITY
    Semantic status label.

17. EDGE CASES
    Long title and narrow layouts.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    Parent supplies status.

20. LOADING STATE
    Supported through status label.

21. EMPTY STATE
    Supported through status label.

22. OFFLINE BEHAVIOUR
    Supported through status label.

23. SECURITY CONSIDERATIONS
    No sensitive information.

24. PERFORMANCE OPTIMIZATIONS
    Small stateless widget.

25. WIDGET TREE OVERVIEW
    Row → Icon → Title → Status.

26. COMPLETE TESTING CHECKLIST
    Verify small phone and large text layouts.
*/

import 'package:flutter/material.dart';

class TranscriptionHeader extends StatelessWidget {
  const TranscriptionHeader({
    super.key,
    required this.statusLabel,
    required this.statusIcon,
    required this.onBack,
  });

  final String statusLabel;
  final IconData statusIcon;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        IconButton(
          onPressed: onBack,
          tooltip: 'Back',
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Transcription',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Live conversation transcript',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(statusIcon, size: 16),
              const SizedBox(width: 6),
              Text(
                statusLabel,
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
