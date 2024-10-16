

class WeatherData {
  double temperature;
  String weatherCondition;
  String cityName;
  int timeStamp;
  String icon;

  WeatherData({required this.cityName,required this.temperature,required this.weatherCondition,required this.timeStamp,required this.icon});

  factory WeatherData.fromjson(Map<String,dynamic> json){
    return WeatherData(
      cityName: json["cityName"],
      temperature: json["temperature"],
      weatherCondition: json["weatherCondition"],
      timeStamp: json["timeStamp"],
      icon: json["icon"]
    );
  }
}