import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:sunmi/controller/workout_controller.dart';
import 'package:sunmi/ui/widget/routine/workout_list_view.dart';

class WorkoutPage extends GetView<WorkoutController> {
  WorkoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Select Page'),
      ),
      body: GetX<WorkoutController>(
        builder: (workoutController) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: DefaultTabController(
              length: workoutController.workoutTargets.length,
              initialIndex: 0,
              child: Column(
                children: [
                  Text(
                    '운동 선택',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontFamily: 'poppin', fontSize: 40),
                  ),
                  TabBar(
                    isScrollable: true,
                    labelColor: Colors.deepPurpleAccent,
                    indicatorColor: Colors.purpleAccent,
                    tabs: [
                      for(String workoutTarget in workoutController.workoutTargets)
                        createWorkoutTab(workoutTarget)
                    ],
                  ),
                  Expanded(
                    child:TabBarView(
                      children: [
                        for(String workoutTarget in workoutController.workoutTargets)
                          createWorkoutListView(workoutTarget)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

createWorkoutTab(String workoutTarget){
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

  return Tab(text: workoutTargetString[workoutTarget]);
}