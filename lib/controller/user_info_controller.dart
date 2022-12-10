import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

class UserInfoController extends GetxController{
  int? height;
  int? weight;
  String? gymName;
  late int gymId;
  int? userId;
  late String name;
  String? email;
  late String image;  
  int? socialId;
  String? loginAt;
  String? emailAccount;
  int point=0;
  RxList gymList = [].obs;
  RxInt isGymSelected = 0.obs;

  isNew(int kakaoId) async{
    socialId = kakaoId;
    String url = "http://15.164.168.230:8080/members";
    var response = await http.get(Uri.parse(url));
    var responseBody = response.bodyBytes;
    var userList = jsonDecode(utf8.decode(responseBody));//userList = 소셜 아이디, 소셜 종류

    for(int i=0;i<userList.length;i++){
      print(userList[i]["socialId"]);
      if(userList[i]["socialId"]!=null){
      if(int.parse(userList[i]["socialId"]) == kakaoId){//이미 있는 유저
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
    var responseBody = response.bodyBytes;
    var userData = jsonDecode(utf8.decode(responseBody));

    height = userData["memberHeight"];
    weight = userData["memberWeight"];
    gymName = userData["memberRegisteredGymName"];
    name = userData["memberName"];
    image = userData["customProfileImageUrl"];
    gymId = userData["memberRegisteredGymId"];
    point = userData["point"];
  }

  setName(var kakaoName){
    name = kakaoName;
  }
  setMail(var mail){
    emailAccount = mail;
  }
  setImage(var i){
    image = i;
  }

  setGym(int i){
    var temp = gymList[i];
    gymList.clear();
    gymList.add(temp);
    isGymSelected =1.obs;
  }
  searchGym(String text) async{
    isGymSelected = 0.obs;
    gymList.clear();
    String url = "http://15.164.168.230:8080/gyms?text=${text}";
    var response = await http.get(Uri.parse(url));
    var responseBody = response.bodyBytes;
    var tempList = jsonDecode(utf8.decode(responseBody));
    print(url);
    print(tempList);
    for(int i=0;i<tempList["documents"].length;i++){
      gymList.add({
        "gymName" : tempList["documents"][i]["place_name"],
        "gymId" : tempList["documents"][i]["id"],
        "gymAddress" : tempList["documents"][i]["address_name"],
      });
    }
    print(gymList);
  }

  setUserData(var heightInput, var weightInput) async{
    height = int.parse(heightInput);
    weight = int.parse(weightInput);
    gymName = gymList[0]["gymName"];
    gymId = gymList[0]["gymId"];
    String url = "http://15.164.168.230:8080/members";
    var data = {
      "loginAt": "KAKAO",
      "memberEmail": emailAccount,
      "memberHeight": height,
      "memberName": name,
      "memberRegisteredGymId": gymId,
      "memberRegisteredGymName": gymName,
      "memberWeight": weight,
      "socialAccountId": socialId,
      "memberProfileUrl" : image,
    };
    var body = jsonEncode(data);
    http.Response _res = await http.post(Uri.parse(url), headers: {"content-type": "application/json"}, body: body);
    setUserId();
  }
  setUserId() async{
     String url = "http://15.164.168.230:8080/members";
    var response = await http.get(Uri.parse(url));
    var responseBody = response.bodyBytes;
    var userList = jsonDecode(utf8.decode(responseBody));//userList = 소셜 아이디, 소셜 종류

    for(int i=0;i<userList.length;i++){
      if(userList[i]["socialId"]!=null){
      if(int.parse(userList[i]["socialId"]) == socialId){//이미 있는 유저
        userId = userList[i]["memberId"];
      }
      }
    }
  }
}