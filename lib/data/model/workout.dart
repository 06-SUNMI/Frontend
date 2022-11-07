import 'package:flutter/material.dart';

class Workout {
  String workoutName;
  String workoutTarget;
  String? imagePath;

  Workout({
    required this.workoutName,
    required this.workoutTarget,
    this.imagePath
  });

  factory Workout.fromJson(Map<String, dynamic> json){
    return Workout(
        workoutName: json['workoutName'],
        workoutTarget: json['workoutTarget'],
        imagePath: json['imagePath']
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> workoutJson = Map<String, dynamic>();
    workoutJson['workoutName'] = this.workoutName;
    workoutJson['workoutTarget'] = this.workoutTarget;
    return workoutJson;
  }

  isTargetFor(String target){
    if(this.workoutTarget.compareTo(target) == 0) return true;
    return false;
  }
}