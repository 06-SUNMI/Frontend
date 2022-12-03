import 'package:flutter/material.dart';

Map<String, String> workoutNameTranslated = {
  'BENCH_PRESS_DUMBBELL' : "덤벨 벤치프레스",
  "CHEST_PRESS_MACHINE" : "체스트프레스 머신",
  "PUSH_UP": "푸쉬업",
  "LAT_PULL_DOWN" : "랫풀다운",
  "ONE_ARM_DUMBBELL_ROW" : "덤벨 로우",
  "SEATED_ROW_CABLE" : "시티드로우",
  "SQUAT" : "스쿼트",
  "WIDE_SQUAT" : "와이드 스쿼트",
  "LEG_EXTENSION" : "레그익스텐션",
  "SHOULDER_PRESS_DUMBBELL" : "덤벨 숄더프레스",
  "LATERAL_RAISE_DUMBBELL" : "덤벨 래터럴레이즈",
  "SHOULDER_PRESS_MACHINE" : "숄더프레스 머신",
  "BENCH_DIPS" : "벤치 딥스",
  "TRICEP_PUSH_DOWN_CABLE" : "케이블 푸쉬다운",
  "ONE_ARM_TRICEP_EXTENSION_DUMBBELL" : "덤벨 익스텐션",
  "BICEP_CURL_DUMBBELL" : "덤벨컬",
  "HAMMER_CURL_DUMBBELL" : "덤벨 해머컬",
  "BICEP_CURL_CABLE" : "케이블컬",
  "CRUNCH" : "크런치",
  "PLANK" : "플랭크",
  "LEG_RAISE" : "레그레이즈" ,
  "WRIST_CURL_DUMBBELL" : "덤벨 리스트컬",
  "REVERSE_WRIST_CURL_DUMBBELL" : "덤벨 리버스리스트컬",
  "WRIST_CURL_BARBELL" : "바벨컬",
  "TREADMILL_RUNNING" : "러닝머신",
  "SLOW_BURPEE" : "버피테스트",
  "CRISS_CROSS_JUMP" : "크로스점프",
};

class Workout {
  String workoutName;
  String workoutTarget;
  String? workoutTitle;
  String? imagePath;

  Workout({
    required this.workoutName,
    required this.workoutTarget,
    this.workoutTitle,
    this.imagePath
  });

  factory Workout.fromJson(Map<String, dynamic> json){
    return Workout(
        workoutName: json['workoutName'],
        workoutTarget: json['workoutTarget'],
        workoutTitle: workoutNameTranslated[json['workoutName']],
        imagePath: json['imagePath']
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> workoutJson = Map<String, dynamic>();
    workoutJson['workoutName'] = this.workoutName;
    workoutJson['workoutTarget'] = this.workoutTarget;
    workoutJson['workoutTitle'] = this.workoutTitle;
    return workoutJson;
  }

  isTargetFor(String target){
    if(this.workoutTarget.compareTo(target) == 0) return true;
    return false;
  }
}