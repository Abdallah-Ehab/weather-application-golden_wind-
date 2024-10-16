import 'package:geolocator/geolocator.dart';

abstract class LocationRepo {

Future<Position> getPosition();
Future<String> getCityName(Position position);
}