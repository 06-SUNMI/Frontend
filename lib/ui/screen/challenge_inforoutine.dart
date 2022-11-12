import 'package:flutter/material.dart';
import 'package:sunmi/main.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ChallengeRoutine extends StatelessWidget{
  // late Sdays selectdays;

  String _selectcays = "3";

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('challenge routine'),
      ),
      body: Container(
              child: Text("루틴 정보 페이지"),
      ),
    );
  }
}