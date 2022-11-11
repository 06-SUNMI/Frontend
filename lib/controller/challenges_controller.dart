import 'package:get/get.dart';

import 'package:sunmi/data/repository/challenge_repository.dart';
import 'package:sunmi/data/model/challenge.dart';
import 'package:sunmi/routes/app_pages.dart';

class ChallengeController extends GetxController {
  final ChallengeRepository challengeRepository;
  ChallengeController({required this.challengeRepository});

  final _challenges = <Challenge>[].obs;
  get challenges => _challenges.value;
  set challenges(value) => _challenges.value = value;

  final _registeredChallenges = <Challenge>[].obs;
  get registeredChallenges => _registeredChallenges.value;
  set registeredChallenges(value) => _registeredChallenges.value = value;

  @override
  void onInit(){
    super.onInit();
    getAll();
  }

  getAll(){
    List<Challenge> challenges = challengeRepository.getAll();
    List<Challenge> registeredChallenges = challengeRepository.getByUserId(0);
    this.challenges = challenges;
    this.registeredChallenges = registeredChallenges;
  }

  challengeDetails(int index){
    Get.toNamed(Routes.challengeDetail, arguments: 3);
  }

  registeredChallengeDetails(int index){
    Get.toNamed(Routes.registeredChallengeDetail, arguments: {"index": index});
  }
}
