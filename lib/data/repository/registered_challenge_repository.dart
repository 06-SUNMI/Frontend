import 'package:get/get.dart';
import 'package:sunmi/data/model/registered_challenge.dart';

import 'package:sunmi/data/provider/registered_challenge_provider.dart';

class RegisteredChallengeRepository {
  final RegisteredChallengeProvider registeredChallengeProvider;

  RegisteredChallengeRepository({required this.registeredChallengeProvider});

  getAllByMemberId(){
    return registeredChallengeProvider.getAllByMemberId(1);
  }

  getById(int challengeId){
    DateTime endDate = DateTime(DateTime.now().year, DateTime.now().month +1, 0);
    // return registeredChallengeProvider.getById(challengeId, 1);
    return RegisteredChallenge(
        challengeId: challengeId,
        challengeName: '신청한 챌린지',
        startDate: DateTime.now(),
        endDate: endDate,
        progressRate: 25,
        participatedNum: 1,
        participationFee: 30000,
        numPerWeek: 3);
  }
}