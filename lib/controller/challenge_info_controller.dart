import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sunmi/ui/screen/challenge/challenge_inforout.dart';

import '../data/model/workout.dart';
import '../data/repository/workout_repository.dart';


class ChallengeInfoController extends GetxController{

  late final WorkoutRepository workoutRepository;
  final RxList<Workout> _workouts = RxList.empty(growable: true);
  get workouts => this._workouts.value;
  set workouts(value) => this._workouts.value = value;

  final RxList<String> _workoutTargets = RxList.empty(growable: true);
  get workoutTargets => this._workoutTargets.value;
  set workoutTargets(value) => this._workoutTargets.value = value;


  static ChallengeInfoController get to => Get.find();
  var Info;
  late int Id;
  RxList info =[].obs;

  @override
  void onInit(){
  }
  void setId(var value){
    Id=value.challengeId;
    getChallengeInfo();
  }
  getChallengeInfo() async{
    var url = 'http://15.164.168.230:8080/challenges/${Id}';
    final response = await http.get(Uri.parse((url)));
    Info = jsonDecode(response.body);
    for(int i=0; i<Info['challengeRoutineDataList'].length; i++) {
      for (int j = 0; j < Info['challengeRoutineDataList'][i]['challengeRoutineContentDataList'].length; j++) {
        if (j == 0) {
            info.add({
              "name": Info['challengeRoutineDataList'][i]['challengeRoutineContentDataList'][j]['challengeRoutineWorkoutName'],
              "date": (i + 1),
            });

        } else {
          info.add({
            "name": Info['challengeRoutineDataList'][i]['challengeRoutineContentDataList'][j]['challengeRoutineWorkoutName'],
            "date": " ",
          });
        }
      }
    }
  }
  /*int recnt(int cnt){
    return cnt=1;
  }
  int pluscnt(int cnt) {
    return cnt = cnt + 1;
  }*/
}
