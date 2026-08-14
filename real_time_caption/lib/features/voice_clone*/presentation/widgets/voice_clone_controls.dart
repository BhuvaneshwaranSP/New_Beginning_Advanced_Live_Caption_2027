/*
1. PAGE NAME
   Voice Clone Controls

2. PURPOSE
   Provides local UI controls for recording and previewing processing.

3. DESCRIPTION
   UI-only controls. No microphone, audio, synthesis, or network operation
   is executed.

4. UI SECTIONS
   Recording button, processing button, and reset action.

5. NAVIGATION FLOW
   Voice Clone page → controls → local controller state.

6. DYNAMIC COMPONENTS
   Recording and processing states.

7. FUTURE BACKEND INTEGRATION
   The recording control is the future entry point for approved voice-sample
   capture. The processing control is the future entry point for the supported
   voice synthesis/profile pipeline.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   None.

10. FUTURE API ENDPOINTS
    Not defined.

11. DATABASE COLLECTIONS/TABLES
    Not defined.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material microphone and play icons.

14. THEME COLORS
    ColorScheme.

15. ANIMATIONS
    AnimatedSwitcher for button content.

16. ACCESSIBILITY
    Buttons have descriptive labels and adequate touch targets.

17. EDGE CASES
    Disabled actions while processing.

18. VALIDATION RULES
    Actions are enabled only for a selected profile.

19. ERROR HANDLING
    Parent provides error state.

20. LOADING STATE
    Processing button shows progress.

21. EMPTY STATE
    Controls are disabled if no profile exists.

22. OFFLINE BEHAVIOUR
    Controls remain UI-only and do not attempt network access.

23. SECURITY CONSIDERATIONS
    No voice recording occurs.

24. PERFORMANCE OPTIMIZATIONS
    Small stateless control widget.

25. WIDGET TREE OVERVIEW
    Column → primary button → secondary button → reset button.

26. COMPLETE TESTING CHECKLIST
    Verify disabled states, animation, semantics, touch targets, and
    dark/light themes.
*/

import 'package:flutter/material.dart';

class VoiceCloneControls extends StatelessWidget {
  const VoiceCloneControls({
    super.key,
    required this.isRecording,
    required this.isProcessing,
    required this.enabled,
    required this.onRecord,
    required this.onProcess,
    required this.onReset,
  });

  final bool isRecording;
  final bool isProcessing;
  final bool enabled;
  final VoidCallback onRecord;
  final VoidCallback onProcess;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FilledButton.icon(
          onPressed: enabled && !isProcessing ? onRecord : null,
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 160),
            child: Icon(
              isRecording
                  ? Icons.stop_circle_outlined
                  : Icons.mic_none_rounded,
              key: ValueKey<bool>(isRecording),
            ),
          ),
          label: Text(isRecording ? 'Stop sample' : 'Record sample'),
        ),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          onPressed: enabled && !isRecording && !isProcessing
              ? onProcess
              : null,
          icon: isProcessing
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.play_circle_outline_rounded),
          label: Text(isProcessing ? 'Processing preview…' : 'Preview state'),
        ),
        const SizedBox(height: 6),
        TextButton(
          onPressed: onReset,
          child: Text(
            'Reset state',
            style: theme.textTheme.labelLarge,
          ),
        ),
      ],
    );
  }
}