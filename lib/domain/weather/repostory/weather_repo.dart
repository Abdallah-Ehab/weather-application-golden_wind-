import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/data/weather/models/forecast_weather.dart';
import 'package:weather_app/data/weather/models/current_weather.dart';

abstract class WeatherRepo {

  Future<Either<CurrentWeather,String>> getCurrentWeatherByCity(String city);
  Future<Either<CurrentWeather,String>> getCurrentWeatherByPosition(Position position);
  Future<Either<ForecastWeather,String>> getForecastByCity(String city);
  Future<Either<ForecastWeather,String>> getForecastByPosition(Position position);
}