part of 'permissions_cubit.dart';

@immutable
sealed class PermissionsState {}

final class PermissionsInitial extends PermissionsState {}

final class LocationWhenInUseGranted extends PermissionsState{}


final class LocationAlwaysGranted extends PermissionsState{}

final class LocationAndNotificationsGranted extends PermissionsState{}

final class PermissionsDenied extends PermissionsState{}

final class LocationServiceEnabled extends PermissionsState{}

final class LocationServiceDisabled extends PermissionsState{}