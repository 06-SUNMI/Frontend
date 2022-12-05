import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sunmi/controller/user_info_controller.dart';

class ChallengeDateController extends GetxController{
  static ChallengeDateController get to => Get.find();
  var week = ["일", "월", "화", "수", "목", "금", "토"];
  static DateTime now = DateTime.now();
  var challengeId;

  //RxInt year = 0.obs;
  //RxInt month = 0.obs;
  RxList days = [].obs;

  List selectDays = [];

  @override
  void onInit () {
    super.onInit();
   // setFirst(start, end)
  }

  setFirst(DateTime start, DateTime end) {
    int duration = end.difference(start).inDays;
    insertDays(start, duration);
  }

  insertDays(DateTime start, int duration) {
    days.clear();
    DateTime temp;
    for (var i = 0; i <= duration; i++) {
      temp = DateTime(start.year, start.month, start.day+i);
      days.add({
        "year": temp.year,
        "month": temp.month,
        "day": temp.day,
        "inChallenge": true,
        "picked": false.obs,
      });
    }

    if (DateTime(start.year, start.month, start.day).weekday != 7) {
      var tempList = [];
      for (var i = DateTime(start.year, start.month, start.day).weekday ; i > 0; i--) {
        temp = DateTime(start.year, start.month, start.day-i);
        tempList.add({
          "year": temp.year,
          "month": temp.month - 1,
          "day": temp.day,
          "inChallenge": false,
          "picked": false.obs,
        });
      }
      days = [...tempList, ...days].obs;
    }

  }

    pickDate(int index){
    if(days[index]["picked"] == true){
      days[index]["picked"].value = false;
      selectDays.remove("${days[index]["year"]}-${days[index]["month"]}-${days[index]["day"]}");
    }
    else{
      days[index]["picked"].value = true;
      selectDays.add("${days[index]["year"]}-${days[index]["month"]}-${days[index]["day"]}");
    }
    
  }

  setId(int id){
    challengeId = id;
  }

  challengePush() async{
    String url = "http://15.164.168.230:8080/members/${Get.find<UserInfoController>().userId}/challenges/${challengeId}";
    await http.post(Uri.parse(url), headers: {"content-type": "application/json"}, body: jsonEncode(selectDays));
  }
}