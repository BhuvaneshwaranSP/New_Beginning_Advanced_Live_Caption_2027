/*
1. PAGE NAME
   Chat Composer

2. PURPOSE
   Provides the local message-entry interface.

3. DESCRIPTION
   Material 3 composer designed for text input while keeping LinguaLive's
   multilingual context visible.

4. UI SECTIONS
   Attachment action, text field, language indicator, and send action.

5. NAVIGATION FLOW
   ChatPage → ChatComposer.

6. DYNAMIC COMPONENTS
   Typed message text and send-enabled state.

7. FUTURE BACKEND INTEGRATION
   Future: connect the composer to chat conversion and translation processing
   so submitted content can be converted into multilingual chat output.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   None directly.

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
    AnimatedContainer for enabled/disabled send affordance.

16. ACCESSIBILITY
    Clear labels, hint text, and adequate touch targets.

17. EDGE CASES
    Empty, long, and whitespace-only input.

18. VALIDATION RULES
    Send is disabled for empty input.

19. ERROR HANDLING
    No external operation is performed.

20. LOADING STATE
    Not applicable.

21. EMPTY STATE
    Empty input is represented by hint text.

22. OFFLINE BEHAVIOUR
    The composer remains available visually without claiming delivery.

23. SECURITY CONSIDERATIONS
    No message is persisted.

24. PERFORMANCE OPTIMIZATIONS
    Local controller and lightweight widgets.

25. WIDGET TREE OVERVIEW
    Material → Row → attachment → text field → language chip → send.

26. COMPLETE TESTING CHECKLIST
    Test keyboard, large text, empty input, long input, dark mode, semantics,
    orientation, and send callback.
*/

import 'package:flutter/material.dart';

class ChatComposer extends StatefulWidget {
  const ChatComposer({
    super.key,
    required this.onSend,
    required this.onAttachmentPressed,
  });

  final ValueChanged<String> onSend;
  final VoidCallback onAttachmentPressed;

  @override
  State<ChatComposer> createState() => _ChatComposerState();
}

class _ChatComposerState extends State<ChatComposer> {
  late final TextEditingController _textController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _focusNode = FocusNode();

    _textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _textController
      ..removeListener(_onTextChanged)
      ..dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
  }

  void _submit() {
    final text = _textController.text.trim();

    if (text.isEmpty) {
      return;
    }

    widget.onSend(text);
    _textController.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final canSend = _textController.text.trim().isNotEmpty;

    return Material(
      color: colorScheme.surface,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: widget.onAttachmentPressed,
                tooltip: 'Add attachment',
                icon: const Icon(Icons.add_circle_outline_rounded),
              ),
              Expanded(
                child: TextField(
                  controller: _textController,
                  focusNode: _focusNode,
                  minLines: 1,
                  maxLines: 5,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    hintText: 'Write in English, Tamil, Telugu...',
                    filled: true,
                    fillColor: colorScheme.surfaceContainerHighest,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Center(
                        widthFactor: 1,
                        child: Text(
                          'EN → TA',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  onSubmitted: (_) => _submit(),
                ),
              ),
              const SizedBox(width: 6),
              Semantics(
                button: true,
                enabled: canSend,
                label: canSend ? 'Send message' : 'Send message disabled',
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  decoration: BoxDecoration(
                    color: canSend
                        ? colorScheme.primary
                        : colorScheme.surfaceContainerHighest,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: canSend ? _submit : null,
                    tooltip: 'Send message',
                    icon: Icon(
                      Icons.arrow_upward_rounded,
                      color: canSend
                          ? colorScheme.onPrimary
                          : colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
