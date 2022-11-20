
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunmi/controller/challenge_info_controller.dart';

class ChallengeInfoRoutine extends GetView<ChallengeInfoController>{
  var challenges_data = Get.arguments["challenge"];
  @override
  Widget build(BuildContext context) {
    controller.setId(challenges_data);

    return Obx(()=>DataTable(
      headingRowColor:
      MaterialStateColor.resolveWith((states) => Colors.white),
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text('일 차',style: TextStyle(fontStyle: FontStyle.italic),),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text('루틴', style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],


      rows:
      <DataRow>[

        for(int j=0; j<controller.info.length; j++)...[
        DataRow(
          cells: <DataCell>[
              DataCell(Text(controller.info[j]["date"].toString()),),
              DataCell(Text(controller.info[j]["name"]),),
            ]

        ),],
        ],

    ), );
  }
}