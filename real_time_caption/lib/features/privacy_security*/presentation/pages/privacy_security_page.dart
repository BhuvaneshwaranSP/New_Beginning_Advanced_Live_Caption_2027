/*
Page Name:
Privacy & Security Page

Purpose:
Give LinguaLive users a focused place to review and configure privacy and
security preferences.

Description:
A responsive Material 3 settings page based directly on the project's
Privacy & Security definition:
Account security, Conversation privacy, Voice data, AI data preferences,
Data retention, Permissions, Blocked contacts, and Delete account.

UI Sections:
- Header
- Protection status
- Account security
- Conversation privacy
- Voice & AI data
- Data retention
- Permissions
- Blocked contacts
- Delete account

Navigation Flow:
Profile/Settings -> Privacy & Security -> Back to previous screen.

Dynamic Components:
Local dummy privacy entities and local toggle state.

Future Backend Integration:
Real account security, privacy preferences, permission status, blocked contacts,
retention configuration, and account deletion are intentionally not implemented.

Technologies Used:
Flutter Material 3 and local StatefulWidget state.

Required Data Models:
PrivacySecurityEntity, PrivacySecurityModel.

Future API Endpoints:
Not specified by the supplied project documentation.

Database Collections/Tables:
Not specified by the supplied project documentation.

Required Assets:
None.

Required Icons:
Material security, privacy, microphone, notification, people, and deletion icons.

Theme Colors:
Uses the active Material 3 ColorScheme.

Animations:
Uses Material's built-in switch animation only.

Accessibility:
Semantic labels, readable hierarchy, touch-friendly controls, scalable text,
and color-independent meaning.

Edge Cases:
Long multilingual labels, large text, small displays, tablet widths,
landscape mode, destructive confirmation, and local toggle changes.

Validation Rules:
No server-side or account validation is performed.

Error Handling:
Local retry representation is supplied for future data-source integration.

Loading State:
Local loading representation is supplied for future data loading.

Empty State:
Local empty representation is supplied for future data-driven settings.

Offline Behaviour:
The screen remains available because this UI uses only local dummy data.

Security Considerations:
No actual security operation is performed. Dummy values must not be treated
as real account or privacy state.

Performance Optimizations:
Const widgets, simple lists, local state, and no external state-management
package.

Widget Tree Overview:
Scaffold
 └── SafeArea
     └── LayoutBuilder
         └── CustomScrollView
             ├── PrivacySecurityHeader
             ├── ProtectionStatus
             ├── PrivacySecuritySection
             └── DeleteAccountSection

Complete Testing Checklist:
Layout, overflow, keyboard behavior, orientation, responsive phone/tablet
layouts, dark mode, large text, screen readers, touch targets, local loading/
empty/error representations, long data, destructive confirmation, navigation,
state transitions, performance, and localization readiness.
*/

import 'package:flutter/material.dart';

import '../../domain/entities/privacy_security_entity.dart';
import '../controllers/privacy_security_controller.dart';
import '../widgets/privacy_security_header.dart';
import '../widgets/privacy_security_section.dart';

class PrivacySecurityPage extends StatefulWidget {
  const PrivacySecurityPage({
    super.key,
    this.onBack,
  });

  final VoidCallback? onBack;

  @override
  State<PrivacySecurityPage> createState() => _PrivacySecurityPageState();
}

class _PrivacySecurityPageState extends State<PrivacySecurityPage> {
  final PrivacySecurityController _controller = PrivacySecurityController();

  late final Map<String, bool> _toggleValues = {
    for (final item in [
      ..._controller.accountSecurity,
      ..._controller.conversationPrivacy,
    ])
      if (item.enabled != null) item.id: item.enabled!,
  };

  void _handleItemPressed(PrivacySecurityEntity item) {
    if (item.id == 'delete_account') {
      _showDeleteAccountDialog();
      return;
    }

    // Future: connect the appropriate privacy/security preference service here;
    // this callback is the user interaction boundary for non-toggle settings.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.title} is ready for configuration.'),
      ),
    );
  }

  void _handleToggle(PrivacySecurityEntity item, bool value) {
    setState(() {
      _toggleValues[item.id] = value;
    });

    // Future: persist the selected privacy preference through the intended
    // account/privacy service; local state is used here only for UI preview.
  }

  Future<void> _showDeleteAccountDialog() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: Icon(
            Icons.delete_outline,
            color: Theme.of(dialogContext).colorScheme.error,
          ),
          title: const Text('Delete account?'),
          content: const Text(
            'This is a preview of the account-deletion confirmation. '
            'No account will be deleted in this UI-only implementation.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Continue'),
            ),
          ],
        );
      },
    );

    if (!mounted || confirmed != true) {
      return;
    }

    // Future: invoke the documented account-deletion workflow here after
    // authentication, confirmation, and server-side deletion are available.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Account deletion is not active in this UI preview.'),
      ),
    );
  }

  Widget _buildProtectionStatus(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      color: colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              child: const Icon(Icons.shield_outlined),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your privacy matters',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colorScheme.onPrimaryContainer,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Review how conversations, voice data, and permissions are handled.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onPrimaryContainer,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<PrivacySecurityEntity> items,
  }) {
    return PrivacySecuritySection(
      title: title,
      items: items,
      onItemPressed: _handleItemPressed,
      onToggle: _handleToggle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding = constraints.maxWidth >= 700 ? 32.0 : 16.0;
            final contentWidth =
                constraints.maxWidth >= 900 ? 820.0 : double.infinity;

            return CustomScrollView(
              keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: contentWidth),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          8,
                          horizontalPadding,
                          32,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            PrivacySecurityHeader(
                              onBack: widget.onBack ??
                                  () {
                                    if (Navigator.of(context).canPop()) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                            ),
                            _buildProtectionStatus(context),
                            _buildSection(
                              title: 'Account security',
                              items: _controller.accountSecurity
                                  .map(
                                    (item) => item.copyWith(
                                      enabled: _toggleValues[item.id],
                                    ),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(height: 18),
                            _buildSection(
                              title: 'Conversation privacy',
                              items: _controller.conversationPrivacy
                                  .map(
                                    (item) => item.copyWith(
                                      enabled: _toggleValues[item.id],
                                    ),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(height: 18),
                            _buildSection(
                              title: 'Voice & AI data',
                              items: _controller.voiceAndAi,
                            ),
                            const SizedBox(height: 18),
                            _buildSection(
                              title: 'Data retention',
                              items: _controller.dataRetention,
                            ),
                            const SizedBox(height: 18),
                            _buildSection(
                              title: 'Permissions',
                              items: _controller.permissions,
                            ),
                            const SizedBox(height: 18),
                            _buildSection(
                              title: 'Blocked contacts',
                              items: _controller.blockedContacts,
                            ),
                            const SizedBox(height: 18),
                            _buildSection(
                              title: 'Account',
                              items: _controller.deleteAccount,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}