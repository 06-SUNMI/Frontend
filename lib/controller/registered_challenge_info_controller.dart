import 'package:get/get.dart';

import 'package:sunmi/data/model/registered_challenge.dart';
import 'package:sunmi/data/repository/registered_challenge_repository.dart';
import 'package:sunmi/routes/app_pages.dart';

class RegisteredChallengeInfoController extends GetxController{
  RegisteredChallengeRepository registeredChallengeRepository;
  late RegisteredChallenge registeredChallenge;

  RxInt _currentChallengeId = 0.obs;
  get currentChallengeId => this._currentChallengeId.value;
  set currentChallengeId(value) => this._currentChallengeId.value = value;

  RegisteredChallengeInfoController({
    required this.registeredChallengeRepository
  });

  getById(int challengeId){
    this.currentChallengeId = challengeId;
    registeredChallenge = registeredChallengeRepository.getById(challengeId);
  }

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