/*
Page Name:
Privacy & Security

Purpose:
Provide a clear user-facing area for privacy and security preferences.

Description:
The Privacy & Security feature presents account security, conversation privacy,
voice-data preferences, AI-data preferences, data retention, permissions,
blocked contacts, and account deletion as defined by the LinguaLive project
documentation.

UI Sections:
1. Privacy & Security header
2. Security status card
3. Account security
4. Conversation privacy
5. Voice & AI data
6. Data retention
7. Permissions
8. Blocked contacts
9. Delete account

Navigation Flow:
Profile/Settings -> Privacy & Security.
The page remains a configuration surface and does not implement actual
security operations.

Dynamic Components:
Local privacy/security entities, switches, status labels, and confirmation UI.

Future Backend Integration:
Future account, privacy, permission, retention, blocked-contact, and account
deletion services will be connected at the callbacks marked in the UI.

Technologies Used:
Flutter Material 3 and Dart only.

Required Data Models:
PrivacySecurityEntity and PrivacySecurityModel.

Future API Endpoints:
Not defined by the supplied project documentation; therefore no endpoint is
invented in this UI implementation.

Database Collections/Tables:
Not defined by the supplied project documentation; therefore none are assumed.

Required Assets:
None.

Required Icons:
Material security/privacy icons.

Theme Colors:
Material 3 ColorScheme with semantic error styling for destructive actions.

Animations:
Lightweight AnimatedContainer transitions for local selection states.

Accessibility:
Semantic labels, sufficient touch targets, readable hierarchy, and support
for large text and screen readers.

Edge Cases:
Long translated labels, disabled settings, destructive-action confirmation,
small screens, landscape layouts, and large accessibility text.

Validation Rules:
No real account or security data is validated in the UI-only implementation.

Error Handling:
Local error representation is available through the page state widget.
No real service errors are generated.

Loading State:
A local loading representation is provided for future integration readiness.

Empty State:
A reusable empty state is available for future data-driven sections.

Offline Behaviour:
The UI remains locally usable; no network operation is attempted.

Security Considerations:
The current implementation contains only dummy data and does not claim to
perform actual security, encryption, authentication, deletion, or permission
operations.

Performance Optimizations:
Const widgets where possible, small local models, and lightweight builders.

Widget Tree Overview:
Scaffold
 └── SafeArea
     └── CustomScrollView
         ├── Header
         ├── Security status
         ├── Section cards
         └── Destructive account action

Complete Testing Checklist:
See the screen-specific checklist supplied before this file set.
*/

export 'data/models/privacy_security_model.dart';
export 'data/data_sources/mock_privacy_security_data_source.dart';
export 'domain/entities/privacy_security_entity.dart';
export 'presentation/controllers/privacy_security_controller.dart';
export 'presentation/pages/privacy_security_page.dart';
