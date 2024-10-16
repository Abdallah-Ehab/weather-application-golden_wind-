import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/data/permissions/repository/permissions_repo_implementation.dart';

class CheckLocationWheninuseUsecase extends Usecase{
  @override
  Future call({dynamic params}) async{
    await PermissionsRepoImplementation().checkLocationWhenInuse();
  }
}