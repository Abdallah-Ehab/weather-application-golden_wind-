import 'package:dartz/dartz.dart';

abstract class SavedCitiesRepo {
  
  Future<Either> updateCity(String cityName);
}