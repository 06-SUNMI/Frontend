import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'challenge_infomation.dart';

class ChallengeRoutine extends StatefulWidget {
  const ChallengeRoutine({super.key});

  @override
  State<ChallengeRoutine> createState() => _ChallengeRoutine();
}

class _ChallengeRoutine extends State<ChallengeRoutine> {
 // static const int numPerWeek = ;
  static const int numItems = 20;
  int daycount=12;
  //List<bool> selected = List<bool>.generate(numItems, (int index) => false);

  @override
  Widget build(BuildContext context) {
    return DataTable(
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
       // while(daycount<=12)...[
         <DataRow>[
           for(int i=1;i<=daycount;i++)
            DataRow(
              cells: <DataCell>[
                DataCell(Text('$i')),
                DataCell(Text('루틴정보')),
          //      daycount++,
              ],
            ),
        ],
      //],
    );
  }
}

