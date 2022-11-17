import 'package:get/get.dart';
import 'package:sunmi/controller/challenge_date_controller.dart';


class ChallengeDateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChallengeDateController());
  }
}