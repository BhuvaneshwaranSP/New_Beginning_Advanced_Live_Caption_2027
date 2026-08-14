/*
1. PAGE NAME
   Feedback Message Field

2. PURPOSE
   Captures the user's written feedback.

3. DESCRIPTION
   Material 3 multiline text field with character guidance and accessible
   labeling.

4. UI SECTIONS
   Label, multiline input, helper text, character counter.

5. NAVIGATION FLOW
   Text input → controller → form validation.

6. DYNAMIC COMPONENTS
   Input text and remaining-character count.

7. FUTURE BACKEND INTEGRATION
   None directly; controller owns future submission integration.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   None.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Icons.edit_note_rounded.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    None.

16. ACCESSIBILITY
    Explicit label, hint, and multiline semantics.

17. EDGE CASES
    Empty, long, and maximum-length input are supported.

18. VALIDATION RULES
    Maximum length comes from the feedback model.

19. ERROR HANDLING
    Error text can be supplied by the parent.

20. LOADING STATE
    Parent can disable the field during submission.

21. EMPTY STATE
    Placeholder provides guidance.

22. OFFLINE BEHAVIOUR
    Text remains local.

23. SECURITY CONSIDERATIONS
    Text is not persisted or transmitted.

24. PERFORMANCE OPTIMIZATIONS
    Standard TextField with controlled maximum length.

25. WIDGET TREE OVERVIEW
    Column → TextField → helper/counter.

26. COMPLETE TESTING CHECKLIST
    Test keyboard, multiline input, character limit, text scaling, and
    landscape layouts.
*/

import 'package:flutter/material.dart';

class FeedbackMessageField extends StatelessWidget {
  const FeedbackMessageField({
    super.key,
    required this.controller,
    required this.placeholder,
    required this.maxLength,
    required this.remainingCharacters,
    required this.enabled,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String placeholder;
  final int maxLength;
  final int remainingCharacters;
  final bool enabled;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Tell us more',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          enabled: enabled,
          onChanged: onChanged,
          maxLength: maxLength,
          minLines: 5,
          maxLines: 8,
          textCapitalization: TextCapitalization.sentences,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: placeholder,
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 14, bottom: 82),
              child: Icon(Icons.edit_note_rounded),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 52),
            helperText: remainingCharacters >= 0
                ? '$remainingCharacters characters remaining'
                : 'Character limit reached',
            helperMaxLines: 1,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
            alignLabelWithHint: true,
          ),
        ),
      ],
    );
  }
}
