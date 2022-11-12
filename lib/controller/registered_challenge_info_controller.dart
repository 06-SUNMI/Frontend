import 'package:get/get.dart';

import 'package:sunmi/data/model/registered_challenge.dart';
import 'package:sunmi/data/repository/registered_challenge_repository.dart';
import 'package:sunmi/routes/app_pages.dart';

class RegisteredChallengeInfoController {
  toChallengeAuth(){
    Get.toNamed(Routes.challengeAuth);
  }

  toChallengeAuthPhotos(){
    Get.toNamed(Routes.challengeAuthPhotos);
  }

  toChallengeAuthPhotoInfo(){
    Get.toNamed(Routes.challengeAuthPhotoInfo);
  }
}