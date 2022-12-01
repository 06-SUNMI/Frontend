import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class SearchController extends GetxController{

  static SearchController get to => Get.find();
  var Info;
  RxList list = [].obs;
  RxInt counter = 0.obs;
  bool _isChecked = false;
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
      'http://15.164.168.230:8080/sns/users/$tea',
    );
    final response = await http.get(url);
    //Info = jsonDecode(response.body);
    Info = jsonDecode(utf8.decode(response.bodyBytes));
    print(Info);

    for(int i=0; i<Info.length; i++) {
      list.add({
        //"id" : Info['id'][i]o,
        "id": Info[i]['id'],
        "name": Info[i]['name'],
        "gymName" : Info[i]['gymName'],
        "customProfileImageUrl" : Info[i]['customProfileImageUrl'],
      });
    }
    for(int i=0; i<list.length; i++) {
      print((list[i]["id"]));
      print((list[i]["name"]));
      print((list[i]["gymName"]));
      print((list[i]["customProfileImageUrl"]));
    }

  }

  gymgetSearch(String tea) async{
    list.clear();
    var url = Uri.parse(
      'http://15.164.168.230:8080/sns/users/$tea',
    );
    final response = await http.get(url);
    //Info = jsonDecode(response.body);
    Info = jsonDecode(utf8.decode(response.bodyBytes));
    print(Info);

    for(int i=0; i<Info.length; i++) {
      String gym = Info[i]['gymName'];
      if(gym == '나이스짐') {
        list.add({
          //"id" : Info['id'][i]o,
          "id": Info[i]['id'],
          "name": Info[i]['name'],
          "gymName": Info[i]['gymName'],
          "customProfileImageUrl": Info[i]['customProfileImageUrl'],
        });
      }
    }
    for(int i=0; i<list.length; i++) {
      print((list[i]["id"]));
      print((list[i]["name"]));
      print((list[i]["gymName"]));
      print((list[i]["customProfileImageUrl"]));
    }

  }
}
