/*
1. PAGE NAME
   Splash Controller

2. PURPOSE
   Holds local UI state for the Splash presentation.

3. DESCRIPTION
   Uses Flutter's local ChangeNotifier mechanism only for presentation state.
   No external state-management package is used.

4. UI SECTIONS
   Splash branding and loading progress.

5. NAVIGATION FLOW
   Splash page → controller state → future application navigation.

6. DYNAMIC COMPONENTS
   Loading progress and completion state.

7. FUTURE BACKEND INTEGRATION
   // Future: connect the completed splash state to the application startup
   // routing decision here; navigation belongs in the controller because it
   // coordinates the page's startup transition.

8. TECHNOLOGIES USED
   Flutter foundation ChangeNotifier.

9. REQUIRED DATA MODELS
   SplashFeatureEntity.

10. FUTURE API ENDPOINTS
    None specified.

11. DATABASE COLLECTIONS/TABLES
    None.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    None.

14. THEME COLORS
    None.

15. ANIMATIONS
    Local progress state drives the presentation animation.

16. ACCESSIBILITY
    Exposes a simple loading/completed state to the page.

17. EDGE CASES
    Repeated completion calls are safely ignored.

18. VALIDATION RULES
    Progress remains within 0.0–1.0.

19. ERROR HANDLING
    No external operations are performed.

20. LOADING STATE
    isLoading remains true while local progress is below completion.

21. EMPTY STATE
    Not applicable.

22. OFFLINE BEHAVIOUR
    No connectivity is required.

23. SECURITY CONSIDERATIONS
    No sensitive data is handled.

24. PERFORMANCE OPTIMIZATIONS
    Only notifies listeners when the value changes.

25. WIDGET TREE OVERVIEW
    Controller → Splash page → Branding widget.

26. COMPLETE TESTING CHECKLIST
    Verify progress transitions, disposal, rebuild frequency, and startup UI.
*/

import 'dart:async';

import 'package:flutter/foundation.dart';

class SplashController extends ChangeNotifier {
  SplashController() {
    _timer = Timer.periodic(const Duration(milliseconds: 90), (_) {
      final nextProgress = (_progress + 0.04).clamp(0.0, 1.0);

      if (nextProgress == _progress) {
        return;
      }

      _progress = nextProgress;
      notifyListeners();

      if (_progress >= 1.0) {
        _timer?.cancel();
        _isLoading = false;
        notifyListeners();
      }
    });
  }

  Timer? _timer;
  double _progress = 0.0;
  bool _isLoading = true;

  double get progress => _progress;

  bool get isLoading => _isLoading;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
