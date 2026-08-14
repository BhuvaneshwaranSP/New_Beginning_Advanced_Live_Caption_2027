enum AppPermission { microphone, camera, notifications, storage }

class PermissionService {
  const PermissionService();
  Future<bool> isGranted(AppPermission permission) async => false;
  Future<bool> request(AppPermission permission) async => false;
}
