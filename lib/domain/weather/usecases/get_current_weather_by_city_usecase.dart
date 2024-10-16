import 'package:dartz/dartz.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/data/weather/models/current_weather.dart';
import 'package:weather_app/domain/weather/repostory/weather_repo.dart';
import 'package:weather_app/service_locator.dart';

class GetCurrentWeatherByCityUsecase implements Usecase<Either<CurrentWeather,String>, String> {
  @override
  Future<Either<CurrentWeather,String>> call({required String params}) async {
    final response = await getIt<WeatherRepo>().getCurrentWeatherByCity(params);
    return response.fold((currentWeather) {
      return left(currentWeather);
    }, (errorMessage) {
      return right(errorMessage);
    });
  }
}