import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/data/weather/models/forecast_weather.dart';
import 'package:weather_app/domain/weather/repostory/weather_repo.dart';
import 'package:weather_app/service_locator.dart';

class GetForecastByPositionUsecase implements Usecase<Either<ForecastWeather,String>, Position> {
  @override
  Future<Either<ForecastWeather,String>> call({required Position params}) async {
    final response = await getIt<WeatherRepo>().getForecastByPosition(params);
    return response.fold((data) {
      return left(data);
    }, (errorMessage) {
      return right(errorMessage);
    });
  }
}