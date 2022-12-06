
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../data/post.dart';

class SnsController extends GetxController {
  static SnsController get to => Get.find();
  var Info;
  RxList info =[].obs;

  @override
  void onIniit() async{
    super.onInit();
    await getpost();
  }

  void setPost(){
    getpost();
  }

  getpost() async {
    info.clear();
    var url = 'http://15.164.168.230:8080/sns/posts';
    final response = await http.get(Uri.parse((url)));
    Info = jsonDecode(utf8.decode(response.bodyBytes));
    print(Info);
    for(int i=0; i<Info.length; i++){
      info.add({
        "memberName" : Info[i]["memberName"],
        "snsPostId": Info[i]['snsPostId'],
        "memberName" : Info[i]["memberName"],
        "snsContent": Info[i]['snsContent'],
        "snsLikesNum": Info[i]['snsLikesNum'],
        "memberProfilePhotoUrl" : 'assets/images/eh.png',
        "favcheck" : false.obs,
        "snsImageOrVideoLinkList": Info[i]['snsImageOrVideoLinkList'][0],
      });
      print(info[i]);
    }
    info = List.from(info.reversed).obs;

      //update();
  }

  //counts() async{
   // getpost();
   // return info.length;
 // }
  void increase(int index) {
    if(info[index]["favcheck"]==true){
      info[index]["favcheck"].value = false;
    }
    else {
      info[index]["favcheck"].value = true;
    }
  }
}