/*
1. PAGE NAME
   Chat Page

2. PURPOSE
   Provides the primary LinguaLive multilingual chat conversation interface.

3. DESCRIPTION
   The screen represents a conversation where spoken communication can be
   presented as chat, alongside original language, translated language,
   confidence, delivery status, and call actions.

4. UI SECTIONS
   - Chat header
   - Language context strip
   - Incoming call notification
   - Conversation messages
   - Chat composer
   - Local loading/empty/error/offline states

5. NAVIGATION FLOW
   Chat feature → Chat Page.
   Header actions are prepared as callbacks for later application navigation.

6. DYNAMIC COMPONENTS
   Chat messages, message statuses, translation previews, call notification,
   connection state, and composer input.

7. FUTURE BACKEND INTEGRATION
   Future: connect streaming speech-to-text, multilingual translation,
   contextual translation, and chat conversion at the message/controller
   integration points so spoken conversations can appear as translated chat.

8. TECHNOLOGIES USED
   Flutter Material 3, local ChangeNotifier state, local dummy models.

9. REQUIRED DATA MODELS
   ChatFeatureModel and ChatFeatureEntity.

10. FUTURE API ENDPOINTS
    Not specified in the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified in the supplied project documentation.

12. REQUIRED ASSETS
    None required by this UI.

13. REQUIRED ICONS
    Material communication, translation, call, status, and chat icons.

14. THEME COLORS
    Uses Material 3 ColorScheme from the application theme.

15. ANIMATIONS
    Lightweight AnimatedContainer transitions for message bubbles and
    composer send affordance.

16. ACCESSIBILITY
    Semantic message descriptions, labeled icon actions, scalable text,
    adequate touch targets, and color-independent status indicators.

17. EDGE CASES
    Empty conversation, loading, error, offline, long messages, long
    translations, large text, narrow screens, and keyboard visibility.

18. VALIDATION RULES
    Empty outgoing messages are ignored by the composer.

19. ERROR HANDLING
    Local error/retry state only.

20. LOADING STATE
    Local loading indicator before dummy messages are displayed.

21. EMPTY STATE
    Local empty conversation state.

22. OFFLINE BEHAVIOUR
    Local offline representation without implementing connectivity detection.

23. SECURITY CONSIDERATIONS
    No authentication, networking, persistence, audio capture, or sensitive
    credentials are implemented.

24. PERFORMANCE OPTIMIZATIONS
    Uses ListView.builder, const widgets, local state, and lightweight
    presentation components.

25. WIDGET TREE OVERVIEW
    Scaffold
      → Safe header
      → Column
        → language context
        → incoming call card
        → Expanded conversation/state
        → ChatComposer

26. COMPLETE TESTING CHECKLIST
    - Layout/overflow
    - Keyboard
    - Orientation
    - Phone/tablet responsiveness
    - Light/dark theme
    - Large text
    - Screen reader/accessibility
    - Loading
    - Empty
    - Error/retry
    - Success/ready
    - Offline
    - Long/null/invalid text
    - Header actions
    - Message submission
    - State transitions
    - Multilingual Unicode
    - Animation performance
    - Memory/performance
    - Localization readiness
*/

import 'package:flutter/material.dart';

import '../../domain/entities/chat_feature_entity.dart';
import '../controllers/chat_controller.dart';
import '../widgets/chat_composer.dart';
import '../widgets/chat_header.dart';
import '../widgets/chat_message_bubble.dart';
import '../widgets/chat_states.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final ChatController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ChatController();
    _controller.addListener(_onControllerChanged);
    _controller.load();
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onControllerChanged)
      ..dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _handleSend(String text) {
    _controller.addLocalMessage(text);
  }

  void _showHeaderMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Column(
        children: [
          ChatHeader(
            onBackPressed: () {},
            onCallPressed: () {
              _showHeaderMessage('Call action is ready for integration.');
            },
            onVideoPressed: () {
              _showHeaderMessage('Video call action is ready for integration.');
            },
            onMorePressed: () {
              _showChatMenu(context);
            },
          ),
          const Divider(height: 1),
          _LanguageContextStrip(),
          _IncomingCallCard(
            onAcceptPressed: () {
              _showHeaderMessage('Call accepted in the UI preview.');

              // Future: connect the accepted call to the Call Caption flow so
              // live speech recognition and translated captions can begin.
            },
            onRejectPressed: () {
              _showHeaderMessage('Call rejected in the UI preview.');

              // Future: connect rejection to the active call/session lifecycle
              // so the pending multilingual call invitation is dismissed.
            },
          ),
          Expanded(child: _buildConversation()),
          ChatComposer(
            onSend: _handleSend,
            onAttachmentPressed: () {
              _showHeaderMessage('Attachment action is ready for integration.');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildConversation() {
    switch (_controller.state) {
      case ChatViewState.loading:
        return const ChatLoadingState();

      case ChatViewState.empty:
        return ChatEmptyState(
          onStartPressed: () {
            _controller.load();
          },
        );

      case ChatViewState.error:
        return ChatErrorState(onRetryPressed: _controller.retry);

      case ChatViewState.offline:
        return ChatOfflineState(onRetryPressed: _controller.retry);

      case ChatViewState.ready:
        return _ConversationList(messages: _controller.messages);
    }
  }

  void _showChatMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        final theme = Theme.of(sheetContext);

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.history_rounded),
                  title: const Text('Session history'),
                  subtitle: const Text('View previous conversation sessions'),
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    _showHeaderMessage(
                      'Session history is ready for integration.',
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.qr_code_rounded),
                  title: const Text('Session QR'),
                  subtitle: const Text('Connect another participant'),
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    _showHeaderMessage('Session QR is ready for integration.');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.translate_rounded),
                  title: const Text('Language settings'),
                  subtitle: const Text('English ↔ Tamil'),
                  onTap: () {
                    Navigator.of(sheetContext).pop();
                    _showHeaderMessage(
                      'Language selection is ready for integration.',
                    );
                  },
                ),
                const SizedBox(height: 4),
                Text(
                  'LinguaLive conversation tools',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ConversationList extends StatelessWidget {
  const _ConversationList({required this.messages});

  final List<ChatFeatureEntity> messages;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 12),
        itemCount: messages.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const _ConversationDateDivider();
          }

          final message = messages[index - 1];

          return ChatMessageBubble(
            key: ValueKey<String>(message.id),
            message: message,
          );
        },
      ),
    );
  }
}

class _ConversationDateDivider extends StatelessWidget {
  const _ConversationDateDivider();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
      child: Row(
        children: [
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: Text(
                  'Today',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }
}

class _LanguageContextStrip extends StatelessWidget {
  const _LanguageContextStrip();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      color: colorScheme.surfaceContainerLow,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      child: Wrap(
        spacing: 8,
        runSpacing: 6,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(Icons.translate_rounded, size: 18, color: colorScheme.primary),
          Text(
            'Conversation language',
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Chip(
            avatar: const Icon(Icons.language_rounded, size: 16),
            label: const Text('English'),
            visualDensity: VisualDensity.compact,
          ),
          const Icon(Icons.swap_horiz_rounded, size: 18),
          Chip(
            avatar: const Icon(Icons.translate_rounded, size: 16),
            label: const Text('Tamil'),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}

class _IncomingCallCard extends StatelessWidget {
  const _IncomingCallCard({
    required this.onAcceptPressed,
    required this.onRejectPressed,
  });

  final VoidCallback onAcceptPressed;
  final VoidCallback onRejectPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 2),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            child: const Icon(Icons.call_rounded),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Incoming multilingual call',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 3),
                Text(
                  'Ananya · English ↔ Tamil',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton.filledTonal(
            onPressed: onRejectPressed,
            tooltip: 'Reject call',
            icon: const Icon(Icons.call_end_rounded),
          ),
          const SizedBox(width: 6),
          IconButton.filled(
            onPressed: onAcceptPressed,
            tooltip: 'Accept call',
            icon: const Icon(Icons.call_rounded),
          ),
        ],
      ),
    );
  }
}
