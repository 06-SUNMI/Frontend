import 'dart:async';

import 'package:sunmi/data/model/challenge.dart';
import 'package:sunmi/data/provider/challenge_provider.dart';

class ChallengeRepository {
  final ChallengeProvider challengeProvider;

  ChallengeRepository({required this.challengeProvider});

  getAll() {
    return challengeProvider.getAll();
  }

  getChallengesInProgress() async {
    List challenges = await challengeProvider.getAll();
    List<Challenge> challengeInProgress = [];
    print(challenges);

    for(Challenge challenge in challenges){
      if(isInProgress(challenge)) {
        challengeInProgress.add(challenge);
      }
    }

    return challengeInProgress;
  }

  isInProgress(Challenge challenge){
    DateTime today = DateTime.now();
    if(challenge.endDate.difference(today).inDays >= 0){
      return true;
    } else {
      return false;
    }
  }
}