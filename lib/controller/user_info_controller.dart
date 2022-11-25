import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class UserInfoController extends GetxController{
  double? height;
  double? weight;
  String? gymName;
  late int userId;
  String? name;
  String? email;
  Image? image;  
  User? user;

  setKakaoUser(User u){
    user = u;
  }

  setUser(String h, String w, String gym){
    height = double.parse(h);
    weight = double.parse(w);
    gymName = gym;
  }

  postUser(){
    
  }

  isNew(int kakaoId) async{
    print("thisisisNew");
    String url = "http://15.164.168.230:8080/members";
    var response = await http.get(Uri.parse(url));
    var responseBody = response.body;
    var userList = jsonDecode(responseBody);
    print(userList);
    for(int i=0;i<userList.length;i++){
      if(userList[i]["socialAccountId"] == kakaoId){//이미 있는 유저
      try{
        height = userList[i]["membetHeight"];
        weight = userList[i]["memberWeight"];
        userId = userList[i]["memberId"];
        name = userList[i]["memberName"];
        
      }catch(e){
        print("can't read data : isNew() ");
      }
        return false;
      }
    }
    return true;//없는 유저
  }

}