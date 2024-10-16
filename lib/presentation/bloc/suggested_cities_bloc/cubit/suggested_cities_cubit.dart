// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:weather_app/data/weather/models/suggested_city.dart';
import 'package:weather_app/domain/weather/repostory/suggested_cities_repo.dart';
import 'package:weather_app/service_locator.dart';

part 'suggested_cities_state.dart';

class SuggestedCitiesCubit extends Cubit<SuggestedCitiesState> {
  SuggestedCitiesCubit() : super(SuggestedCitiesInitial());

  Future<void> getSuggestedCities(String query) async {
    if (query.isEmpty) {
      emit(SuggestedCitiesSuccess(const []));
      return;
    }
    emit(SuggestedCitiesLoading());
    final suggestedCitiesResponse =
        await getIt<SuggestedCitiesRepo>().getSuggestedCities(query);
    suggestedCitiesResponse.fold((data) {
      emit(SuggestedCitiesSuccess(data));
    }, (error) {
      emit(SuggestedCitiesFailure(error));
    });
  }
}
