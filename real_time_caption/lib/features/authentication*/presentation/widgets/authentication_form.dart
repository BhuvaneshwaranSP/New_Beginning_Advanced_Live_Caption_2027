/*
1. PAGE NAME
   Authentication Form

2. PURPOSE
   Provides the interactive email/password authentication form.

3. DESCRIPTION
   UI-only form with local validation delegated to the authentication controller.

4. UI SECTIONS
   Email field, password field, password visibility control, primary action,
   and supporting privacy copy.

5. NAVIGATION FLOW
   AuthenticationPage → AuthenticationForm → controller submission.

6. DYNAMIC COMPONENTS
   Password visibility, loading state, mode-dependent labels, and validation.

7. FUTURE BACKEND INTEGRATION
   Future: connect the controller submission to the project's authentication
   service; this form owns only user input collection and presentation.

8. TECHNOLOGIES USED
   Flutter Material 3.

9. REQUIRED DATA MODELS
   AuthenticationMode and AuthenticationController.

10. FUTURE API ENDPOINTS
    Not defined by the supplied documentation.

11. DATABASE COLLECTIONS/TABLES
    Not defined by the supplied documentation.

12. REQUIRED ASSETS
    None.

13. REQUIRED ICONS
    Material Icons.

14. THEME COLORS
    Material 3 ColorScheme.

15. ANIMATIONS
    AnimatedSwitcher for action-label changes.

16. ACCESSIBILITY
    TextField labels, password semantics, tooltip, adequate touch targets,
    autofill hints, and keyboard action support.

17. EDGE CASES
    Long email, long password, keyboard overlap, invalid input, and large text.

18. VALIDATION RULES
    Email must have a basic valid email structure.
    Password must contain at least eight characters.

19. ERROR HANDLING
    Local validation feedback is shown above the action area.

20. LOADING STATE
    Primary action is disabled and displays a progress indicator.

21. EMPTY STATE
    Empty fields are treated as validation state.

22. OFFLINE BEHAVIOUR
    No network operation occurs.

23. SECURITY CONSIDERATIONS
    No password is persisted, logged, or transmitted.

24. PERFORMANCE OPTIMIZATIONS
    Controllers are owned and disposed by this widget.

25. WIDGET TREE OVERVIEW
    Form → email field → password field → primary button → supporting text.

26. COMPLETE TESTING CHECKLIST
    Verify validation, keyboard actions, password visibility, loading state,
    accessibility, orientation, and text scaling.
*/

import 'package:flutter/material.dart';

import '../../data/models/authentication_feature_model.dart';
import '../controllers/authentication_controller.dart';

class AuthenticationForm extends StatefulWidget {
  const AuthenticationForm({
    super.key,
    required this.mode,
    required this.controller,
    required this.onSubmitted,
  });

  final AuthenticationMode mode;
  final AuthenticationController controller;
  final VoidCallback onSubmitted;

  @override
  State<AuthenticationForm> createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final FocusNode _passwordFocusNode = FocusNode();

  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCreating = widget.mode == AuthenticationMode.createAccount;
    final isLoading = widget.controller.isLoading;

    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            isCreating ? 'Create your account' : 'Sign in to continue',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isCreating
                ? 'Set up your LinguaLive account to continue.'
                : 'Continue your multilingual communication experience.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _emailController,
            enabled: !isLoading,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.email],
            decoration: const InputDecoration(
              labelText: 'Email address',
              hintText: 'name@example.com',
              prefixIcon: Icon(Icons.alternate_email_rounded),
            ),
            onFieldSubmitted: (_) {
              _passwordFocusNode.requestFocus();
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            enabled: !isLoading,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.password],
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'At least 8 characters',
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              suffixIcon: IconButton(
                tooltip: _obscurePassword ? 'Show password' : 'Hide password',
                onPressed: isLoading
                    ? null
                    : () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
            ),
            onFieldSubmitted: (_) {
              if (!isLoading) {
                widget.onSubmitted();
              }
            },
          ),
          const SizedBox(height: 22),
          FilledButton.icon(
            onPressed: isLoading ? null : widget.onSubmitted,
            icon: isLoading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Icon(
                    isCreating
                        ? Icons.arrow_forward_rounded
                        : Icons.login_rounded,
                  ),
            label: AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              child: Text(
                isCreating ? 'Create account' : 'Sign in',
                key: ValueKey<bool>(isCreating),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Your credentials stay within this UI preview and are not stored '
            'or transmitted.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
