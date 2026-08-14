/*
1. PAGE NAME
   Authentication Page

2. PURPOSE
   Provides the main LinguaLive authentication entry screen.

3. DESCRIPTION
   A responsive Material 3 authentication surface supporting sign-in and
   account-creation presentation using local dummy state only.

4. UI SECTIONS
   Brand header, authentication mode switcher, authentication form, state
   feedback, and small product positioning content.

5. NAVIGATION FLOW
   Application route → AuthenticationPage.
   Successful local UI submission → supplied onAuthenticated callback.
   The actual destination is intentionally controlled by the application's
   router because the supplied project documentation does not define the
   authentication navigation destination.

6. DYNAMIC COMPONENTS
   Authentication mode, password visibility, validation state, loading state,
   and success/error feedback.

7. FUTURE BACKEND INTEGRATION
   Future: connect the authentication controller to the project's real
   authentication service at form submission; this page remains responsible
   for presentation and navigation callbacks.

8. TECHNOLOGIES USED
   Flutter Material 3 and built-in Flutter state.

9. REQUIRED DATA MODELS
   AuthenticationFeatureModel and AuthenticationFeatureEntity.

10. FUTURE API ENDPOINTS
    Not defined by the supplied project documentation.

11. DATABASE COLLECTIONS/TABLES
    Not defined by the supplied project documentation.

12. REQUIRED ASSETS
    None required.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Uses Theme.of(context).colorScheme so existing LinguaLive light/dark
    application themes can control the screen.

15. ANIMATIONS
    AnimatedSwitcher for feedback and mode-dependent content.

16. ACCESSIBILITY
    Semantic application identity, labelled form controls, touch-friendly
    controls, scalable typography, keyboard support, and live-region feedback.

17. EDGE CASES
    Small displays, tablets, landscape mode, keyboard, large text, long
    localized strings, invalid form values, repeated taps, and dark mode.

18. VALIDATION RULES
    Email must use a basic valid email structure.
    Password must contain at least eight characters.

19. ERROR HANDLING
    Local validation errors are represented in the UI. No backend errors are
    fabricated because authentication infrastructure is not defined.

20. LOADING STATE
    Local simulated processing state demonstrates the intended UI behavior.

21. EMPTY STATE
    Empty form fields result in validation feedback.

22. OFFLINE BEHAVIOUR
    No connectivity is checked and no network request is attempted.

23. SECURITY CONSIDERATIONS
    Credentials are not persisted, transmitted, logged, or exposed outside
    the local form/controller.

24. PERFORMANCE OPTIMIZATIONS
    Local state is scoped to this page, widgets are split by responsibility,
    and no expensive rendering or external package is required.

25. WIDGET TREE OVERVIEW
    Scaffold
      → SafeArea
        → LayoutBuilder
          → Center
            → SingleChildScrollView
              → ConstrainedBox
                → Column
                  → Brand header
                  → Mode switcher
                  → Form
                  → State feedback

26. COMPLETE TESTING CHECKLIST
    Layout/overflow, keyboard, orientation, phone/tablet responsiveness,
    dark mode, large text, screen reader/accessibility, loading, empty,
    validation/error/success, navigation callback, state transitions,
    animation, performance, memory, and localization readiness.
*/

import 'package:flutter/material.dart';

import '../../data/data_sources/mock_authentication_data_source.dart';
import '../../domain/entities/authentication_feature_entity.dart';
import '../controllers/authentication_controller.dart';
import '../widgets/authentication_brand_header.dart';
import '../widgets/authentication_form.dart';
import '../widgets/authentication_mode_switcher.dart';
import '../widgets/authentication_states.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key, this.onAuthenticated});

  final VoidCallback? onAuthenticated;

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  late final AuthenticationFeatureEntity _entity;
  late final AuthenticationController _controller;

  @override
  void initState() {
    super.initState();

    const dataSource = MockAuthenticationDataSource();
    final model = dataSource.loadConfiguration();

    _entity = AuthenticationFeatureEntity.fromModel(model);
    _controller = AuthenticationController(initialMode: model.initialMode);

    _controller.addListener(_handleControllerChanged);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_handleControllerChanged)
      ..dispose();
    super.dispose();
  }

  void _handleControllerChanged() {
    if (!mounted) {
      return;
    }

    if (_controller.successMessage != null) {
      widget.onAuthenticated?.call();
    }

    setState(() {});
  }

  Future<void> _submit() async {
    await _controller.submit(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth >= 700 ? 40.0 : 20.0;
            final contentWidth = constraints.maxWidth >= 900 ? 560.0 : 520.0;

            return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 28,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: contentWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AuthenticationBrandHeader(entity: _entity),
                      const SizedBox(height: 28),
                      Card(
                        elevation: 0,
                        color: colorScheme.surfaceContainerLow,
                        clipBehavior: Clip.antiAlias,
                        child: Padding(
                          padding: const EdgeInsets.all(22),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              AuthenticationModeSwitcher(
                                mode: _controller.mode,
                                enabled: !_controller.isLoading,
                                onChanged: _controller.setMode,
                              ),
                              const SizedBox(height: 24),
                              AuthenticationForm(
                                mode: _controller.mode,
                                controller: _controller,
                                onSubmitted: _submit,
                              ),
                              AuthenticationStates(
                                isLoading: _controller.isLoading,
                                errorMessage: _controller.errorMessage,
                                successMessage: _controller.successMessage,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Built for conversations that cross languages, '
                        'contexts, and communities.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


// Important correction for the page file: the form currently owns its text controllers, so the page-level _emailController and _passwordController should not be present. Use this corrected _submit() implementation instead:

// Future<void> _submit() async {
//   // Future: pass validated form credentials to the authentication service here;
//   // this page currently demonstrates only the local authentication UI flow.
// }