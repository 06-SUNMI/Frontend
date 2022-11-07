// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import '../../data/model/workout.dart';
import 'Setcount.dart';

class WorkoutSelectPage extends StatefulWidget {
  DateTime date;
  WorkoutSelectPage({Key? key, required this.date}) : super(key: key);

  @override
  _WorkoutSelectPageState createState() => _WorkoutSelectPageState(date);
}

class _WorkoutSelectPageState extends State<WorkoutSelectPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Workout> workouts = List.empty(growable: true);
  DateTime date;
  //String testtext = 'ancesorteset';

  _WorkoutSelectPageState(this.date);

  _loadWorkouts() async {
    String wokroutJson = await rootBundle.loadString('assets/json/wokrouts.json');
    final workoutResponse = json.decode(wokroutJson) as List;
    final List<Workout> workoutsFromJson = workoutResponse.map((i)=>Workout.fromJson(i)).toList();

    setState(() {
      this.workouts.clear();
      this.workouts.addAll(workoutsFromJson);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: DefaultTabController(
            length: 5,
            initialIndex: 0,
            child: Column(
              children: [
                Text (
                  '운동 선택',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'poppin',
                    fontSize: 40
                  ),
                ),
                TabBar(
                  physics: NeverScrollableScrollPhysics(),
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
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      createTabPage(workouts, 'Example1',context, date),
                      createTabPage(workouts, 'Example2',context, date),
                      createTabPage(workouts, 'Example3',context, date),
                      createTabPage(workouts, 'Example4',context, date),
                      createTabPage(workouts, 'Example5',context, date),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(workouts.isEmpty)_loadWorkouts();
  }
}

createTabPage(List<Workout> workouts, String workoutTarget, BuildContext context, DateTime date){
  return Column(
    mainAxisSize: MainAxisSize.max,
    children: [
      Text(
        workoutTarget,
        style:
        const TextStyle(
          fontSize: 32,
        ),
      ),
      const Divider(color: Colors.black,thickness: 1.0,),
      for (Workout workout in workouts)
        if(workout.isTargetFor(workoutTarget)) createRow(workout, context, date)
    ],
  );
}

createRow(Workout workout, BuildContext context, DateTime date){
  return Column(
    children: [
      InkWell(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              workout.imagePath!,
              width: 100,
              height: 100,
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
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Setcount(workout, date))
          );
        },
      ),
      Divider(color: Colors.black, thickness: 1.0,),
    ],
  );
}

