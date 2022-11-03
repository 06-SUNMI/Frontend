import 'package:flutter/material.dart';
import './exercise_select_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime date =  checkTime();
    return MaterialApp(
      title: 'Every Health',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(255, 230, 247, 1),
      ),
      home: ExerciseSelectPage(date: date),
    );
  }
}

checkTime(){
  DateTime now = DateTime.now();
  return now;
}