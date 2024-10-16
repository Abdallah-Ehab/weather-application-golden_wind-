import 'package:dartz/dartz.dart';
import 'package:weather_app/data/weather/models/suggested_city.dart';

abstract class SuggestedCitiesRepo {
  Future<Either<List<SuggestedCity>, String>> getSuggestedCities(String query);
  Future<Either<List<SuggestedCity>, String>> getCityNameByPosition();
}