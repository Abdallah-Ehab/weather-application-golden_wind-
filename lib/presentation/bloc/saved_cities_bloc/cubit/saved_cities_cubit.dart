
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/core/local%20storage/local_storage.dart';
import 'package:weather_app/data/weather/models/weather_data.dart';
import 'package:weather_app/domain/weather/repostory/saved_cities_repo.dart';
import 'package:weather_app/service_locator.dart';

part 'saved_cities_state.dart';

class SavedCitiesCubit extends Cubit<SavedCitiesState> {

  
  SavedCitiesCubit() : super(SavedCitiesInitial());

  // getSavedCities() async{
  //   List<String> cityNames = await LocalStorage.getSavedCitiesNames();

  //   for(var city in cityNames){
  //     final response = await getIt<SavedCitiesRepo>().updateCity(city);
  //     response.fold(
  //       (data){emit([...state, data]);},
  //       (error){log(error);}
  //     );
  //   }
  // }

  void getSavedCities() async{
    emit(SavedCitiesLoading());
    List<String> cityNames = await LocalStorage.getSavedCitiesNames();
    List<WeatherData> citiesWeather = [];
    for(var city in cityNames){
      final response = await getIt<SavedCitiesRepo>().updateCity(city);
      response.fold((data){
        citiesWeather.add(data);
      }, (error){
        emit(SavedCitiesFailed(error: error));
      });
    }
    emit(SavedCitiesSuccess(savedCities: citiesWeather));
  }

//   removeCity(String cityName) {
//   List<WeatherData> updatedList = List.from(state); 
//   updatedList.removeWhere((city) => city.cityName == cityName);
  
//   LocalStorage.deleteSavedCity(cityName); 
  
//   emit(updatedList);
// }

removeCity(String cityName){
  List<WeatherData> copiedList = [];
  if(state is SavedCitiesSuccess){
    List<WeatherData> copiedList = List.from((state as SavedCitiesSuccess).savedCities);
  }else{
    emit(SavedCitiesFailed(error: "error removing city"));
    return;
  }
  copiedList.removeWhere((city) => city.cityName == cityName);
  
  LocalStorage.deleteSavedCity(cityName); 
  
  emit(SavedCitiesSuccess(savedCities: copiedList));

  getSavedCities();
}


}
