import 'package:sunmi/controller/workout_controller.dart';
import 'package:sunmi/data/provider/workout_provider.dart';
import 'package:sunmi/data/repository/workout_repository.dart';

import 'package:get/get.dart';

class WorkoutBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<WorkoutController>(() {
      return WorkoutController(
          workoutRepository: WorkoutRepository(
              workoutProvider: WorkoutProvider()
          )
      );
    });
  }
}