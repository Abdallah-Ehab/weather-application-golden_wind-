abstract class PermissionRepo {

  Future<bool> checkLocationWhenInuse();
  Future<bool> checkLocationAlways();
  Future<void> requestLocationPermission();
  Future<void> requestNotificationPermission();
  Future<bool> checkLocationAndNotifications();
  Future<bool> checkLocationService();
}