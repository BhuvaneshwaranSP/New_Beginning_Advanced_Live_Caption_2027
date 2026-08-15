import 'package:flutter/material.dart';

enum SessionStatus {
  live,
  scheduled,
  completed,
  offline,
}

enum SessionType {
  meeting,
  classroom,
  travel,
  customerService,
  family,
  event,
}

@immutable
class SessionEntity {
  const SessionEntity({
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

  String get languagePair => '$sourceLanguage ↔ $targetLanguage';

  String get statusLabel {
    switch (status) {
      case SessionStatus.live:
        return 'Live now';
      case SessionStatus.scheduled:
        return 'Scheduled';
      case SessionStatus.completed:
        return 'Completed';
      case SessionStatus.offline:
        return 'Offline';
    }
  }

  String get typeLabel {
    switch (type) {
      case SessionType.meeting:
        return 'Meeting';
      case SessionType.classroom:
        return 'Classroom';
      case SessionType.travel:
        return 'Travel';
      case SessionType.customerService:
        return 'Customer service';
      case SessionType.family:
        return 'Family';
      case SessionType.event:
        return 'Event';
    }
  }
}