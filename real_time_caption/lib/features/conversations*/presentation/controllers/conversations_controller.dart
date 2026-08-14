/*
1. PAGE NAME
   Conversations Controller

2. PURPOSE
   Manages local UI state for the Conversations page.

3. DESCRIPTION
   Provides search, filtering, sorting, and local representation of loading,
   error, and offline states without using a state-management package.

4. UI SECTIONS
   Search field, filter bar, conversation list, and state views.

5. NAVIGATION FLOW
   Page → controller → filtered local conversation list.

6. DYNAMIC COMPONENTS
   Search query, selected filter, sort order, and display state.

7. FUTURE BACKEND INTEGRATION
   Future Session History synchronization belongs here only as a UI-facing
   state transition after a repository/service is connected.

8. TECHNOLOGIES USED
   Flutter foundation ChangeNotifier and Dart.

9. REQUIRED DATA MODELS
   ConversationsFeatureModel.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    Future session-history storage; exact schema unspecified.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    Page widgets animate changes in displayed state.

16. ACCESSIBILITY
    Search state is exposed through normal Flutter controls.

17. EDGE CASES
    Empty query, no search results, empty history, and offline state.

18. VALIDATION RULES
    Search is case-insensitive and trims leading/trailing spaces.

19. ERROR HANDLING
    Local error state with retry action.

20. LOADING STATE
    Local loading state with reset after a short UI-only transition.

21. EMPTY STATE
    Supports both no-history and no-search-result states.

22. OFFLINE BEHAVIOUR
    Explicit local offline state; no connectivity is queried.

23. SECURITY CONSIDERATIONS
    No external data is sent.

24. PERFORMANCE OPTIMIZATIONS
    Filtering is performed only against the small local demonstration set.

25. WIDGET TREE OVERVIEW
    Page → controller → header/filter → state/list.

26. COMPLETE TESTING CHECKLIST
    Verify search, filters, sorting, retry, loading, offline state,
    listener updates, disposal, and responsive UI integration.
*/

import 'package:flutter/foundation.dart';

import '../../data/data_sources/mock_conversations_data_source.dart';
import '../../data/models/conversations_feature_model.dart';

enum ConversationFilter {
  all,
  meetings,
  classrooms,
  personal,
  conferences,
  pinned,
}

enum ConversationSort { recent, alphabetical }

enum ConversationsViewState { success, loading, empty, error, offline }

class ConversationsController extends ChangeNotifier {
  ConversationsController({MockConversationsDataSource? dataSource})
    : _dataSource = dataSource ?? const MockConversationsDataSource() {
    _conversations = _dataSource.getConversations();
  }

  final MockConversationsDataSource _dataSource;

  List<ConversationsFeatureModel> _conversations =
      const <ConversationsFeatureModel>[];

  String _searchQuery = '';
  ConversationFilter _filter = ConversationFilter.all;
  ConversationSort _sort = ConversationSort.recent;
  ConversationsViewState _state = ConversationsViewState.success;

  String get searchQuery => _searchQuery;
  ConversationFilter get filter => _filter;
  ConversationSort get sort => _sort;
  ConversationsViewState get state => _state;

  List<ConversationsFeatureModel> get visibleConversations {
    Iterable<ConversationsFeatureModel> result = _conversations;

    switch (_filter) {
      case ConversationFilter.all:
        break;
      case ConversationFilter.meetings:
        result = result.where(
          (conversation) => conversation.type == ConversationType.meeting,
        );
      case ConversationFilter.classrooms:
        result = result.where(
          (conversation) => conversation.type == ConversationType.classroom,
        );
      case ConversationFilter.personal:
        result = result.where(
          (conversation) => conversation.type == ConversationType.personal,
        );
      case ConversationFilter.conferences:
        result = result.where(
          (conversation) => conversation.type == ConversationType.conference,
        );
      case ConversationFilter.pinned:
        result = result.where((conversation) => conversation.isPinned);
    }

    final String query = _searchQuery.trim().toLowerCase();

    if (query.isNotEmpty) {
      result = result.where(
        (conversation) =>
            conversation.title.toLowerCase().contains(query) ||
            conversation.preview.toLowerCase().contains(query) ||
            conversation.sourceLanguage.toLowerCase().contains(query) ||
            conversation.targetLanguage.toLowerCase().contains(query) ||
            conversation.participants.any(
              (participant) => participant.toLowerCase().contains(query),
            ),
      );
    }

    final List<ConversationsFeatureModel> sorted = result.toList();

    switch (_sort) {
      case ConversationSort.recent:
        break;
      case ConversationSort.alphabetical:
        sorted.sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );
    }

    return sorted;
  }

  bool get isSearchResultEmpty =>
      _searchQuery.trim().isNotEmpty && visibleConversations.isEmpty;

  void updateSearch(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  void updateFilter(ConversationFilter value) {
    _filter = value;
    notifyListeners();
  }

  void updateSort(ConversationSort value) {
    _sort = value;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  void simulateLoading() {
    _state = ConversationsViewState.loading;
    notifyListeners();

    Future<void>.delayed(const Duration(milliseconds: 450), () {
      _state = ConversationsViewState.success;
      notifyListeners();
    });
  }

  void simulateError() {
    _state = ConversationsViewState.error;
    notifyListeners();
  }

  void simulateOffline() {
    _state = ConversationsViewState.offline;
    notifyListeners();
  }

  void retry() {
    _state = ConversationsViewState.loading;
    notifyListeners();

    Future<void>.delayed(const Duration(milliseconds: 450), () {
      _conversations = _dataSource.getConversations();
      _state = ConversationsViewState.success;
      notifyListeners();
    });
  }

  void showEmptyState() {
    _state = ConversationsViewState.empty;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
