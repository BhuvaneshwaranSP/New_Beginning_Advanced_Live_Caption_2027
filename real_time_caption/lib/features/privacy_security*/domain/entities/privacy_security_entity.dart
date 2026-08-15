import 'package:flutter/material.dart';

class PrivacySecurityEntity {
  const PrivacySecurityEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    this.enabled,
    this.valueLabel,
    this.isDestructive = false,
  });

  final String id;
  final String title;
  final String description;
  final IconData icon;
  final bool? enabled;
  final String? valueLabel;
  final bool isDestructive;

  PrivacySecurityEntity copyWith({
    String? id,
    String? title,
    String? description,
    IconData? icon,
    bool? enabled,
    String? valueLabel,
    bool? isDestructive,
  }) {
    return PrivacySecurityEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      enabled: enabled ?? this.enabled,
      valueLabel: valueLabel ?? this.valueLabel,
      isDestructive: isDestructive ?? this.isDestructive,
    );
  }
}