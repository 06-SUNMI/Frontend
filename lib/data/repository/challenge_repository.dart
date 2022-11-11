import 'dart:async';

import 'package:sunmi/data/model/challenge.dart';
import 'package:sunmi/data/provider/challenge_provider.dart';

class ChallengeRepository {
  final ChallengeProvider challengeProvider;

  ChallengeRepository({required this.challengeProvider});

  getAll() {
    List<Challenge> mockChallenges = List<Challenge>.empty(growable: true);

    mockChallenges.add(Challenge(
        challengeId: 1,
        challengeName: '1',
        startDate: DateTime.now(),
        endDate: DateTime.now()));
    mockChallenges.add(Challenge(
        challengeId: 2,
        challengeName: '2',
        startDate: DateTime.now(),
        endDate: DateTime.now()));
    return mockChallenges;
  }

  getByUserId(int userId) {
    List<Challenge> mockRegisteredChallenges = List<Challenge>.empty(growable: true);

    mockRegisteredChallenges.add(Challenge(
        challengeId: 3,
        challengeName: '3',
        startDate: DateTime.now(),
        endDate: DateTime.now()));
    mockRegisteredChallenges.add(Challenge(
        challengeId: 4,
        challengeName: '4',
        startDate: DateTime.now(),
        endDate: DateTime.now()));
    return mockRegisteredChallenges;
  }
}
