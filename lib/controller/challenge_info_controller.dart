import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class ChallengeInfoController extends GetxController{
  static ChallengeInfoController get to => Get.find();
  var Info;
  late int _id;
  RxList info =[].obs;

  @override
  void onInit(){
    getChallengeInfo();
  }
  void setId(var value){
    _id=value.challengeId;
  }
  getChallengeInfo() async{

    var url = 'http://15.164.168.230:8080/challenges/${_id}';
    final response = await http.get(Uri.parse((url)));
    Info = jsonDecode(response.body);
    for(int i=0; i<Info['challengeRoutineDataList'].length; i++)
      for(int j=0; j<Info['challengeRoutineDataList'][i]['challengeRoutineContentDataList'].length; j++)
        info.add({
          "name" : Info['challengeRoutineDataList'][i]['challengeRoutineContentDataList'][j]['challengeRoutineWorkoutName'],
          "date" : (i+1),
        }
        );

  }
}
