import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/data/workmanager/repository/work_manager_repo_implementation.dart';

class WorkManagerUsecase extends Usecase<void,dynamic>{
  @override
  Future call({dynamic params}) async {
    WorkManagerRepoImplementation().scheduleTask();
  }
}