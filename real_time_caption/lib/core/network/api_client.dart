/// UI-stage abstraction only. No networking is performed here.
abstract interface class ApiClient {
  Future<Object?> get(String path);
  Future<Object?> post(String path, {Object? body});
}

class DisabledApiClient implements ApiClient {
  const DisabledApiClient();
  @override
  Future<Object?> get(String path) async => null;
  @override
  Future<Object?> post(String path, {Object? body}) async => null;
}
