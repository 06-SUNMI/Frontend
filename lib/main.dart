import 'package:flutter/material.dart';
import './exercise_select_page.dart';
import 'routine_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Every Health',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(255, 230, 247, 1),
      ),
      home: RoutinePage(),
    );
  }
}