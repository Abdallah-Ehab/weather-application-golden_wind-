import 'package:dartz/dartz.dart';
import 'package:weather_app/core/local%20storage/local_storage.dart';
import 'package:weather_app/data/weather/models/weather_data.dart';
import 'package:weather_app/domain/weather/repostory/saved_cities_repo.dart';
import 'package:weather_app/domain/weather/repostory/weather_repo.dart';
import 'package:weather_app/service_locator.dart';

class SavedCitiesRepoImplementation extends SavedCitiesRepo{

  @override
  Future<Either> updateCity(String cityName) async{
    WeatherData? weatherData = await LocalStorage.getSavedCityWeather(cityName);
    if(weatherData != null){
      DateTime savedTimeStamp = DateTime.fromMillisecondsSinceEpoch(weatherData.timeStamp);
      if(DateTime.now().difference(savedTimeStamp).inHours < 3 ){
        return left(WeatherData(cityName: cityName, temperature: weatherData.temperature, weatherCondition: weatherData.weatherCondition, timeStamp: weatherData.timeStamp, icon: weatherData.icon));
      }
    }

    final response = await getIt<WeatherRepo>().getCurrentWeatherByCity(cityName);

    return response.fold(
      (currentWeather) async{
        await LocalStorage.savecity(cityName, currentWeather.main!.temp, currentWeather.weather![0].main,currentWeather.weather![0].icon);
        return left(WeatherData(cityName: currentWeather.cityName!, temperature: currentWeather.main!.temp!.toDouble(), weatherCondition: currentWeather.weather![0].description!, timeStamp:DateTime.now().millisecondsSinceEpoch, icon: currentWeather.weather![0].icon!));
      },
      (error){
        return right(error);
      }
    );
    
  }
}