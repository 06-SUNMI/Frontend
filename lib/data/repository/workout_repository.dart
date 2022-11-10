import 'package:flutter/cupertino.dart';
import 'package:sunmi/data/provider/workout_provider.dart';

class WorkoutRepository {
  final WorkoutProvider workoutProvider;

  WorkoutRepository({required this.workoutProvider});

  getAll(){
    return workoutProvider.getAllByJson();
  }

  getByHttp(){
    return workoutProvider.getByHttp();
  }
}