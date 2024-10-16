import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/data/weather/models/suggested_city.dart';
import 'package:weather_app/domain/weather/usecases/get_city_name_by_position_usecase.dart';

part 'get_city_name_state.dart';

class GetCityNameCubit extends Cubit<GetCityNameState> {
  GetCityNameCubit() : super(GetCityNameInitial());
  Future<void> getCityNameByPosition() async {
    emit(GetCityNameLoading());
    final response = await GetCityNameByPositionUsecase().call();
    response.fold((data) {
      emit(GetCityNameSuccess(suggestedCities: data));
    }, (error) {
      emit(GetCityNameFailed(errorMessage: error));
    });
  }
}
