import '../../data/data_sources/mock_privacy_security_data_source.dart';
import '../../domain/entities/privacy_security_entity.dart';

class PrivacySecurityController {
  PrivacySecurityController({
    MockPrivacySecurityDataSource? dataSource,
  }) : _dataSource = dataSource ?? const MockPrivacySecurityDataSource();

  final MockPrivacySecurityDataSource _dataSource;

  late final List<PrivacySecurityEntity> accountSecurity =
      _dataSource.getAccountSecurity();

  late final List<PrivacySecurityEntity> conversationPrivacy =
      _dataSource.getConversationPrivacy();

  late final List<PrivacySecurityEntity> voiceAndAi =
      _dataSource.getVoiceAndAi();

  late final List<PrivacySecurityEntity> dataRetention =
      _dataSource.getDataRetention();

  late final List<PrivacySecurityEntity> permissions =
      _dataSource.getPermissions();

  late final List<PrivacySecurityEntity> blockedContacts =
      _dataSource.getBlockedContacts();

  late final List<PrivacySecurityEntity> deleteAccount =
      _dataSource.getDeleteAccount();

  bool isEnabled(String id) {
    final all = <PrivacySecurityEntity>[
      ...accountSecurity,
      ...conversationPrivacy,
      ...voiceAndAi,
      ...dataRetention,
      ...permissions,
      ...blockedContacts,
      ...deleteAccount,
    ];

    return all.firstWhere((item) => item.id == id).enabled ?? false;
  }
}