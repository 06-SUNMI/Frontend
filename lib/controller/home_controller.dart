import 'package:get/get.dart';

class HomeController extends GetxController{
  static HomeController get to => Get.find();
  RxInt _curPage = 0.obs;

  @override
  void onInit(){
    super.onInit();
  }

  RxInt get curPage => _curPage;

  void changeCurPage(int index){
    _curPage(index);
  }
}