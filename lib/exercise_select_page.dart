// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import './exercise.dart';

import './Setcount.dart';

class ExerciseSelectPage extends StatefulWidget {
  DateTime date;
  ExerciseSelectPage({Key? key, required this.date}) : super(key: key);

  @override
  _ExerciseSelectPageState createState() => _ExerciseSelectPageState(date);
}

class _ExerciseSelectPageState extends State<ExerciseSelectPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Exercise> exercises = List.empty(growable: true);
  DateTime date;

  _ExerciseSelectPageState(this.date);

  _loadExercises() async {
    String jsonString = await rootBundle.loadString('assets/json/exercises.json');
    final jsonResponse = json.decode(jsonString) as List;
    final List<Exercise> exercisesFromJson = jsonResponse.map((i)=>Exercise.fromJson(i)).toList();

    setState(() {
      this.exercises.clear();
      this.exercises.addAll(exercisesFromJson);
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
                    children: [
                      createTabPage(exercises, 'Example1',context, date),
                      createTabPage(exercises, 'Example2',context, date),
                      createTabPage(exercises, 'Example3',context, date),
                      createTabPage(exercises, 'Example4',context, date),
                      createTabPage(exercises, 'Example5',context, date),
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
    if(exercises.isEmpty)_loadExercises();
  }
}

createTabPage(List<Exercise> exercises, String target, BuildContext context, DateTime date){
  return Column(
    mainAxisSize: MainAxisSize.max,
    children: [
      Text(
        target,
        style:
        const TextStyle(
          fontSize: 32,
        ),
      ),
      const Divider(color: Colors.black,thickness: 1.0,),
      for (Exercise exercise in exercises)
        if(exercise.isTargetFor(target)) createRow(exercise, context, date)
    ],
  );
}

createRow(Exercise exercise, BuildContext context, DateTime date){
  return Column(
    children: [
      InkWell(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              exercise.imagePath!,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  exercise.exerciseType!,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ],
        ),
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Setcount(exercise, date))
          );
        },
      ),
      Divider(color: Colors.black, thickness: 1.0,),
    ],
  );
}


