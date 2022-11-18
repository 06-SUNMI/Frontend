import 'package:get/get.dart';
import 'package:sunmi/controller/challenges_controller.dart';

import 'package:sunmi/data/model/registered_challenge.dart';
import 'package:sunmi/data/repository/registered_challenge_repository.dart';
import 'package:sunmi/routes/app_pages.dart';

class RegisteredChallengeInfoController extends GetxController{
  RegisteredChallengeRepository registeredChallengeRepository;
  late Rx<RegisteredChallenge> _registeredChallenge;
  get registeredChallenge => _registeredChallenge.value;
  set registeredChallenge(value) => _registeredChallenge.value = value;

  RxInt _currentChallengeId = 0.obs;
  get currentChallengeId => this._currentChallengeId.value;
  set currentChallengeId(value) => this._currentChallengeId.value = value;

  @override
  void onInit(){
    once(_currentChallengeId, (currentChallengeId) async {
      _registeredChallenge = Rx<RegisteredChallenge>(await registeredChallengeRepository.getById(currentChallengeId));
      _registeredChallenge.refresh();
    });
    // ever(_currentChallengeId, (currentChallengeId){
    //   registeredChallenge = getById(currentChallengeId);
    // });
    super.onInit();
  }

  RegisteredChallengeInfoController({
    required this.registeredChallengeRepository
  });

  updateCurrentChallenge(){
    Get.find<ChallengeController>().getAll();
    registeredChallenge = registeredChallengeRepository.getById(currentChallengeId);
    _registeredChallenge.refresh();
  }

  getById(int challengeId){
    currentChallengeId = challengeId;
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