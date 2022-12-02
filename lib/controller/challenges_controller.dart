import 'package:get/get.dart';
import 'package:sunmi/data/model/registered_challenge.dart';

import 'package:sunmi/data/repository/challenge_repository.dart';
import 'package:sunmi/data/repository/registered_challenge_repository.dart';
import 'package:sunmi/data/model/challenge.dart';
import 'package:sunmi/routes/app_pages.dart';

import 'user_info_controller.dart';

class ChallengeController extends GetxController {
  final ChallengeRepository challengeRepository;
  final RegisteredChallengeRepository registeredChallengeRepository;

  ChallengeController({required this.challengeRepository,
  required this.registeredChallengeRepository});

  final _challenges = <Challenge>[].obs;
  get challenges => _challenges;
  set challenges(value) => _challenges.assignAll(value);

  final _registeredChallenges = <RegisteredChallenge>[].obs;
  get registeredChallenges => _registeredChallenges;
  set registeredChallenges(value) => _registeredChallenges.assignAll(value);

  getAll(){
    print("challenge controller getAll() started-------------");
    challengeRepository.getChallengesInProgress().then((data){
      challenges = data;

    });
    registeredChallengeRepository.getAllByMemberId(Get.find<UserInfoController>().userId!).then((data){
      registeredChallenges = data;
    });
    print("challenge controller getAll() ended---------------");
  }

  challengeInfo(int index){
    Get.toNamed(Routes.challengeInfo, arguments: {'challenge': challenges[index]});
  }

  registeredChallengeInfo(int index){
    Get.toNamed(Routes.registeredChallengeInfo, arguments: {"selectedChallengeId": registeredChallenges[index].challengeId});
  }
}