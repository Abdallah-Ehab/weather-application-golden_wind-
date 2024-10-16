import 'dart:developer';

import 'package:weather_app/data/weather/models/city.dart';
import 'package:weather_app/data/weather/models/forecast_current_weather.dart';


class ForecastWeather {
  List<ForecastCurrentWeather>? forecastCurrentWeather;
  String? country;
  num? population;
  City? city;
  
  ForecastWeather({this.country,required this.forecastCurrentWeather,this.population,this.city});

  factory ForecastWeather.fromJson(Map<String,dynamic> json){
    log('list: ${json['list']}, country: ${json['country']}, ${json['city']}');
    return ForecastWeather(
      forecastCurrentWeather: json["list"] != null
        ? (json["list"] as List<dynamic>).map((element) {
            return ForecastCurrentWeather.fromJson(element);
          }).toList()
        : [],
      country: json["country"],
      population: json["population"],
      city: json["city"] != null ? City.fromjson(json["city"]) : null,

    );
  }
}