import 'package:flutter/material.dart';

import '../../domain/entities/session_entity.dart';
import '../models/session_model.dart';

class SessionsDummyData {
  const SessionsDummyData._();

  static const List<SessionModel> sessions = <SessionModel>[
    SessionModel(
      id: 'session-001',
      title: 'Morning Team Meeting',
      type: SessionType.meeting,
      sourceLanguage: 'Tamil',
      targetLanguage: 'English',
      participants: <String>[
        'Arun',
        'Priya',
        'Michael',
        'Kavya',
      ],
      status: SessionStatus.live,
      timeLabel: 'Now',
      durationLabel: '24 min',
      icon: Icons.groups_rounded,
      description: 'Live multilingual meeting with translated captions.',
      seatLabel: '4 participants',
    ),
    SessionModel(
      id: 'session-002',
      title: 'Global Classroom',
      type: SessionType.classroom,
      sourceLanguage: 'Telugu',
      targetLanguage: 'English',
      participants: <String>[
        'Arun',
        'Dr. Meera',
        'Daniel',
        'Sanjay',
        'Anika',
      ],
      status: SessionStatus.scheduled,
      timeLabel: 'Today · 11:30 AM',
      durationLabel: '45 min',
      icon: Icons.school_rounded,
      description:
          'Multilingual learning session prepared for five participants.',
      seatLabel: '5 participants',
    ),
    SessionModel(
      id: 'session-003',
      title: 'Chennai Travel Help',
      type: SessionType.travel,
      sourceLanguage: 'English',
      targetLanguage: 'Tamil',
      participants: <String>[
        'Arun',
        'Rahul',
      ],
      status: SessionStatus.completed,
      timeLabel: 'Yesterday · 6:15 PM',
      durationLabel: '18 min',
      icon: Icons.flight_takeoff_rounded,
      description: 'Short multilingual travel communication session.',
      seatLabel: '2 participants',
    ),
    SessionModel(
      id: 'session-004',
      title: 'Customer Support Desk',
      type: SessionType.customerService,
      sourceLanguage: 'Hindi',
      targetLanguage: 'English',
      participants: <String>[
        'Arun',
        'Neha',
        'Support Team',
      ],
      status: SessionStatus.offline,
      timeLabel: 'Yesterday · 2:40 PM',
      durationLabel: '31 min',
      icon: Icons.support_agent_rounded,
      description:
          'Previous session available as an offline UI preview.',
      seatLabel: '3 participants',
    ),
    SessionModel(
      id: 'session-005',
      title: 'Family Conversation',
      type: SessionType.family,
      sourceLanguage: 'Malayalam',
      targetLanguage: 'Tamil',
      participants: <String>[
        'Arun',
        'Amma',
        'Anu',
      ],
      status: SessionStatus.completed,
      timeLabel: '12 Aug · 8:10 PM',
      durationLabel: '42 min',
      icon: Icons.favorite_rounded,
      description:
          'Family conversation across Malayalam and Tamil.',
      seatLabel: '3 participants',
    ),
  ];
}