// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/data/weather/models/suggested_city.dart';
import 'package:weather_app/data/weather/services/api_services.dart';
import 'package:weather_app/domain/weather/repostory/suggested_cities_repo.dart';
import 'package:weather_app/service_locator.dart';

class SuggestedCitiesRepoImpl extends SuggestedCitiesRepo {
  
  @override
  Future<Either<List<SuggestedCity>, String>> getSuggestedCities(String query) async {
     final response = await getIt<ApiServices>().getSuggestedCities(query);
      
     return response.fold((data){
        List<SuggestedCity> suggestedCities = (data as List<dynamic>).map((ele){
          return SuggestedCity.fromJson(ele);
        }).toList();
        return left(suggestedCities);
      }, (error){
        return right(error);
      });
  }

  @override
  Future<Either<List<SuggestedCity>, String>> getCityNameByPosition() async {
    Position position = await Geolocator.getCurrentPosition();
     final response = await getIt<ApiServices>().getCityNameByPosition(position);
      
     return response.fold((data){
        List<SuggestedCity> suggestedCities = (data as List<dynamic>).map((ele){
          return SuggestedCity.fromJson(ele);
        }).toList();
        return left(suggestedCities);
      }, (error){
        return right(error);
      });
  }

}
