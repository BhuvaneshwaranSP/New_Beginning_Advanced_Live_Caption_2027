import 'package:flutter/material.dart';

import '../../domain/entities/session_entity.dart';

class SessionModel {
  const SessionModel({
    required this.id,
    required this.title,
    required this.type,
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.participants,
    required this.status,
    required this.timeLabel,
    required this.durationLabel,
    required this.icon,
    required this.description,
    required this.seatLabel,
  });

  final String id;
  final String title;
  final SessionType type;
  final String sourceLanguage;
  final String targetLanguage;
  final List<String> participants;
  final SessionStatus status;
  final String timeLabel;
  final String durationLabel;
  final IconData icon;
  final String description;
  final String seatLabel;

  SessionEntity toEntity() {
    return SessionEntity(
      id: id,
      title: title,
      type: type,
      sourceLanguage: sourceLanguage,
      targetLanguage: targetLanguage,
      participants: List<String>.unmodifiable(participants),
      status: status,
      timeLabel: timeLabel,
      durationLabel: durationLabel,
      icon: icon,
      description: description,
      seatLabel: seatLabel,
    );
  }
}