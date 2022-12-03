import 'package:get/get.dart';
import 'package:sunmi/controller/challenges_controller.dart';
import 'package:sunmi/data/model/registered_challenge.dart';

import 'package:sunmi/data/provider/registered_challenge_provider.dart';

class RegisteredChallengeRepository {
  final RegisteredChallengeProvider registeredChallengeProvider;

  RegisteredChallengeRepository({required this.registeredChallengeProvider});

  getAllByMemberId(memberId){
    return registeredChallengeProvider.getAllByMemberId(memberId);
  }

  getById(int challengeId){
    ChallengeController challengeController = Get.find<ChallengeController>();

    for (RegisteredChallenge challenge in challengeController.registeredChallenges) {
      if(challenge.challengeId == challengeId) {
        return challenge;
      }
    }
    print('Specific Challenge not Found, challengeId : $challengeId');
  }
}