import '../../domain/entities/session_entity.dart';
import '../dummy/sessions_dummy_data.dart';

class MockSessionsDataSource {
  const MockSessionsDataSource();

  List<SessionEntity> loadSessions() {
    return SessionsDummyData.sessions
        .map((SessionModel) => SessionModel.toEntity())
        .toList(growable: false);
  }
}