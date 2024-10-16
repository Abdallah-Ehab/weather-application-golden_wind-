
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/domain/weather/repostory/location_repo.dart';

class GeolocatorRepoImplementation implements LocationRepo {




// @override
// Future<bool> checkPermissions() async {
//   var status = await Permission.locationAlways.status;

//   if (status.isGranted) {
//     return true;
//   } else {
//     return false;
//   }
// }

  @override
  Future<Position> getPosition() async {
    if(await Geolocator.isLocationServiceEnabled()) {
      Position position = await Geolocator.getCurrentPosition();
      return position;
    } else {
      throw Exception('Permission was denied.');
    }
}
  
  @override
  Future<String> getCityName(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    String? city = placemarks[0].locality;
    return city ?? 'Unknown city';
  }
  
}
