/*
1. PAGE NAME
   Authentication Controller

2. PURPOSE
   Manages local presentation state for the authentication page.

3. DESCRIPTION
   Uses Flutter's built-in ChangeNotifier only; no external state-management
   package is required.

4. UI SECTIONS
   Authentication mode, loading state, and local form feedback.

5. NAVIGATION FLOW
   Authentication page → controller → application navigation callback.

6. DYNAMIC COMPONENTS
   Sign-in/create-account mode, loading indicator, and validation messages.

7. FUTURE BACKEND INTEGRATION
   Future: connect the project's authentication service here when its
   authentication contract is defined; this controller owns submission state
   for the authentication page.

8. TECHNOLOGIES USED
   Flutter foundation.

9. REQUIRED DATA MODELS
   AuthenticationMode.

10. FUTURE API ENDPOINTS
    Not defined by the supplied documentation.

11. DATABASE COLLECTIONS/TABLES
    Not defined by the supplied documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    Controlled by the Material 3 application theme.

15. ANIMATIONS
    Mode changes are handled by presentation widgets.

16. ACCESSIBILITY
    State changes are exposed through normal Flutter widget rebuilding.

17. EDGE CASES
    Empty fields, invalid credentials format, repeated submit taps.

18. VALIDATION RULES
    Email must have a basic valid structure.
    Password must contain at least eight characters.

19. ERROR HANDLING
    Local validation only.

20. LOADING STATE
    A short local processing state is available for UI verification.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    No network request is attempted.

23. SECURITY CONSIDERATIONS
    Credentials are never persisted or transmitted.

24. PERFORMANCE OPTIMIZATIONS
    Notifications occur only when relevant controller state changes.

25. WIDGET TREE OVERVIEW
    Page → form → controller state.

26. COMPLETE TESTING CHECKLIST
    Verify validation, mode switching, repeated submissions, and disposal.
*/

import 'package:flutter/foundation.dart';

import '../../data/models/authentication_feature_model.dart';

class AuthenticationController extends ChangeNotifier {
  AuthenticationController({required AuthenticationMode initialMode})
    : _mode = initialMode;

  AuthenticationMode _mode;
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  AuthenticationMode get mode => _mode;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  bool get isCreatingAccount => _mode == AuthenticationMode.createAccount;

  void setMode(AuthenticationMode mode) {
    if (_mode == mode) {
      return;
    }

    _mode = mode;
    _clearMessages();
    notifyListeners();
  }

  Future<void> submit({required String email, required String password}) async {
    _clearMessages();

    final normalizedEmail = email.trim();

    if (!_isValidEmail(normalizedEmail)) {
      _errorMessage = 'Enter a valid email address.';
      notifyListeners();
      return;
    }

    if (password.length < 8) {
      _errorMessage = 'Password must contain at least 8 characters.';
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    await Future<void>.delayed(const Duration(milliseconds: 650));

    _isLoading = false;

    // Future: connect the authentication service here; this UI currently
    // completes locally so the screen can be integrated without backend work.
    _successMessage = isCreatingAccount
        ? 'Account details are ready for the next integration step.'
        : 'Sign-in details are ready for the next integration step.';

    notifyListeners();
  }

  void clearFeedback() {
    _clearMessages();
    notifyListeners();
  }

  void _clearMessages() {
    _errorMessage = null;
    _successMessage = null;
  }

  bool _isValidEmail(String value) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
  }
}
