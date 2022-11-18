import 'package:get/get.dart';
import 'package:sunmi/data/model/registered_challenge.dart';

import 'package:sunmi/data/repository/challenge_repository.dart';
import 'package:sunmi/data/repository/registered_challenge_repository.dart';
import 'package:sunmi/data/model/challenge.dart';
import 'package:sunmi/routes/app_pages.dart';

class ChallengeController extends GetxController {
  final ChallengeRepository challengeRepository;
  final RegisteredChallengeRepository registeredChallengeRepository;

  ChallengeController({required this.challengeRepository,
  required this.registeredChallengeRepository});

  final _challenges = <Challenge>[].obs;
  get challenges => _challenges.value;
  set challenges(value) => _challenges.value = value;

  final _registeredChallenges = <RegisteredChallenge>[].obs;
  get registeredChallenges => _registeredChallenges.value;
  set registeredChallenges(value) => _registeredChallenges.value = value;

  @override

  getAll(){
    challengeRepository.getAll().then((data){
      this.challenges = data;
    });

    registeredChallengeRepository.getAllByMemberId().then((data){
      this.registeredChallenges = data;
    });
  }

  challengeInfo(int index){
    Get.toNamed(Routes.challengeInfo, arguments: {'challenge': challenges[index]});
  }

  registeredChallengeInfo(int index){
    Get.toNamed(Routes.registeredChallengeInfo, arguments: {"selectedChallengeId": registeredChallenges[index].challengeId});
  }
}