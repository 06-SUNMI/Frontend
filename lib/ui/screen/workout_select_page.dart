import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:sunmi/controller/workout_controller.dart';
import 'package:sunmi/data/model/workout.dart';
import 'package:sunmi/routes/app_pages.dart';

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
              length: 5,
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
                      Tab(text: 'Example 1'),
                      Tab(text: 'Example 2'),
                      Tab(text: 'Example 3'),
                      Tab(text: 'Example 4'),
                      Tab(text: 'Example 5'),
                    ],
                  ),
                  Expanded(
                    child:TabBarView(
                      children: [
                        createTabPage('Example1'),
                        createTabPage('Example2'),
                        createTabPage('Example3'),
                        createTabPage('Example4'),
                        createTabPage('Example5'),
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

createTabPage(String workoutTarget) {
  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          workoutTarget,
          style: const TextStyle(
            fontSize: 32,
          ),
        ),
        const Divider(
          color: Colors.black,
          thickness: 1.0,
        ),
        for (Workout workout in Get.find<WorkoutController>().workouts)
          if (workout.isTargetFor(workoutTarget)) createRow(workout)
      ],
    ),
  );
}

createRow(Workout workout) {
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
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  workout.workoutName!,
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

class TempPage extends StatelessWidget {
  TempPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Initial Page'),
      ),
      body: Center(
          child: Column(children: [
            const Text("this is initial page"),
            ElevatedButton(
              onPressed: () =>
                  Get.toNamed(Routes.workoutSelect, arguments: {'date': DateTime.now()}),
              child: const Text('go to workout select page'),
            ),
            ElevatedButton(
              onPressed: () =>
                  Get.toNamed(Routes.challenges),
              child: const Text('go to challenge list page'),
            )
          ])),
    );
  }
}
