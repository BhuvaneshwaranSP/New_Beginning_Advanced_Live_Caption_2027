import '../../domain/entities/privacy_security_entity.dart';

class PrivacySecurityModel extends PrivacySecurityEntity {
  const PrivacySecurityModel({
    required super.id,
    required super.title,
    required super.description,
    required super.icon,
    super.enabled,
    super.valueLabel,
    super.isDestructive,
  });
}
