import 'package:get/get.dart';
import 'package:sunmi/controller/sns_post_controller.dart';
import 'package:sunmi/data/provider/sns_post_provider.dart';
import 'package:sunmi/data/repository/sns_post_repository.dart';

class SNSPostBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SNSPostController>((){
      return SNSPostController(
          snsPostRepository: SNSPostRepository(
              snsPostProvider: SNSPostProvider()));
    });
  }
}