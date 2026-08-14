/*
1. PAGE NAME
   Profile Page

2. PURPOSE
   Provides the main LinguaLive profile screen for viewing account identity,
   communication languages, and profile-related actions.

3. DESCRIPTION
   The page is a UI-only Material 3 implementation using local dummy profile
   data. It deliberately does not implement authentication, persistence,
   networking, profile editing, or account APIs.

4. UI SECTIONS
   - Profile app bar
   - Profile identity header
   - Communication language preferences
   - Profile actions
   - Loading, empty, error, and offline representations

5. NAVIGATION FLOW
   Application → Profile → profile-related actions.

   Action callbacks are intentionally empty because navigation and account
   functionality are outside this UI-only implementation.

6. DYNAMIC COMPONENTS
   ProfileFeatureEntity, ProfileController state, language pair, and action
   tiles.

7. FUTURE BACKEND INTEGRATION
   Future: connect the profile repository to ProfileController.loadProfile()
   so persisted account/profile information replaces the local dummy source.

   Future: connect application routing to the action callbacks in
   ProfileActionList so profile settings, language preferences, privacy, and
   sign-out follow the project's navigation/authentication flow.

8. TECHNOLOGIES USED
   Flutter Material 3
   Local ChangeNotifier
   Dart null safety

9. REQUIRED DATA MODELS
   ProfileFeatureModel
   ProfileFeatureEntity

10. FUTURE API ENDPOINTS
    Not specified by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not specified by the supplied project documentation.

12. REQUIRED ASSETS
    No mandatory assets. Profile initials provide a local avatar fallback.

13. REQUIRED ICONS
    Material Icons:
    person, language, translate, edit, privacy, logout, refresh, wifi_off.

14. THEME COLORS
    Uses the application Material 3 ColorScheme and automatically adapts to
    light and dark themes.

15. ANIMATIONS
    AnimatedSwitcher is used for lightweight state transitions.

16. ACCESSIBILITY
    - Semantic profile avatar label
    - Semantic action labels
    - Text-based status communication
    - Adequate Material touch targets
    - Large-text-safe flexible layouts
    - Color is not the only indicator of state

17. EDGE CASES
    - Long profile names
    - Long email addresses
    - Long multilingual language names
    - Small phone widths
    - Tablet widths
    - Landscape orientation
    - Large text scaling
    - Loading state
    - Empty state
    - Error state
    - Offline-demo state

18. VALIDATION RULES
    No remote validation is performed.
    UI safely renders the supplied local dummy values.

19. ERROR HANDLING
    The controller exposes a local error state and the page displays a retry
    representation.

20. LOADING STATE
    ProfileUiState.loading displays a progress indicator.

21. EMPTY STATE
    ProfileUiState.empty displays an informative empty state.

22. OFFLINE BEHAVIOUR
    ProfileUiState.offline provides a local offline representation.
    No real connectivity detection is implemented.

23. SECURITY CONSIDERATIONS
    No password, authentication token, session token, or private credential is
    displayed or persisted by this UI-only screen.

24. PERFORMANCE OPTIMIZATIONS
    - Local ChangeNotifier scoped to the page
    - Small immutable domain model
    - Const widgets where possible
    - No network operations
    - No expensive custom painting
    - Lightweight implicit animation

25. WIDGET TREE OVERVIEW
    ProfilePage
      └── SafeArea
          └── LayoutBuilder
              └── Center
                  └── ConstrainedBox
                      └── CustomScrollView
                          ├── SliverAppBar
                          └── SliverPadding
                              └── SliverList
                                  ├── ProfileHeader
                                  ├── LanguagePreferenceCard
                                  └── ProfileActionList

26. COMPLETE TESTING CHECKLIST
    - Layout/overflow
    - Keyboard and focus behavior
    - Orientation
    - Phone/tablet responsiveness
    - Dark mode
    - Large text
    - Screen reader/accessibility
    - Loading
    - Empty
    - Error/retry
    - Success
    - Offline representation
    - Long multilingual data
    - Null-safe values
    - Action callbacks
    - State transitions
    - Animation smoothness
    - Performance
    - Memory
    - Localization readiness
*/

import 'package:flutter/material.dart';
import '../controllers/profile_controller.dart';
import '../widgets/language_preference_card.dart';
import '../widgets/profile_action_list.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_states.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ProfileController()..loadProfile();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _retry() {
    _controller.loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final profile = _controller.profile;
        final isSuccess =
            _controller.state == ProfileUiState.success && profile != null;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            centerTitle: false,
            actions: [
              Semantics(
                button: true,
                label: 'Refresh profile',
                child: IconButton(
                  tooltip: 'Refresh profile',
                  onPressed: _retry,
                  icon: const Icon(Icons.refresh_rounded),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final horizontalPadding = constraints.maxWidth >= 700
                    ? 32.0
                    : 16.0;

                return Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: CustomScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      slivers: [
                        SliverPadding(
                          padding: EdgeInsets.fromLTRB(
                            horizontalPadding,
                            8,
                            horizontalPadding,
                            32,
                          ),
                          sliver: SliverList(
                            delegate: SliverChildListDelegate([
                              if (isSuccess) ...[
                                ProfileHeader(profile: profile),
                                const SizedBox(height: 16),
                                LanguagePreferenceCard(profile: profile),
                                const SizedBox(height: 16),
                                const ProfileActionList(),
                              ] else ...[
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 220),
                                  switchInCurve: Curves.easeOut,
                                  switchOutCurve: Curves.easeIn,
                                  child: ProfileStateView(
                                    key: ValueKey<ProfileUiState>(
                                      _controller.state,
                                    ),
                                    state: _controller.state,
                                    onRetry: _retry,
                                  ),
                                ),
                              ],
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
