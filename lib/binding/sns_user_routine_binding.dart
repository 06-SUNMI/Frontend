import 'package:get/get.dart';
import 'package:sunmi/controller/sns_user_routine_info_controller.dart';

class SNSRoutineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SNSRoutineController());
  }
}