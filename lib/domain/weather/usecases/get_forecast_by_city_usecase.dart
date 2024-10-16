import 'package:dartz/dartz.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/data/weather/models/forecast_weather.dart';
import 'package:weather_app/domain/weather/repostory/weather_repo.dart';
import 'package:weather_app/service_locator.dart';

class GetForecastByCityUsecase implements Usecase<Either<ForecastWeather,String>, String> {
  @override
  Future<Either<ForecastWeather,String>> call({required String params}) async {
    final response = await getIt<WeatherRepo>().getForecastByCity(params);
    return response.fold((data) {
      return left(data);
    }, (errorMessage) {
      return right(errorMessage);
    });
  }
}