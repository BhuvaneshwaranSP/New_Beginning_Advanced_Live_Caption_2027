/*
1. PAGE NAME
   Chat Controller

2. PURPOSE
   Holds local UI state for the Chat screen.

3. DESCRIPTION
   Provides local message data and state transitions without external
   state-management packages or real services.

4. UI SECTIONS
   Conversation and message composer.

5. NAVIGATION FLOW
   ChatPage → ChatController → Chat widgets.

6. DYNAMIC COMPONENTS
   Messages, loading state, empty state, error state, and offline state.

7. FUTURE BACKEND INTEGRATION
   Future: connect the chat conversion and multilingual translation pipeline
   here so spoken conversations can become translated chat messages.

8. TECHNOLOGIES USED
   Flutter foundation only.

9. REQUIRED DATA MODELS
   ChatFeatureEntity.

10. FUTURE API ENDPOINTS
    Not specified in supplied documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified in supplied documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    Presentation widgets handle animations.

16. ACCESSIBILITY
    State is exposed through widgets with semantic labels.

17. EDGE CASES
    Empty messages, loading, local error, and offline state.

18. VALIDATION RULES
    Empty composer text is ignored.

19. ERROR HANDLING
    Local demo error state can be activated for UI validation.

20. LOADING STATE
    Local loading state is available.

21. EMPTY STATE
    Local empty state is available.

22. OFFLINE BEHAVIOUR
    Local offline state is available.

23. SECURITY CONSIDERATIONS
    No external data or credentials.

24. PERFORMANCE OPTIMIZATIONS
    State changes are local to the page.

25. WIDGET TREE OVERVIEW
    ChatPage → controller state → presentation widgets.

26. COMPLETE TESTING CHECKLIST
    Test loading, empty, error, offline, send, and message-list transitions.
*/

import 'package:flutter/foundation.dart';

import '../../data/data_sources/mock_chat_data_source.dart';
import '../../domain/entities/chat_feature_entity.dart';

enum ChatViewState { loading, ready, empty, error, offline }

class ChatController extends ChangeNotifier {
  ChatController({MockChatDataSource? dataSource})
    : _dataSource = dataSource ?? const MockChatDataSource();

  final MockChatDataSource _dataSource;

  List<ChatFeatureEntity> _messages = const <ChatFeatureEntity>[];
  ChatViewState _state = ChatViewState.loading;

  List<ChatFeatureEntity> get messages =>
      List<ChatFeatureEntity>.unmodifiable(_messages);

  ChatViewState get state => _state;

  void load() {
    _state = ChatViewState.loading;
    notifyListeners();

    final models = _dataSource.loadMessages();

    _messages = models.map((model) => model.toEntity()).toList(growable: false);

    _state = _messages.isEmpty ? ChatViewState.empty : ChatViewState.ready;
    notifyListeners();
  }

  void showEmptyState() {
    _messages = const <ChatFeatureEntity>[];
    _state = ChatViewState.empty;
    notifyListeners();
  }

  void showErrorState() {
    _state = ChatViewState.error;
    notifyListeners();
  }

  void showOfflineState() {
    _state = ChatViewState.offline;
    notifyListeners();
  }

  void retry() {
    load();
  }

  void addLocalMessage(String text) {
    final trimmedText = text.trim();

    if (trimmedText.isEmpty) {
      return;
    }

    final message = ChatFeatureEntity(
      id: 'local-${DateTime.now().microsecondsSinceEpoch}',
      senderName: 'You',
      isMine: true,
      originalText: trimmedText,
      translatedText: 'Translation preview',
      sourceLanguage: 'English',
      targetLanguage: 'Tamil',
      timestamp: 'Now',
      status: ChatMessageStatus.sent,
      confidence: null,
    );

    _messages = <ChatFeatureEntity>[..._messages, message];

    _state = ChatViewState.ready;
    notifyListeners();

    // Future: connect outgoing chat conversion and translation here so a real
    // spoken or typed message can be processed before appearing in the chat.
  }
}
