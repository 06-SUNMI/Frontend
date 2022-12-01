import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class UserInfoController extends GetxController{
  int? height;
  int? weight;
  String? gymName;
  int? userId;
  String? name;
  String? email;
  Image? image;  
  int? socialId;
  String? loginAt;
  String? emailAccount;

  isNew(int kakaoId) async{
    socialId = kakaoId;
    String url = "http://15.164.168.230:8080/members";
    var response = await http.get(Uri.parse(url));
    var responseBody = response.body;
    var userList = jsonDecode(responseBody);//userList = 소셜 아이디, 소셜 종류
    print("kakao:  ${kakaoId}");

    for(int i=0;i<userList.length;i++){
      print(userList[i]["socialId"]);
      if(userList[i]["socialId"]!=null){
      if(int.parse(userList[i]["socialId"]) == kakaoId){//이미 있는 유저
        print("true");
        userId = userList[i]["memberId"];
        return false;
      }
      }
    }
    return true;//없는 유저
  }

  getUserData() async{
    String url = "http://15.164.168.230:8080/members/${userId}";
    var response = await http.get(Uri.parse(url));
    var responseBody = response.body;
    var userData = jsonDecode(responseBody);

    height = userData["memberHeight"];
    weight = userData["memberWeight"];
    gymName = userData["memberRegisteredGymName"];
    name = userData["memberName"];

  }

  setName(var kakaoName){
    name = kakaoName;
  }
  setMail(var mail){
    emailAccount = mail;
  }

  setUserData(var heightInput, var weightInput, var gymInput) async{
    height = int.parse(heightInput);
    weight = int.parse(weightInput);
    gymName = gymInput;
    String url = "http://15.164.168.230:8080/members";
    var data = {
      "loginAt": "KAKAO",
      "memberEmail": emailAccount,
      "memberHeight": height,
      "memberName": name,
      "memberRegisteredGymId": 0,
      "memberRegisteredGymName": gymName,
      "memberWeight": weight,
      "socialAccountId": socialId,
    };
    var body = jsonEncode(data);
    http.Response _res = await http.post(Uri.parse(url), headers: {"content-type": "application/json"}, body: body);
  }
}