import 'package:get/get.dart';

import 'package:sunmi/data/provider/challenge_provider.dart';
import 'package:sunmi/data/repository/challenge_repository.dart';
import 'package:sunmi/controller/challenges_controller.dart';

class ChallengeBinding extends Bindings {

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ChallengeController>(() {
      return ChallengeController(
          challengeRepository: ChallengeRepository(
              challengeProvider: ChallengeProvider()
          )
      );
    });
  }
}
