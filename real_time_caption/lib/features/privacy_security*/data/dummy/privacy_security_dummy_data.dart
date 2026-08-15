import 'package:flutter/material.dart';

import '../models/privacy_security_model.dart';

abstract final class PrivacySecurityDummyData {
  static const accountSecurity = <PrivacySecurityModel>[
    PrivacySecurityModel(
      id: 'screen_lock',
      title: 'App screen lock',
      description: 'Require protection when LinguaLive is reopened.',
      icon: Icons.lock_outline,
      enabled: true,
    ),
    PrivacySecurityModel(
      id: 'security_alerts',
      title: 'Security alerts',
      description: 'Show important account-security notifications.',
      icon: Icons.shield_outlined,
      enabled: true,
    ),
  ];

  static const conversationPrivacy = <PrivacySecurityModel>[
    PrivacySecurityModel(
      id: 'private_conversations',
      title: 'Private conversations',
      description: 'Keep conversation content visible only to participants.',
      icon: Icons.forum_outlined,
      enabled: true,
    ),
    PrivacySecurityModel(
      id: 'preview_notifications',
      title: 'Message previews',
      description: 'Show conversation content in notifications.',
      icon: Icons.notifications_none,
      enabled: false,
    ),
  ];

  static const voiceAndAi = <PrivacySecurityModel>[
    PrivacySecurityModel(
      id: 'voice_data',
      title: 'Voice data',
      description: 'Control how voice-related data is handled.',
      icon: Icons.mic_none,
      valueLabel: 'Ask every time',
    ),
    PrivacySecurityModel(
      id: 'ai_data',
      title: 'AI data preferences',
      description: 'Choose whether conversation data may support AI features.',
      icon: Icons.auto_awesome_outlined,
      valueLabel: 'Not shared',
    ),
  ];

  static const dataRetention = <PrivacySecurityModel>[
    PrivacySecurityModel(
      id: 'retention',
      title: 'Data retention',
      description: 'Choose how long supported conversation data is retained.',
      icon: Icons.schedule_outlined,
      valueLabel: '30 days',
    ),
  ];

  static const permissions = <PrivacySecurityModel>[
    PrivacySecurityModel(
      id: 'microphone',
      title: 'Microphone',
      description: 'Used for live speech and voice communication.',
      icon: Icons.mic_none,
      valueLabel: 'Allowed',
    ),
    PrivacySecurityModel(
      id: 'notifications',
      title: 'Notifications',
      description: 'Used for relevant communication notifications.',
      icon: Icons.notifications_none,
      valueLabel: 'Allowed',
    ),
  ];

  static const blockedContacts = <PrivacySecurityModel>[
    PrivacySecurityModel(
      id: 'blocked_contacts',
      title: 'Blocked contacts',
      description: 'Manage people you have blocked from communication.',
      icon: Icons.person_off_outlined,
      valueLabel: '2 contacts',
    ),
  ];

  static const deleteAccount = <PrivacySecurityModel>[
    PrivacySecurityModel(
      id: 'delete_account',
      title: 'Delete account',
      description: 'Permanently remove your LinguaLive account.',
      icon: Icons.delete_outline,
      isDestructive: true,
    ),
  ];
}