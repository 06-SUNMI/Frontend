import 'package:flutter/material.dart';

class ChallendgeCalendar{
  var week = ['일', '월', '화', '수', '목', '금', '토'];
  DateTime now = DateTime.now();
  DateTime startDay;
  DateTime endDay;
  List days = [];
  ChallendgeCalendar(this.startDay, this.endDay);

  int getDateDiff(){
    return endDay.difference(startDay).inDays;
  }
  insertDays(){
    days.clear();

    for(int i=0;i<getDateDiff()+1;i++){
      days.add({
        "day" : DateTime(startDay.year, startDay.month, startDay.day+i).day,
        "selected" : false,
        "inChallenge" : true,
      });
    }
    if(startDay.weekday !=7){
      var temp = [];
      for(int i=1;i<(7-startDay.weekday)+1;i++){
        temp.add({
          "day" : DateTime(startDay.year, startDay.month, startDay.day-i).day,
          "selected" : false,
          "inChallenge" : false,
        });
      }
      days = [...temp, ...days];
    }
    if(endDay.weekday !=6){
      var temp = [];
      if(endDay.weekday==7){
        for(int i=1;i<7;i++){
          temp.add({
            "day" : DateTime(endDay.year, endDay.month, endDay.day+i).day,
            "selected" : false,
            "inChallenge" : false,
          });
        }
      }else{
        for(int i=1;i<(6-endDay.weekday)+1;i++){
          temp.add({
            "day" : DateTime(endDay.year, endDay.month, endDay.day+i).day,
            "selected" : false,
            "inChallenge" : false,
          });
        }
      }
      days = [...days, ...temp];
    }
  }//insertDays
  
}
/*
var week = ['일', '월', '화', '수', '목', '금', '토'];
DateTime now = DateTime.now();
int challengeYear = DateTime.now().year;
int challengeMonth = DateTime.now().month;
List days = [];

int lastDay = DateTime(DateTime.now().year, DateTime.now().month+1, 0).day;

insertDays(int year, int month){
  days.clear();

  int lastDay = DateTime(year, month+1, 0).day;
  for(int i=1;i<=lastDay;i++){
    days.add({
      "day" : i,
      "selected" : false,
    });
  }

  if(DateTime(year, month, 1).weekday !=7){
    var temp = [];
    int preLastDay = DateTime(year, month, 0).day;
    for(int i= DateTime(year, month, 1).weekday-1;i>=0;i--){
      temp.add({
        "day" : preLastDay - i,
        "selected" : false,
      });
    }
    days = [...temp, ...days];
  }
  var temp = [];
  for (int i = 1; i <= 42 - days.length; i++) {
      temp.add({
        "day" : i,
        "selected": false,
      });
  }

  days = [...days, ...temp];
}
*/