import 'package:workmanager/workmanager.dart';

class WorkManagerRepoImplementation {
  void scheduleTask() {
    Workmanager().registerPeriodicTask(
      "Notification",
      "notification",
      frequency: const Duration(hours: 3),
    );
  }
}
