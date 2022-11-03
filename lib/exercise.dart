import 'package:flutter/material.dart';

class Exercise {
  String exerciseType;
  String exerciseTarget;
  String? imagePath;

  Exercise({
    required this.exerciseType,
    required this.exerciseTarget,
    this.imagePath
  });

  factory Exercise.fromJson(Map<String, dynamic> json){
    return Exercise(
        exerciseType: json['exerciseType'],
        exerciseTarget: json['exerciseTarget'],
        imagePath: json['imagePath']
    );
  }

  isTargetFor(String target){
    if(this.exerciseTarget.compareTo(target) == 0) return true;
    return false;
  }
}