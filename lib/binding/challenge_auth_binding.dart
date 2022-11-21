import 'package:get/get.dart';
import 'package:sunmi/controller/challenge_auth_controller.dart';
import 'package:sunmi/data/provider/challenge_auth_provider.dart';
import 'package:sunmi/data/repository/challenge_auth_repository.dart';

class ChallengeAuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChallengeAuthController(
        challengeAuthRepository: ChallengeAuthRepository(
            challengeAuthProvider: ChallengeAuthProvider())));
  }
}