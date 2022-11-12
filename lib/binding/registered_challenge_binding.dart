import 'package:get/get.dart';
import 'package:sunmi/controller/registered_challenge_info_controller.dart';
import 'package:sunmi/data/provider/registered_challenge_provider.dart';
import 'package:sunmi/data/repository/registered_challenge_repository.dart';

class RegisteredChallengeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RegisteredChallengeInfoController>((){
      return RegisteredChallengeInfoController();
    });

  }
}