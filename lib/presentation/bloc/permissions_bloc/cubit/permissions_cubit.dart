import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:geolocator_platform_interface/src/enums/location_service.dart' as geolocatorServiceStatus;
import 'package:weather_app/data/permissions/repository/permissions_repo_implementation.dart';

part 'permissions_state.dart';

class PermissionsCubit extends Cubit<PermissionsState> {
  final PermissionsRepoImplementation permissionsRepoImplementation;
  PermissionsCubit(this.permissionsRepoImplementation) : super(PermissionsInitial());

  StreamSubscription<geolocatorServiceStatus.ServiceStatus>? _serviceStatusStream;

  Future<void> checkPermissions() async {
    // bool locationWhenInUseStatus = await CheckLocationWheninuseUsecase().call();
    // bool locationAlwaysStatus = await CheckLocationAlwaysUseCase().call();
    // bool locationAndNotifcationsStatus = await CheckLocationAndNotificationsUsecase().call();
    bool locationWhenInUseStatus = await permissionsRepoImplementation.checkLocationWhenInuse();
    bool locationAlwaysStatus = await permissionsRepoImplementation.checkLocationAlways();
    bool locationAndNotifcationsStatus = await permissionsRepoImplementation.checkLocationAndNotifications();
    


    if(locationAndNotifcationsStatus){
      emit(LocationAndNotificationsGranted());
      return;
    }else if(locationAlwaysStatus){
      emit(LocationAlwaysGranted());
      return;
    }else if(locationWhenInUseStatus){
      emit(LocationWhenInUseGranted());
      return;
    }else{
      emit(PermissionsDenied());
    }
  }

  Future<void> requestLocationService()async{
    bool locationServiceStatus = await Geolocator.isLocationServiceEnabled();
    if(locationServiceStatus){
      emit(LocationServiceEnabled());
    }else{
      emit(LocationServiceDisabled());
    }

    _serviceStatusStream = Geolocator.getServiceStatusStream().listen((geolocatorServiceStatus.ServiceStatus status) {
      if (status == geolocatorServiceStatus.ServiceStatus.enabled) {
        emit(LocationServiceEnabled());
      } else {
        emit(LocationServiceDisabled());
      }
    });
    
  }
 
  Future<void> requestLocationPermission() async {
    await permissionsRepoImplementation.requestLocationPermission();
    await permissionsRepoImplementation.requestNotificationPermission();
    await checkPermissions();
  }

}
