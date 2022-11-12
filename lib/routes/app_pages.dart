import 'package:get/get.dart';

import 'package:sunmi/binding/challenges_binding.dart';
import 'package:sunmi/binding/workout_binding.dart';
import 'package:sunmi/ui/screen/Setcount.dart';
import 'package:sunmi/ui/screen/challenge_list_page.dart';
import 'package:sunmi/ui/screen/workout_select_page.dart';
import '../data/model/workout.dart';
import 'package:sunmi/ui/screen/challenge_infomation.dart';
import 'homepage.dart';

part 'app_routes.dart';

class AppPages {
  static final pages =[
    GetPage(name: Routes.initial, page: ()=> HomePage()),
    GetPage(name: Routes.workoutSelect, page: ()=> WorkoutPage(), binding: WorkoutBinding()),
    GetPage(name: Routes.routineRegister, page: ()=>Setcount(Workout(workoutName: 'qwe',workoutTarget: 'qweqwe'), DateTime.now())),
    GetPage(name: Routes.challenges, page: ()=>ChallengeListPage(), binding: ChallengeBinding()),
    GetPage(name: Routes.challengeDetail, page: ()=> ChallengeCheck()),
    GetPage(name: Routes.registeredChallengeDetail, page: ()=> RegisteredChallengeDetailsPage())
  ];
}

