import 'dart:async';

import 'package:sunmi/data/model/challenge.dart';
import 'package:sunmi/data/provider/challenge_provider.dart';

class ChallengeRepository {
  final ChallengeProvider challengeProvider;

  ChallengeRepository({required this.challengeProvider});

  getAll() {
    return challengeProvider.getAll();
  }
}