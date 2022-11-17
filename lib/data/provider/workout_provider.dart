import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sunmi/data/model/workout.dart';
import 'package:get/get.dart';

import 'url.dart' as url;

class WorkoutProvider extends GetConnect{

  Future<Response> getWorkouts() => get(url.baseURL + '/workout-data');

  getByHttp() async{
    var jsonData = await getWorkouts();
    final workoutResponse =  json.decode(jsonData.body!);
  }

  getAll() async{

  }

  getAllByJson() async {
    String workoutJson = await rootBundle.loadString('assets/json/workouts.json');
    final workoutResponse = json.decode(workoutJson) as List;
    print(workoutResponse);
    final List<Workout> workoutsFromJson = workoutResponse.map((workout) => Workout.fromJson(workout)).toList();
    return workoutsFromJson;
  }

  getTargetsByJson() async {
    String targetJson = await rootBundle.loadString('assets/json/targets.json');
    final targetResponse = json.decode(targetJson) as List;
    final List<String> targetsFromJson = List<String>.from(targetResponse);
    return targetsFromJson;
  }
}

