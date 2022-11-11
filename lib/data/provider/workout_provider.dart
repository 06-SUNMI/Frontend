import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sunmi/data/model/workout.dart';
import 'package:get/get.dart';

String _baseURL = 'http://15.164.168.230:8080';

class WorkoutProvider extends GetConnect{

  Future<Response> getWorkouts() => get(_baseURL + '/workout-data');

  getByHttp() async{
    var jsonData = await getWorkouts();
    final workoutResponse =  json.decode(jsonData.body!);
  }

  getAll() async{

  }

  getAllByJson() async {
    String workoutJson = await rootBundle.loadString('assets/json/workouts.json');
    final workoutResponse = json.decode(workoutJson) as List;
    final List<Workout> workoutsFromJson = workoutResponse.map((workout) => Workout.fromJson(workout)).toList();
    return workoutsFromJson;
  }
}

