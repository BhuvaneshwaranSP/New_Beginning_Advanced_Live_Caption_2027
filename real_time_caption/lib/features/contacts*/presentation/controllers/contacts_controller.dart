/*
1. PAGE NAME
   Contacts Controller

2. PURPOSE
   Controls local UI state for the Contacts screen.

3. DESCRIPTION
   Manages search, filter selection, loading, error, empty, and offline demo
   states using only Flutter's local ChangeNotifier.

4. UI SECTIONS
   Search, filter chips, contact list, and state views.

5. NAVIGATION FLOW
   ContactsPage → ContactsController → local data source.

6. DYNAMIC COMPONENTS
   Search query, selected filter, contact list, and UI state.

7. FUTURE BACKEND INTEGRATION
   Replace the local data loading boundary with the intended Contacts
   repository while keeping search and presentation contracts stable.

8. TECHNOLOGIES USED
   Flutter foundation ChangeNotifier.

9. REQUIRED DATA MODELS
   ContactFeatureModel and ContactFeatureEntity.

10. FUTURE API ENDPOINTS
    Not specified in the supplied documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified in the supplied documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    Provided by the page's Material 3 theme.

15. ANIMATIONS
    Presentation widgets handle lightweight animations.

16. ACCESSIBILITY
    State changes are exposed through normal widget rebuilds and labels.

17. EDGE CASES
    Empty list, no search result, long queries, and local error state.

18. VALIDATION RULES
    Search is trimmed and matched case-insensitively.

19. ERROR HANDLING
    Local demo error state with retry callback.

20. LOADING STATE
    Local demo loading state.

21. EMPTY STATE
    Empty collection and no-result states.

22. OFFLINE BEHAVIOUR
    Local offline demo state.

23. SECURITY CONSIDERATIONS
    No external services or personal information.

24. PERFORMANCE OPTIMIZATIONS
    Filtering is performed over a small local immutable list.

25. WIDGET TREE OVERVIEW
    Controller → header/search/filter/list/state widgets.

26. COMPLETE TESTING CHECKLIST
    Test each state, filter, search transition, and retry callback.
*/

import 'package:flutter/foundation.dart';

import '../../data/data_sources/mock_contacts_data_source.dart';
import '../../data/models/contacts_feature_model.dart';

enum ContactsViewState { loading, success, empty, error, offline }

enum ContactsFilter { all, favorites, online }

class ContactsController extends ChangeNotifier {
  ContactsController({MockContactsDataSource? dataSource})
    : _dataSource = dataSource ?? const MockContactsDataSource();

  final MockContactsDataSource _dataSource;

  List<ContactFeatureModel> _contacts = <ContactFeatureModel>[];
  String _searchQuery = '';
  ContactsFilter _filter = ContactsFilter.all;
  ContactsViewState _state = ContactsViewState.loading;

  List<ContactFeatureModel> get contacts => List.unmodifiable(_contacts);

  String get searchQuery => _searchQuery;

  ContactsFilter get filter => _filter;

  ContactsViewState get state => _state;

  void load() {
    _state = ContactsViewState.loading;
    notifyListeners();

    _contacts = _dataSource.loadContacts();

    _state = _contacts.isEmpty
        ? ContactsViewState.empty
        : ContactsViewState.success;

    notifyListeners();
  }

  void setSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  void setFilter(ContactsFilter value) {
    _filter = value;
    notifyListeners();
  }

  void showError() {
    _state = ContactsViewState.error;
    notifyListeners();
  }

  void showOffline() {
    _state = ContactsViewState.offline;
    notifyListeners();
  }

  void retry() {
    load();
  }

  void clearSearch() {
    if (_searchQuery.isEmpty) {
      return;
    }

    _searchQuery = '';
    notifyListeners();
  }

  List<ContactFeatureModel> get filteredContacts {
    Iterable<ContactFeatureModel> result = _contacts;

    switch (_filter) {
      case ContactsFilter.all:
        break;
      case ContactsFilter.favorites:
        result = result.where((contact) => contact.isFavorite);
      case ContactsFilter.online:
        result = result.where((contact) => contact.isOnline);
    }

    final String query = _searchQuery.trim().toLowerCase();

    if (query.isEmpty) {
      return result.toList(growable: false);
    }

    return result
        .where(
          (contact) =>
              contact.name.toLowerCase().contains(query) ||
              contact.primaryLanguage.toLowerCase().contains(query) ||
              contact.secondaryLanguage.toLowerCase().contains(query),
        )
        .toList(growable: false);
  }
}
