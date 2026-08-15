import '../dummy/privacy_security_dummy_data.dart';
import '../models/privacy_security_model.dart';

class MockPrivacySecurityDataSource {
  const MockPrivacySecurityDataSource();

  List<PrivacySecurityModel> getAccountSecurity() {
    return List.unmodifiable(PrivacySecurityDummyData.accountSecurity);
  }

  List<PrivacySecurityModel> getConversationPrivacy() {
    return List.unmodifiable(PrivacySecurityDummyData.conversationPrivacy);
  }

  List<PrivacySecurityModel> getVoiceAndAi() {
    return List.unmodifiable(PrivacySecurityDummyData.voiceAndAi);
  }

  List<PrivacySecurityModel> getDataRetention() {
    return List.unmodifiable(PrivacySecurityDummyData.dataRetention);
  }

  List<PrivacySecurityModel> getPermissions() {
    return List.unmodifiable(PrivacySecurityDummyData.permissions);
  }

  List<PrivacySecurityModel> getBlockedContacts() {
    return List.unmodifiable(PrivacySecurityDummyData.blockedContacts);
  }

  List<PrivacySecurityModel> getDeleteAccount() {
    return List.unmodifiable(PrivacySecurityDummyData.deleteAccount);
  }
}