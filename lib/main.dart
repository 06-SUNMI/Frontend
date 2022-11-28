import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sunmi/routes/homepage.dart';
import 'package:sunmi/routes/app_pages.dart';
import 'package:sunmi/ui/screen/routine/routine_calendar_page.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';


void main(){
  KakaoSdk.init(nativeAppKey: 'a6035518e6beb44e880a7138599a7e30');
  runApp(
    GetMaterialApp(
      initialRoute: Routes.initial,
      getPages: AppPages.pages,
    )
  );
}