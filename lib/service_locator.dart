import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_app/data/weather/repository/geolocator_repo_implementation.dart';
import 'package:weather_app/data/weather/repository/saved_cities_repo_implementation.dart';
import 'package:weather_app/data/weather/repository/suggested_cities_repo_implementation.dart';
import 'package:weather_app/data/weather/repository/weather_repo_implementation.dart';
import 'package:weather_app/data/weather/services/api_services.dart';
import 'package:weather_app/domain/weather/repostory/location_repo.dart';
import 'package:weather_app/domain/weather/repostory/saved_cities_repo.dart';
import 'package:weather_app/domain/weather/repostory/suggested_cities_repo.dart';
import 'package:weather_app/domain/weather/repostory/weather_repo.dart';

final getIt = GetIt.instance;

void initializeServiceLocator() {
  //dio
  getIt.registerSingleton<Dio>(Dio());
  //api services
  getIt.registerSingleton<ApiServices>(ApiServices(dio: getIt<Dio>()));
  //repositories
  getIt.registerSingleton<WeatherRepo>(WeatherRepoImplementation());
  getIt.registerSingleton<LocationRepo>(GeolocatorRepoImplementation());
  getIt.registerSingleton<SuggestedCitiesRepo>(SuggestedCitiesRepoImpl());
  getIt.registerSingleton<SavedCitiesRepo>(SavedCitiesRepoImplementation());
}