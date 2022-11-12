import 'package:get/get.dart';
import 'package:sunmi/controller/challenges_controller.dart';
import 'package:sunmi/data/provider/challenge_provider.dart';
import 'package:sunmi/data/repository/challenge_repository.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ChallengeController>(ChallengeController(
        challengeRepository: ChallengeRepository(
            challengeProvider: ChallengeProvider())));
  }
}