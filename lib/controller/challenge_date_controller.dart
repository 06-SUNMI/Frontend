import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChallengeDateController extends GetxController{
  static ChallengeDateController get to => Get.find();
  var week = ["일", "월", "화", "수", "목", "금", "토"];
  static DateTime now = DateTime.now();

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
      for (var i = DateTime(start.year, start.month, start.day).weekday - 1; i >= 0; i--) {
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
      selectDays.remove(DateTime(days[index]["year"], days[index]["month"], days[index]["day"]));
    }
    else{
      days[index]["picked"].value = true;
      selectDays.add(DateTime(days[index]["year"], days[index]["month"], days[index]["day"]));
    }
    
  }
}