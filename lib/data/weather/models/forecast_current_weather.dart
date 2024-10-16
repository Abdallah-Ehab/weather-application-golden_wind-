import 'package:weather_app/data/weather/models/current_weather.dart';
import 'package:weather_app/data/weather/models/weather.dart';
import 'package:weather_app/data/weather/models/wind.dart';

class ForecastCurrentWeather {
  Main? main;
  List<Weather>? weather;
  Wind? wind;
  int dt;

  ForecastCurrentWeather({required this.main,required this.weather,required this.wind,required this.dt});

  factory ForecastCurrentWeather.fromJson(Map<String,dynamic> json){
    return ForecastCurrentWeather(
      main: Main.fromJson(json["main"]),
      weather: (json["weather"] as List<dynamic>).map((element){
        return Weather.fromJson(element);
      }).toList(),
      wind: Wind.fromJson(json["wind"]),
      dt:json["dt"]
    );
  }
}

