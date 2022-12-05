import 'package:get/get.dart';

import '../controller/sns_search_controller.dart';

class SearchBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController());
  }

}