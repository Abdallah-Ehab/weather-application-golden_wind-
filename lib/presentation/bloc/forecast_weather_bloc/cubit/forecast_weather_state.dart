part of 'forecast_weather_cubit.dart';

@immutable
sealed class ForecastWeatherState {}

final class ForecastWeatherInitial extends ForecastWeatherState {}

final class ForecastWeatherLoading extends ForecastWeatherState {}

final class ForecastWeatherSuccess extends ForecastWeatherState {
  final ForecastWeather forecastWeather;
  ForecastWeatherSuccess({required this.forecastWeather});
}

final class ForecastWeatherFailed extends ForecastWeatherState {
  final String error;

  ForecastWeatherFailed({required this.error});
}