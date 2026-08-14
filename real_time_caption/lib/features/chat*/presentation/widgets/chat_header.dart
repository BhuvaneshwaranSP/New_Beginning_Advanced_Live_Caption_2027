/*
1. PAGE NAME
   Chat Header

2. PURPOSE
   Presents the active conversation identity, language direction, and call
   actions.

3. DESCRIPTION
   Provides a compact Material 3 header for multilingual conversation context.

4. UI SECTIONS
   Back action, avatar, participant name, connection status, language pair,
   and call actions.

5. NAVIGATION FLOW
   ChatPage → ChatHeader.

6. DYNAMIC COMPONENTS
   Participant information and language pair.

7. FUTURE BACKEND INTEGRATION
   Future: connect the call action to the project's Call Caption flow so the
   conversation can transition into a multilingual call session.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   Local header display values.

10. FUTURE API ENDPOINTS
    Not specified in supplied documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified in supplied documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Tooltips and semantic labels for icon actions.

17. EDGE CASES
    Narrow widths and large text.

18. VALIDATION RULES
    None.

19. ERROR HANDLING
    Connection state is represented visually.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    Connection label changes to Offline.

23. SECURITY CONSIDERATIONS
    No call or network operation is performed.

24. PERFORMANCE OPTIMIZATIONS
    Stateless widget and const-compatible components.

25. WIDGET TREE OVERVIEW
    Row → avatar → identity → language pair → actions.

26. COMPLETE TESTING CHECKLIST
    Test narrow width, large text, dark mode, semantics, and action callbacks.
*/

import 'package:flutter/material.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({
    super.key,
    required this.onBackPressed,
    required this.onCallPressed,
    required this.onVideoPressed,
    required this.onMorePressed,
    this.isOnline = true,
  });

  final VoidCallback onBackPressed;
  final VoidCallback onCallPressed;
  final VoidCallback onVideoPressed;
  final VoidCallback onMorePressed;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: colorScheme.surface,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
          child: Row(
            children: [
              IconButton(
                onPressed: onBackPressed,
                tooltip: 'Back',
                icon: const Icon(Icons.arrow_back_rounded),
              ),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  'A',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ananya',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 8,
                          color: isOnline
                              ? colorScheme.primary
                              : colorScheme.outline,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            isOnline ? 'Online · English ↔ Tamil' : 'Offline',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onCallPressed,
                tooltip: 'Start call',
                icon: const Icon(Icons.call_outlined),
              ),
              IconButton(
                onPressed: onVideoPressed,
                tooltip: 'Start video call',
                icon: const Icon(Icons.videocam_outlined),
              ),
              IconButton(
                onPressed: onMorePressed,
                tooltip: 'More options',
                icon: const Icon(Icons.more_vert_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
