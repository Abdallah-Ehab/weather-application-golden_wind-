part of 'get_city_name_cubit.dart';

@immutable
sealed class GetCityNameState {}

final class GetCityNameInitial extends GetCityNameState {}

final class GetCityNameLoading extends GetCityNameState {}

final class GetCityNameSuccess extends GetCityNameState {
  final List<SuggestedCity> suggestedCities;

  GetCityNameSuccess({required this.suggestedCities});
}

final class GetCityNameFailed extends GetCityNameState {
  final String errorMessage;

  GetCityNameFailed({required this.errorMessage});
}