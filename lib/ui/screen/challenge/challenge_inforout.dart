
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunmi/controller/challenge_info_controller.dart';

import 'package:sunmi/data/model/workout.dart';

class ChallengeInfoRoutine extends GetView<ChallengeInfoController> {
  var challenges_data = Get.arguments["challenge"];

  @override
  Widget build(BuildContext context) {
    controller.setId(challenges_data);
    var cnt = 1;
    return Scaffold(
      appBar: AppBar(title: Text("Challenge Rotine")),
      body: Container(
        width: double.infinity,
        child: Obx(() =>
            DataTable(
              headingRowColor:
              MaterialStateColor.resolveWith((states) => Colors.lightBlueAccent),
              columns: const <DataColumn>[
                DataColumn(
                  label: Expanded(
                      child: Text('일 차', style: TextStyle(fontStyle: FontStyle.italic),),
                      flex:1
                  ),
                ),
                DataColumn(
                  label: Expanded(
                      child: Text('루틴', style: TextStyle(fontStyle: FontStyle.italic),),
                      flex:2
                  ),
                ),
              ],


              rows:

              <DataRow>[
                for(int j = 0; j < controller.info.length; j++)...[
                  DataRow(
                      color: MaterialStateColor.resolveWith((states) =>
                      Colors.white),
                      cells: <DataCell>[
                        DataCell(Text(controller.info[j]["date"].toString(),)),
                        DataCell(Text(workoutNameTranslated[controller.info[j]["name"]].toString(),))
                      ]
                  ),
                ],
              ],

            ),

        ),
      )

    );
  }

}
