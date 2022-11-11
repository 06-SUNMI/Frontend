import 'package:get/get.dart';

import 'package:sunmi/data/model/workout.dart';
import 'package:sunmi/data/repository/workout_repository.dart';
import 'package:sunmi/routes/app_pages.dart';

class WorkoutController extends GetxController{

  final WorkoutRepository workoutRepository;
  WorkoutController({required this.workoutRepository});

  final RxList<Workout> _workouts = RxList.empty(growable: true);
  get workouts => this._workouts.value;
  set workouts(value) => this._workouts.value = value;

  final RxList<String> _workoutTargets = RxList.empty(growable: true);
  get workoutTargets => this._workoutTargets.value;
  set workoutTargets(value) => this._workoutTargets.value = value;

  @override
  void onInit() {
    super.onInit();
    getAll();
    print('loaded workout lists');

  }

  getAll(){
    workoutRepository.getAll().then(
            (data){
              this.workouts = data;
            });
    workoutRepository.getTargets().then(
        (data){
          this.workoutTargets = data;
        }
    );
  }

  gotoRoutineRegister(Workout workout){
    Get.toNamed(Routes.routineRegister, arguments: {'workout': workout, 'date': Get.arguments['date']});
  }
}