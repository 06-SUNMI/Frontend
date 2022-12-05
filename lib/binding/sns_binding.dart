import 'package:get/get.dart';

import '../controller/sns_controller.dart';

class SNSBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SnsController());
  }

}