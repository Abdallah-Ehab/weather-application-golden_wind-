import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/data/weather/models/current_weather.dart';
import 'package:weather_app/domain/weather/repostory/location_repo.dart';
import 'package:weather_app/domain/weather/repostory/weather_repo.dart';
import 'package:weather_app/service_locator.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());


  // Helper function to handle repetitive code (dry)
  Future<void> _fetchWeather<T>(
    Future<Either<T, String>> Function() weatherFunction, {
    required Function(T) onSuccess,
    required Function(String) onError,
  }) async {
    emit(WeatherLoading());
    try {
      final weatherResponse = await weatherFunction();
      weatherResponse.fold(
        (data) => onSuccess(data),
        (error) => onError(error),
      );
    } catch (e) {
      emit(WeatherFailed(error: 'Unexpected error: $e'));
    }
  }

  void getCurrentWeatherByCity(String city) {
    _fetchWeather(
      () => getIt<WeatherRepo>().getCurrentWeatherByCity(city),
      onSuccess: (data) => emit(WeatherSuccess(currentWeather: data)),
      onError: (error) => emit(WeatherFailed(error: error)),
    );
  }

  

  void getCurrentWeatherByPosition() async {
    try {
      final locationResponse = await getIt<LocationRepo>().getPosition();
      _fetchWeather(
        () => getIt<WeatherRepo>().getCurrentWeatherByPosition(locationResponse),
        onSuccess: (data) => emit(WeatherSuccess(currentWeather: data)),
        onError: (error) => emit(WeatherFailed(error: error)),
      );
    } catch (e) {
      emit(WeatherFailed(error: 'Failed to get location: $e'));
    }
  }

  
}