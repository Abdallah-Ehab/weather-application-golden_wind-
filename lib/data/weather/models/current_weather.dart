
import 'dart:developer';

import 'package:weather_app/data/weather/models/sys.dart';
import 'package:weather_app/data/weather/models/weather.dart';
import 'package:weather_app/data/weather/models/wind.dart';

class CurrentWeather {
  List<Weather>? weather;
  Main? main;
  int? visibility;
  Wind? wind;
  int? dt;
  Sys? sys;
  String? cityName;
  int? timezone;

  CurrentWeather(
      {
      this.weather,
      this.main,
      this.visibility,
      this.wind,
      this.dt,
      this.sys,
      this.cityName,
      this.timezone,
      });

  CurrentWeather.fromJson(Map<String, dynamic> json) {
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add( Weather.fromJson(v));
      });
    }
    main = json['main'] != null ?  Main.fromJson(json['main']) : null;
    visibility = json['visibility'];
    wind = json['wind'] != null ?  Wind.fromJson(json['wind']) : null;
    dt = json['dt'];
    sys = json['sys'] != null ?  Sys.fromJson(json['sys']) : null;
    cityName = json["name"];
    timezone = json["timezone"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }
    if (main != null) {
      data['main'] = main!.toJson();
    }
    data['visibility'] = visibility;
    if (wind != null) {
      data['wind'] = wind!.toJson();
    }
    data['dt'] = dt;
    if (sys != null) {
      data['sys'] = sys!.toJson();
    }
    return data;
  }
}




class Main {
  num? temp;
  num? feelsLike;
  num? tempMin;
  num? tempMax;
  int? pressure;
  int? humidity;
  int? seaLevel;
  int? grndLevel;
  

  Main(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.humidity,
      this.seaLevel,
      this.grndLevel});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    feelsLike = json['feels_like'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max'];
    pressure = json['pressure'];
    humidity = json['humidity'];
    seaLevel = json['sea_level'];
    grndLevel = json['grnd_level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['temp_min'] = tempMin;
    data['temp_max'] = tempMax;
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    data['sea_level'] = seaLevel;
    data['grnd_level'] = grndLevel;
    return data;
  }

}






