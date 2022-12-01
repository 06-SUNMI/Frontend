import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class CalendarController extends GetxController {
  static CalendarController get to => Get.find();
  var week = ["일", "월", "화", "수", "목", "금", "토"];
  static DateTime now = DateTime.now();

  RxInt year = 0.obs;
  RxInt month = 0.obs;
  RxList days = [].obs;
  var routinelist;
  int routineCount = 0;
  Map routineInfo = {};
  var routineInfoList;
  RxList routineDay= [].obs;

  late DateTime pick;
  var pickDateRoutineId;
  late int dayTemp;

  @override
  void onInit () {
    super.onInit();
    getRoutines();
    setFirst(now.year, now.month);
  }

  setFirst(int setYear, int setMonth) {
    year.value = setYear;
    month.value = setMonth;
    insertDays(year.value, month.value);
  }

  insertDays(int year, int month) {
    days.clear();

    int lastDay = DateTime(year, month + 1, 0).day;
    for (var i = 1; i <= lastDay; i++) {
      days.add({
        "year": year,
        "month": month,
        "day": i,
        "inMonth": true,
        "picked": false.obs,
        "routineId" : 0.obs,
        "allChecked" : false.obs,
      });
    }

    if (DateTime(year, month, 1).weekday != 7) {
      var temp = [];
      int prevLastDay = DateTime(year, month, 0).day;
      for (var i = DateTime(year, month, 1).weekday - 1; i >= 0; i--) {
        temp.add({
          "year": year,
          "month": month - 1,
          "day": prevLastDay - i,
          "inMonth": false,
          "picked": false.obs,
          "routineId": 0.obs,
          "allChecked" : false.obs,
        });
      }
      days = [...temp, ...days].obs;
    }
    
    var temp = [];
    for (var i = 1; i <= 42 - days.length; i++) {
      temp.add({
        "year": year,
        "month": month + 1,
        "day": i,
        "inMonth": false,
        "picked": false.obs,
        "routineId": 0.obs,
        "allChecked" : false.obs,
      });
    }

    days = [...days, ...temp].obs;
  }

  isToday(int year, int month, int day) {
    if (year == DateTime.now().year && month == DateTime.now().month && day == DateTime.now().day) {
      return true;
    }
    return false;
  }
  pickDate(int index){
    for(var day in days){
      day["picked"].value = false;
    };
    days[index]["picked"].value = true;
    pick = DateTime(days[index]["year"],days[index]["month"],days[index]["day"]);
    pickDateRoutineId = days[index]["routineId"];
    routineDay.clear();
    
    if(days[index]["routineId"]!=0){
      for(int i=0;i<routineInfo[days[index]["routineId"]]["memberRoutineData"]["memberRoutineContentList"].length;i++){
        routineDay.add({
          "workoutId" : routineInfo[days[index]["routineId"]]["memberRoutineData"]["memberRoutineContentList"][i]["memberRoutineContentId"],
          "workoutName": routineInfo[days[index]["routineId"]]["memberRoutineData"]["memberRoutineContentList"][i]["memberRoutineWorkoutName"],
          "workoutCount " : routineInfo[days[index]["routineId"]]["memberRoutineData"]["memberRoutineContentList"][i]["memberRoutineWorkoutCount"],
          "workoutSet" : routineInfo[days[index]["routineId"]]["memberRoutineData"]["memberRoutineContentList"][i]["memberRoutineWorkoutSet"],
          "workoutTime" : routineInfo[days[index]["routineId"]]["memberRoutineData"]["memberRoutineContentList"][i]["memberRoutineWorkoutTime"],
          "isChecked" : routineInfo[days[index]["routineId"]]["memberRoutineData"]["memberRoutineContentList"][i]["memberRoutineIsChecked"] ==true ? true.obs : false.obs,
        }
        );
      }
    }
    dayTemp = index;
  }

  getRoutines() async{
    String url = 'http://15.164.168.230:8080/members/1/routines';
    var response = await http.get(Uri.parse(url));
    var responseBody = response.body;
    routinelist = jsonDecode(responseBody);
    routineCount = routinelist["memberRoutineDataList"].length; 
    for(var i=0;i<routineCount;i++){
      getRoutineInfo(routinelist["memberRoutineDataList"][i]["routineId"], routinelist["memberRoutineDataList"][i]["routineRegisterData"]);
    }

    for(int i=0;i<days.length;i++){
      days[i]["routineId"].value = hasRoutine(days[i]["year"], days[i]["month"], days[i]["day"]);
    }
    for(int i=0;i<days.length;i++){
      //days[i]["allChecked"] = checkRate(days[i]["year"], days[i]["month"], days[i]["day"]);
    }
  }

  hasRoutine(int checkyear, int checkmonth, int checkday){
    String date = "${checkyear}-${checkmonth}-${checkday}";
    if(checkday<10){
      date = "${checkyear}-${checkmonth}-0${checkday}";
    }
    int rId = 0;
    for(var i=0;i<routineCount;i++){
      
      if(routinelist["memberRoutineDataList"][i]["routineRegisterData"]==date){
        rId =  routinelist["memberRoutineDataList"][i]["routineId"];
      }
      else{
      }
    }
    return rId;
  }

  getRoutineInfo(int id, String infodate) async{
    String url = 'http://15.164.168.230:8080/routines/${id}';
    var response = await http.get(Uri.parse(url));
    var responseBody = response.body;
    routineInfoList = jsonDecode(responseBody);
    routineInfo[id] = routineInfoList;
  }

  deleteWorkout(int index, int dayIndex) async{
    int deleteWorkoutId = routineDay[index]["workoutId"];

    if(routineDay.length==1){
      String url = 'http://15.164.168.230:8080/routines/${days[dayIndex]["routineId"]}';
      await http.delete(Uri.parse(url));
    }
    else{
      String url = 'http://15.164.168.230:8080/routines/${days[dayIndex]["routineId"]}/routine-content/${deleteWorkoutId}';
      await http.delete(Uri.parse(url));
    }    
  }
  editWorkout(int index, int dayIndex) async{
    int editWorkoutId = routineDay[index]["workoutId"];

    String url = 'http://15.164.168.230:8080/routines/${days[dayIndex]["routineId"]}/routine-content/${editWorkoutId}';

  }

  pickWorkout(int index) async{
    if(routineDay[index]["isChecked"] == true){
      routineDay[index]["isChecked"].value = false;
    }
    else{
      routineDay[index]["isChecked"].value = true;
    }
    
    String url = 'http://15.164.168.230:8080/routines/routine-contents/${routineDay[index]["workoutId"]}/check';
    await http.put(Uri.parse(url));
  }
}