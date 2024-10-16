import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/domain/permissions/repository/permission_repo.dart';

class PermissionsRepoImplementation extends PermissionRepo {
  @override
  Future<bool> checkLocationWhenInuse() async {
    PermissionStatus locationWhenInUse = await Permission.locationWhenInUse.status;
    if(locationWhenInUse.isGranted){
      return true;
    }else{

    return false;
    }
  }

  @override
  Future<bool> checkLocationAlways() async{
    PermissionStatus locationAlways =await Permission.locationAlways.status;
    if(locationAlways.isGranted){
      return true;
    }
    return false;
  }

  @override
  Future<void> requestLocationPermission() async{
      await Permission.locationWhenInUse.request();
      await Permission.locationAlways.request();
  }

  @override
  Future<void> requestNotificationPermission() async {
    await Permission.notification.request();
  }
  
  @override
  Future<bool> checkLocationAndNotifications() async{
    PermissionStatus locationAlwaysStatus = await Permission.locationAlways.status;
    PermissionStatus notificationsStatus = await Permission.notification.status;

    return locationAlwaysStatus.isGranted && notificationsStatus.isGranted;
  }
  @override
  Future<bool> checkLocationService() async{
   return await Geolocator.isLocationServiceEnabled();
  }
}
