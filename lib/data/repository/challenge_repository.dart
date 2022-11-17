import 'dart:async';

import 'package:sunmi/data/model/challenge.dart';
import 'package:sunmi/data/provider/challenge_provider.dart';

class ChallengeRepository {
  final ChallengeProvider challengeProvider;

  ChallengeRepository({required this.challengeProvider});

  getAll() {
    return challengeProvider.getAll();
  }

  getByUserId(int userId) {
    List<Challenge> mockRegisteredChallenges = List<Challenge>.empty(growable: true);

    mockRegisteredChallenges.add(Challenge(
        challengeId: 3,
        challengeName: '3',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        participationFee: 30000,
        participatedNum: 10,
        numPerWeek: 3));
    mockRegisteredChallenges.add(Challenge(
        challengeId: 4,
        challengeName: '4',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        participationFee: 30000,
        participatedNum: 10,
        numPerWeek: 3));
    return mockRegisteredChallenges;
  }
}