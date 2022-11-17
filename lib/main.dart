import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sunmi/routes/homepage.dart';
import 'package:sunmi/routes/app_pages.dart';
import 'package:sunmi/ui/screen/routine/routine_calendar_page.dart';

void main(){
  runApp(
    GetMaterialApp(
      initialRoute: Routes.initial,
      getPages: AppPages.pages,
    )
  );
}