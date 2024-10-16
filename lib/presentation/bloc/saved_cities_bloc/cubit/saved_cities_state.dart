part of 'saved_cities_cubit.dart';

@immutable
sealed class SavedCitiesState {}

final class SavedCitiesInitial extends SavedCitiesState {}


final class SavedCitiesSuccess extends SavedCitiesState{
  final List<WeatherData> savedCities;

  SavedCitiesSuccess({required this.savedCities});
}

final class SavedCitiesFailed extends SavedCitiesState{
  final String error;
  SavedCitiesFailed({required this.error});
}

final class SavedCitiesLoading extends SavedCitiesState{}