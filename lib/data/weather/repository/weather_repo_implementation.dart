import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/data/weather/models/forecast_weather.dart';
import 'package:weather_app/data/weather/models/current_weather.dart';
import 'package:weather_app/data/weather/services/api_services.dart';
import 'package:weather_app/domain/weather/repostory/weather_repo.dart';
import 'package:weather_app/service_locator.dart';

class WeatherRepoImplementation implements WeatherRepo{
  
  @override
  Future<Either<ForecastWeather,String>> getForecastByCity(String city)async {
      final response = await getIt<ApiServices>().getForecastByCity(city);
      
     return response.fold((data){
        return left(ForecastWeather.fromJson(data as Map<String,dynamic>));
      }, (error){
        return right(error);
      });
      
  }
  
  @override
  Future<Either<ForecastWeather,String>> getForecastByPosition(Position position)async {
      final response = await getIt<ApiServices>().getForecastByPosition(position);
      
     return response.fold((data){
        return left(ForecastWeather.fromJson(data as Map<String,dynamic>));
      }, (error){
        return right(error);
      });
      
  }

  @override
  Future<Either<CurrentWeather,String>> getCurrentWeatherByCity(String city) async{
    final result = await getIt<ApiServices>().getCurrentWeatherByCity(city);
    return result.fold(
      (data) {
        CurrentWeather currentWeather = CurrentWeather.fromJson(data as Map<String, dynamic>);
        return left(currentWeather);
      },
      (errorMessage) {
        log("Error from API service: $errorMessage");
        return right(errorMessage); 
      },
    );
  }

  @override
  Future<Either<CurrentWeather,String>> getCurrentWeatherByPosition(Position position) async{
    final result = await getIt<ApiServices>().getCurrentWeatherByPosition(position);
    return result.fold(
      (data) {
        CurrentWeather currentWeather = CurrentWeather.fromJson(data as Map<String, dynamic>);
        return left(currentWeather);
      },
      (errorMessage) {
        log("Error from API service: $errorMessage");
        return right(errorMessage); 
      },
    );
  }

  Future<Either<CurrentWeather,String>> getCurrentWeatherByPositionAndNotify(Position position) async{
    final result = await ApiServices(dio: Dio()).getCurrentWeatherByPosition(position);
    return result.fold(
      (data) {
        CurrentWeather currentWeather = CurrentWeather.fromJson(data as Map<String, dynamic>);
        return left(currentWeather);
      },
      (errorMessage) {
        log("Error from API service: $errorMessage");
        return right(errorMessage); 
      },
    );
  }


  Future<Either<CurrentWeather,String>> getCurrentByCityAndNotify(String city) async{
   final result = await ApiServices(dio: Dio()).getCurrentWeatherByCity(city);
    return result.fold(
      (data) {
        CurrentWeather currentWeather = CurrentWeather.fromJson(data as Map<String, dynamic>);
        return left(currentWeather);
      },
      (errorMessage) {
        log("Error from API service: $errorMessage");
        return right(errorMessage); 
      },
    );
  }

}