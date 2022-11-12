import 'package:get/get.dart';

import 'package:sunmi/binding/workout_binding.dart';
import 'package:sunmi/ui/screen/challenge/challenge_auth_page.dart';
import 'package:sunmi/ui/screen/challenge/challenge_auth_photo_info_page.dart';
import 'package:sunmi/ui/screen/challenge/challenge_auth_photos_page.dart';
import 'package:sunmi/ui/screen/challenge/registered_challenge_info_page.dart';
import 'package:sunmi/ui/screen/routine/Setcount.dart';
import 'package:sunmi/ui/screen/routine/workout_select_page.dart';
import 'package:sunmi/binding/home_binding.dart';
import '../data/model/workout.dart';
import 'package:sunmi/ui/screen/challenge/challenge_infomation.dart';
import 'package:sunmi/binding/registered_challenge_binding.dart';
import 'homepage.dart';

part 'app_routes.dart';

class AppPages {
  static final pages =[
    GetPage(name: Routes.initial, page: ()=> HomePage(), binding: HomeBinding()),
    GetPage(name: Routes.workoutSelect, page: ()=> WorkoutPage(), binding: WorkoutBinding()),
    GetPage(name: Routes.routineRegister, page: ()=>Setcount(Workout(workoutName: 'qwe',workoutTarget: 'qweqwe'), DateTime.now())),
    GetPage(name: Routes.challengeInfo, page: ()=> Challendge_check()),
    GetPage(name: Routes.registeredChallengeInfo, page: ()=> RegisteredChallengeInfoPage(),binding: RegisteredChallengeBinding()),
    GetPage(name: Routes.challengeAuth, page: ()=>ChallengeAuthPage()),
    GetPage(name: Routes.challengeAuthPhotos, page: ()=>ChallengeAuthPhotosPage()),
    GetPage(name: Routes.challengeAuthPhotoInfo, page: ()=>ChallengeAuthPhotoInfoPage()),
  ];
}

