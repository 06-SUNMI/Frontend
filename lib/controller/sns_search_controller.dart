import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sunmi/controller/user_info_controller.dart';



class SearchController extends GetxController{

  static SearchController get to => Get.find();
  String gymId = Get.find<UserInfoController>().gymId;

  var Info;
  RxList list = [].obs;
  RxInt counter = 0.obs;
  bool _isChecked = false;
  late int userId;
  @override
  increase(var value) {
      return _isChecked = false;
  }
  noincrease(var value) {
    return _isChecked = true;
  }
  getSearch(String tea) async{
    list.clear();
    var url = Uri.parse(
      'http://15.164.168.230:8080/sns/members/$tea',
    );
    final response = await http.get(url);
    //Info = jsonDecode(response.body);
    Info = jsonDecode(utf8.decode(response.bodyBytes));
    print(Info);

    for(int i=0; i<Info.length; i++) {
      list.add({
        //"id" : Info['id'][i]o,
        "id": Info[i]['memberId'],
        "name": Info[i]['name'],
        "gymName" : Info[i]['gymName'],
        "customProfileImageUrl" : Info[i]['customProfileImageUrl'],
      });
    }

  }
  setId(int i){
    userId = i;
  }

  gymgetSearch(String tea) async{
    list.clear();
    var url = Uri.parse(
      'http://15.164.168.230:8080/sns/members/$tea',
    );
    final response = await http.get(url);
    //Info = jsonDecode(response.body);
    Info = jsonDecode(utf8.decode(response.bodyBytes));
    print(Info);
    for(int i=0; i<Info.length; i++) {
      String gym = Info[i]['gymId'];
      if(gym == gymId) {
        list.add({
          //"id" : Info['id'][i]o,
          "id": Info[i]['memberId'],
          "name": Info[i]['name'],
          "gymName": Info[i]['gymName'],
          "gymId" : Info[i]['gymId'],
          "customProfileImageUrl": Info[i]['customProfileImageUrl'],
        });
      }
    }

  }
}
