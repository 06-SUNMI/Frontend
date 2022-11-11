import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'workout_list_item.dart';
import 'package:sunmi/data/model/workout.dart';
import 'package:sunmi/controller/workout_controller.dart';

createWorkoutListView(String workoutTarget) {
  Map<String, String> workoutTargetString = {
    'chest': '가슴',
    'back': '등',
    'lowerBody': '다리',
    'shoulder': '어깨',
    'triceps': '삼두근',
    'biceps': '이두근',
    'core': '코어',
    'forearm': '전완근',
    'aerobic': '유산소'
  };

  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          workoutTargetString[workoutTarget]!,
          style: const TextStyle(
            fontSize: 32,
          ),
        ),
        const Divider(
          color: Colors.black,
          thickness: 1.0,
        ),
        for (Workout workout in Get.find<WorkoutController>().workouts)
          if (workout.isTargetFor(workoutTarget)) createWorkoutListItem(workout)
      ],
    ),
  );
}