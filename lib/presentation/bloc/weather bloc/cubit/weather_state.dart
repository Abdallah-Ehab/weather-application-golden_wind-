part of 'weather_cubit.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState{}


final class WeatherSuccess extends WeatherState{
  final CurrentWeather currentWeather;
  WeatherSuccess({required this.currentWeather});
}

final class WeatherFailed extends WeatherState{
  final String error;
  WeatherFailed({required this.error});
}



