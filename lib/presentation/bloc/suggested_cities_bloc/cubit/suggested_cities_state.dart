part of 'suggested_cities_cubit.dart';

@immutable
sealed class SuggestedCitiesState {}

final class SuggestedCitiesInitial extends SuggestedCitiesState {}

final class SuggestedCitiesLoading extends SuggestedCitiesState {}

final class SuggestedCitiesSuccess extends SuggestedCitiesState {
  final List<SuggestedCity>? suggestedCities;
  SuggestedCitiesSuccess(this.suggestedCities);
}

final class SuggestedCitiesFailure extends SuggestedCitiesState {
  final String? message;

  SuggestedCitiesFailure(this.message);

}