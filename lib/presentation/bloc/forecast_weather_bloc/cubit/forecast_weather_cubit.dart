import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/data/weather/models/forecast_weather.dart';
import 'package:weather_app/domain/weather/repostory/location_repo.dart';
import 'package:weather_app/domain/weather/repostory/weather_repo.dart';
import 'package:weather_app/service_locator.dart';

part 'forecast_weather_state.dart';

class ForecastWeatherCubit extends Cubit<ForecastWeatherState> {
  ForecastWeatherCubit() : super(ForecastWeatherInitial());
  Future<void> _fetchWeather<T>(
    Future<Either<T, String>> Function() weatherFunction, {
    required Function(T) onSuccess,
    required Function(String) onError,
  }) async {
    emit(ForecastWeatherLoading());
    try {
      final weatherResponse = await weatherFunction();
      weatherResponse.fold(
        (data) => onSuccess(data),
        (error) => onError(error),
      );
    } catch (e) {
      emit(ForecastWeatherFailed(error: 'Unexpected error: $e'));
    }
  }

  void getForecastWeatherByCity(String city) {
    _fetchWeather(
      () => getIt<WeatherRepo>().getForecastByCity(city),
      onSuccess: (data) => emit(ForecastWeatherSuccess(forecastWeather: data)),
      onError: (error) => emit(ForecastWeatherFailed(error: error)),
    );
  }
void getForecastWeatherByPosition() async {
    try {
      final locationResponse = await getIt<LocationRepo>().getPosition();
      _fetchWeather(
        () => getIt<WeatherRepo>().getForecastByPosition(locationResponse),
        onSuccess: (data) => emit(ForecastWeatherSuccess(forecastWeather: data)),
        onError: (error) => emit(ForecastWeatherFailed(error: error)),
      );
    } catch (e) {
      emit(ForecastWeatherFailed(error: 'Failed to get location: $e'));
    }
  }
}
