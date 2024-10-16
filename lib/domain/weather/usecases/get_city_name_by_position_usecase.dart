import 'package:dartz/dartz.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/data/weather/models/suggested_city.dart';
import 'package:weather_app/domain/weather/repostory/suggested_cities_repo.dart';
import 'package:weather_app/service_locator.dart';

class GetCityNameByPositionUsecase implements Usecase {
  @override
  Future<Either<List<SuggestedCity>, String>> call({dynamic params}) async {
    final response = await getIt<SuggestedCitiesRepo>().getCityNameByPosition();
    return response.fold((data){
      return left(data);
    }, (error) {
      return right(error);
    });
  }

}