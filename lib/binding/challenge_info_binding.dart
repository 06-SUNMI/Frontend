import 'package:get/get.dart';

import '../controller/challenge_info_controller.dart';

class ChallengeInfoBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ChallengeInfoController());
  }

}