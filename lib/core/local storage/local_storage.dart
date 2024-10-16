import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/weather/models/weather_data.dart';

class LocalStorage {
  static const String cityPrefix = "_";
  
  static Future<void> savecity(
      String? cityName, num? temperature, String? weatherCondition,String? icon) async {
    final prefs = await SharedPreferences.getInstance();
    String value =
        "$cityName,$temperature,$weatherCondition,${DateTime.now().millisecondsSinceEpoch},${icon??''}";
    await prefs.setString("$cityPrefix$cityName", value);
  }

  static Future<WeatherData?> getSavedCityWeather(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    String? cityData = prefs.getString("$cityPrefix$cityName");
    if(cityData != null){
      List<String> params = cityData.split(",");
      return 
        WeatherData(cityName: params[0], temperature: double.parse(params[1]), weatherCondition: params[2], timeStamp: int.parse(params[3]),icon: params[4]);
  
    }else{
      return null;
    }
    
  }

  static Future<List<String>> getSavedCitiesNames() async{
    final prefs = await SharedPreferences.getInstance();
     List<String> savedCities = prefs.getKeys()
        .where((key) => key.startsWith(cityPrefix))
        .map((key) => key.replaceFirst(cityPrefix, ""))
        .toList();
      return savedCities;
}
  static void deleteSavedCity(String cityName)async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$cityPrefix$cityName');
  }
  static void clearSavedCities()async{
    final prefs = await SharedPreferences.getInstance();
    List<String> savedCities = prefs.getKeys().where((ele)=>ele.startsWith(cityPrefix)).toList();
    for(var city in savedCities){
      await prefs.remove(city);
    }
  }
}