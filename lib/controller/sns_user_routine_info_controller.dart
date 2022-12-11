import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sunmi/controller/sns_search_controller.dart';
import 'package:sunmi/controller/user_info_controller.dart';

class SNSRoutineController extends GetxController {
  static SNSRoutineController get to => Get.find();
  var week = ["일", "월", "화", "수", "목", "금", "토"];
  DateTime pickday = DateTime.now();
  
  RxInt year = 0.obs;
  RxInt month = 0.obs;
  RxList days = [].obs;  
  var routineDay =[];

  RxMap userRoutineList = {}.obs;
  RxMap challengeRoutineList = {}.obs;

  int userRoutineCount = 0;
  int challengeRoutineCount = 0;
  late int ck=0;

  String pickString = "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";

  late int userId;



  @override
  void onInit () async{
    super.onInit();
    await getRoutines();
    setFirst(pickday.year, pickday.month);
  }

  setId(int i){
    userId = i;
  }

  getRoutines() async{//루틴 전체 조회
    print("GetRoutines start");
    var routineIdList;
    int routineCount = 0;
    String url = 'http://15.164.168.230:8080/members/${Get.find<SearchController>().userId}/routines';
    var response = await http.get(Uri.parse(url));
    var responseBody = response.body;
    routineIdList = jsonDecode(responseBody);

    if(routineIdList["memberRoutineDataList"]==null){
      routineCount=0;
    }else{
      routineCount = routineIdList["memberRoutineDataList"].length; 
    }

    for(var i=0;i<routineCount;i++){
      await getRoutineInfo(routineIdList["memberRoutineDataList"][i]["routineId"], routineIdList["memberRoutineDataList"][i]["routineRegisterData"]);
    }
    userRoutineCount = userRoutineList["${pickday.year}-${pickday.month}-${pickday.day}"]!=null? userRoutineList["${pickday.year}-${pickday.month}-${pickday.day}"]["memberRoutineData"]["memberRoutineContentList"].length : 0;
    int temp = challengeRoutineList["${pickday.year}-${pickday.month}-${pickday.day}"]!=null? challengeRoutineList["${pickday.year}-${pickday.month}-${pickday.day}"]["memberRoutineData"]["memberRoutineContentList"].length: 0;
    challengeRoutineCount = temp;
    print("getRoutines finished");
  }

  getUserRoutineCount(){
    return userRoutineCount.toInt();
  }
  getChallengeRoutineCount(){
    return challengeRoutineCount.toInt();
  }
  pickChallengeWorkout(int i) async{
    challengeRoutineList[pickString]["memberRoutineData"]["memberRoutineContentList"][i]["memberRoutineIsChecked"] = !challengeRoutineList[pickString]["memberRoutineData"]["memberRoutineContentList"][i]["memberRoutineIsChecked"];
    String url = 'http://15.164.168.230:8080/routines/routine-contents/${challengeRoutineList[pickString]["memberRoutineData"]["memberRoutineContentList"][i]["memberRoutineContentId"]}/check';
    await http.put(Uri.parse(url));
    onInit();
  }
  pickUserWorkout(int i) async{
    userRoutineList[pickString]["memberRoutineData"]["memberRoutineContentList"][i]["memberRoutineIsChecked"] = !userRoutineList[pickString]["memberRoutineData"]["memberRoutineContentList"][i]["memberRoutineIsChecked"];
    String url = 'http://15.164.168.230:8080/routines/routine-contents/${userRoutineList[pickString]["memberRoutineData"]["memberRoutineContentList"][i]["memberRoutineContentId"]}/check';
    await http.put(Uri.parse(url));
    onInit();
  }
  deleteWorkout(int i) async{
    int deleteRoutineId = userRoutineList[pickString]["memberRoutineId"];
    if(userRoutineCount==1){
      String url = 'http://15.164.168.230:8080/routines/${deleteRoutineId}';
      await http.delete(Uri.parse(url));
      userRoutineList.remove(pickString);
      userRoutineCount =0;
    }
    else{
      int deleteWorkoutId = userRoutineList[pickString]["memberRoutineData"]["memberRoutineContentList"][i]["memberRoutineContentId"];
      String url = 'http://15.164.168.230:8080/routines/${deleteRoutineId}/routine-content/${deleteWorkoutId}';
      await http.delete(Uri.parse(url));
      userRoutineList[pickString]["memberRoutineData"]["memberRoutineContentList"].removeAt(i);
      userRoutineCount--;
      onInit();
    }    
  }

  getRoutineInfo(int id, String infodate) async{//루틴 상세 조회 후 챌린지 루틴과 일반 루틴 별도로 보관
    var tempRoutine;
    String url = 'http://15.164.168.230:8080/routines/${id}';
    var response = await http.get(Uri.parse(url));
    var responseBody = response.body;
    tempRoutine = jsonDecode(responseBody);
    if(tempRoutine["challengeRoutineId"]==null){
      userRoutineList[infodate] = tempRoutine;
      print("new : ${userRoutineList[infodate]}");
    }else{
      challengeRoutineList[infodate] = tempRoutine;
      print("new c: ${challengeRoutineList[infodate]}");
    }
  }

  setFirst(int setYear, int setMonth) {
    year.value = setYear;
    month.value = setMonth;
    insertDays(year.value, month.value);

  }

  isToday(int year, int month, int day) {
    if (year == DateTime.now().year && month == DateTime.now().month && day == DateTime.now().day) {
      return true;
    }
    return false;
  }

  insertDays(int year, int month) {
    print("Insertdays start");
    days.clear();

    int lastDay = DateTime(year, month + 1, 0).day;
    for (var i = 1; i <= lastDay; i++) {
      days.add({
        "year": year,
        "month": month,
        "day": i,
        "inMonth": true,
        "picked": pickday.year==year && pickday.month==month && pickday.day==i ? true.obs : false.obs,
        "hasRoutine" : userRoutineList["${year}-${month}-${i}"]!=null || challengeRoutineList["${year}-${month}-${i}"]!=null?  true.obs:false.obs,
        "allChecked" : false.obs,
      });
    }

    if (DateTime(year, month, 1).weekday != 7) {
      var temp = [];
      int prevLastDay = DateTime(year, month, 0).day;
      for (var i = DateTime(year, month, 1).weekday - 1; i >= 0; i--) {
        temp.add({
          "year": month-1==0? year-1 : year,
          "month": month - 1==0? 12:month-1,
          "day": prevLastDay - i,
          "inMonth": false,
          "picked": false.obs,
          "hasRoutine": userRoutineList["${month-1==0? year-1 : year}-${month - 1==0? 12:month-1}-${i}"]!=null || challengeRoutineList["${month-1==0? year-1 : year}-${month - 1==0? 12:month-1}-${i}"]!=null?  true.obs:false.obs,
          "allChecked" : false.obs,
        });
      }
      days = [...temp, ...days].obs;
    }
    
    var temp = [];
    for (var i = 1; i <= 42 - days.length; i++) {
      temp.add({
        "year": month+1==13? year+1 : year,
        "month": month+1==13? 1 : month+1,
        "day": i,
        "inMonth": false,
        "picked": false.obs,
        "hasRoutine": userRoutineList["${month+1==13? year+1 : year}-${month+1==13? 1 : month+1}-${i}"]!=null || challengeRoutineList["${month+1==13? year+1 : year}-${month+1==13? 1 : month+1}-${i}"]!=null?  true.obs:false.obs,
        "allChecked" : false.obs,
      });
    }

    days = [...days, ...temp].obs;

    print("insert day finished");
  }
  pickDate(int index){
    for(var day in days){
      day["picked"].value = false;
    };
    days[index]["picked"].value = true;
    pickday = DateTime(days[index]["year"], days[index]["month"], days[index]["day"]);
    pickString = "${days[index]["year"]}-${days[index]["month"]}-${days[index]["day"]}";
    challengeRoutineCount = challengeRoutineList[pickString]!=null? challengeRoutineList[pickString]["memberRoutineData"]["memberRoutineContentList"].length: 0;
    userRoutineCount = userRoutineList[pickString]!=null? userRoutineList[pickString]["memberRoutineData"]["memberRoutineContentList"].length:0;

  }

  dynamic userpagegetfollow(int userid) async {
    var Infos;
    var url = 'http://15.164.168.230:8080/sns/members/$userid/follow-members';
    final response = await http.get(Uri.parse((url)));
    Infos = jsonDecode(response.body);
    return Infos.length;
  }

  dynamic getfollow(int userid,int id) async {
    var Info;
    var url = 'http://15.164.168.230:8080/sns/members/$userid/follow-members';
    final response = await http.get(Uri.parse((url)));
    Info = jsonDecode(response.body);
    int ck=0;
    for(int i=0; i<Info.length; i++){
      if(Info[i] == id){
        ck=1;
        return ck;
      }
    }
  }
   postRequests(var id, var userid) async {
    String url = 'http://15.164.168.230:8080/sns/follow/$userid/$id';
    http.Response _res = await http.post(
      Uri.parse(url), headers: {"content-type": "application/json"},
    );
  }

}