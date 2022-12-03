import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:sunmi/controller/workout_controller.dart';
import 'package:sunmi/data/model/workout.dart';

createWorkoutListItem(Workout workout) {
  return Column(
    children: [
      InkWell(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              workout.imagePath!,
              width: 75,
              height: 75,
              fit: BoxFit.contain,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  workout.workoutTitle!,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          Get.find<WorkoutController>().gotoRoutineRegister(workout);
        },
      ),
      Divider(
        color: Colors.black,
        thickness: 1.0,
      ),
    ],
  );
}

