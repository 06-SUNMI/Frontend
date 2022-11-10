import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunmi/routes/tab_page.dart';



void main(){
  runApp(
    GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const TabPage()),
      ],
    )
  );
}

