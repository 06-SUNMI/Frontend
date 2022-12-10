
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sunmi/controller/user_info_controller.dart';

import '../data/post.dart';

class SnsgymController extends GetxController {
  static SnsgymController get to => Get.find();
  final controller = Get.put(UserInfoController());
  var Info;
  RxList info =[].obs;

  @override
  void onIniit() async{
    super.onInit();
    await getsamegym();
  }

  getsamegym() async {
    info.clear();
    print(controller.userId.toString());
    var url = 'http://15.164.168.230:8080/sns/members/${controller.userId}/same-gym';
    final response = await http.get(Uri.parse((url)));
    Info = jsonDecode(utf8.decode(response.bodyBytes));
    print(Info);
    for(int i=0; i<Info.length; i++){
      info.add({
        "memberId" : Info[i]["memberId"],
        "memberName" : Info[i]["memberName"],
        "memberRegisteredGymName": Info[i]['memberRegisteredGymName'],
        "customProfileImageUrl": Info[i]['customProfileImageUrl'],
      });
      print(info[i]);
    }
    info = List.from(info.reversed).obs;

  }

}