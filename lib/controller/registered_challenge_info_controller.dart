import 'package:get/get.dart';
import 'package:sunmi/controller/challenges_controller.dart';

import 'package:sunmi/data/model/registered_challenge.dart';
import 'package:sunmi/data/repository/registered_challenge_repository.dart';
import 'package:sunmi/routes/app_pages.dart';

class RegisteredChallengeInfoController extends GetxController{
  RegisteredChallengeInfoController({
    required this.registeredChallengeRepository
  });

  RegisteredChallengeRepository registeredChallengeRepository;
  late final Rx<RegisteredChallenge> _registeredChallenge;
  get registeredChallenge => _registeredChallenge.value;
  set registeredChallenge(value) => _registeredChallenge(value);

  final RxInt _currentChallengeId = 0.obs;
  get currentChallengeId => _currentChallengeId.value;
  set currentChallengeId(value) => _currentChallengeId.value = value;

  @override
  void onInit() {
    currentChallengeId = Get.arguments['selectedChallengeId'];
    _registeredChallenge = Rx<RegisteredChallenge>(registeredChallengeRepository.getById(currentChallengeId));

    ever(_currentChallengeId, (currentChallengeId){
      registeredChallenge = registeredChallengeRepository.getById(currentChallengeId);
    });
    super.onInit();
  }

  updateCurrentChallenge() {
    print('in registered controller getall started=====================');
    print('in registered controller get by id started=====================');
    registeredChallenge = registeredChallengeRepository.getById(currentChallengeId);
    print(registeredChallenge.progressRate);
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