import 'package:get/get.dart';
import 'package:sunmi/controller/challenges_controller.dart';
import 'package:sunmi/data/provider/challenge_provider.dart';
import 'package:sunmi/data/provider/registered_challenge_provider.dart';
import 'package:sunmi/data/repository/challenge_repository.dart';
import 'package:sunmi/data/repository/registered_challenge_repository.dart';
import 'package:sunmi/controller/calendar_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>ChallengeController(
      challengeRepository: ChallengeRepository(
          challengeProvider: ChallengeProvider()),
      registeredChallengeRepository: RegisteredChallengeRepository(
          registeredChallengeProvider: RegisteredChallengeProvider()),
    ));
    Get.lazyPut(() => CalendarController());
  }
}