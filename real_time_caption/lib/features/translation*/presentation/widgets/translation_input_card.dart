/*
1. PAGE NAME
   Translation Input Card

2. PURPOSE
   Captures source text for the local translation demonstration.

3. DESCRIPTION
   Material 3 text input with character guidance, clear action, and translate action.

4. UI SECTIONS
   Input label, text field, utility row, and primary translation button.

5. NAVIGATION FLOW
   TranslationPage → TranslationInputCard → TranslationController.

6. DYNAMIC COMPONENTS
   Source text and processing state.

7. FUTURE BACKEND INTEGRATION
   Future: source text may be populated by the project's Speech-to-Text
   and streaming ASR pipeline at this integration boundary.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   None directly.

10. FUTURE API ENDPOINTS
    Not specified by source documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified by source documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Icons.edit_note, clear, translate, and microphone.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    Button processing transition.

16. ACCESSIBILITY
    Text field label, hint, character count, and action semantics.

17. EDGE CASES
    Empty, long, and whitespace-only text.

18. VALIDATION RULES
    Empty text should not trigger a real translation operation.

19. ERROR HANDLING
    Empty-input handling is delegated to the controller.

20. LOADING STATE
    Button shows progress when processing.

21. EMPTY STATE
    Hint text explains what to enter.

22. OFFLINE BEHAVIOUR
    Voice action has no real processing in UI-only mode.

23. SECURITY CONSIDERATIONS
    Text remains local.

24. PERFORMANCE OPTIMIZATIONS
    Text controller is owned by the parent page.

25. WIDGET TREE OVERVIEW
    Card → TextField → utility row → action buttons.

26. COMPLETE TESTING CHECKLIST
    Verify keyboard, focus, character count, long text, large text, and button states.
*/

import 'package:flutter/material.dart';

class TranslationInputCard extends StatelessWidget {
  const TranslationInputCard({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
    required this.onTranslate,
    required this.isProcessing,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final VoidCallback onTranslate;
  final bool isProcessing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.edit_note_rounded,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Your message',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                if (controller.text.isNotEmpty)
                  IconButton(
                    tooltip: 'Clear text',
                    onPressed: onClear,
                    icon: const Icon(Icons.close_rounded),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              minLines: 7,
              maxLines: 12,
              maxLength: 2000,
              onChanged: onChanged,
              textInputAction: TextInputAction.newline,
              decoration: const InputDecoration(
                hintText: 'Type the message you want to translate…',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Text input is used for this UI demonstration.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Tooltip(
                  message: 'Voice input',
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.mic_none_rounded),
                  ),
                ),
                const SizedBox(width: 4),
                FilledButton.icon(
                  onPressed: isProcessing ? () {} : onTranslate,
                  icon: isProcessing
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.translate_rounded),
                  label: Text(isProcessing ? 'Translating' : 'Translate'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}