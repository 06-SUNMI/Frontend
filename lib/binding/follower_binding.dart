import 'package:get/get.dart';

import '../controller/sns_search_controller.dart';
import '../controller/sns_user_routine_info_controller.dart';
import '../controller/user_info_controller.dart';



class FollowBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => UserInfoController());
    Get.lazyPut(() => SNSRoutineController());
    Get.lazyPut(()=> SearchController());
  }

}