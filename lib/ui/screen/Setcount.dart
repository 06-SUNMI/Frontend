import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Exercisesetcount.dart';
import '/data/model/workout.dart';
import 'package:get/get.dart';
import 'package:sunmi/controller/workout_controller.dart';
import 'package:http/http.dart' as http;
import 'package:sunmi/routes/app_pages.dart';
import 'package:sunmi/ui/screen/routine_calendar.dart';
import 'dart:convert';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class Setcount extends StatelessWidget {
  Workout exercise;
  DateTime date;

  Setcount(this.exercise, this.date);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '에브리 헬스',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: SetPage(),
    );
  }
}

class SetPage extends StatefulWidget {
  SetPage({Key? key}) : super(key: key);

  @override
  _SetPageState createState() => _SetPageState();



}

enum Counter {sets, timer}

class _SetPageState extends State<SetPage> {
  Counter _c = Counter.sets;
  TextEditingController tea = TextEditingController();
  TextEditingController teb = TextEditingController();
  TextEditingController tec = TextEditingController();

  late Workout exercise;
  late DateTime date;

  late Exercise_setcount exercisesetcount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('운동 세트/시간 선택'),),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ListTile(
              title: Text('운동 횟수 선택'),
              leading: Radio(
                value: Counter.sets,
                groupValue: _c,
                onChanged: (value) {
                  setState(() {
                    _c = value!;
                  });
                },

              ),
            ),

            if ( _c == Counter.sets) ...[
              TextFormField(
                controller: tea,
                maxLength: 10,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  // labelText: '     운동세트를 입력해 주세요',
                  labelText: '    세트를 입력해 주세요  ',
                  hintText: '  -  세트  ',
                ),
              ),
              //     Text('set'),
              TextFormField(
                controller: teb,
                //  exercisecount : tec.text, /******************/
                //Exercise_setcount.exercisecount = tec.text,
                maxLength: 10,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  FilteringTextInputFormatter.deny(' ')
                ],
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  labelText: '     운동횟수를 입력해 주세요',
                  hintText: '  -  회  ',
                ),
              ),

            ],
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Text('운동 시간 선택'),
              leading: Radio(
                value: Counter.timer,
                groupValue: _c,
                onChanged: (value) {
                  setState(() {
                    _c = value!;
                  });
                },

              ),
            ),
            if ( _c == Counter.timer) ...[
              TextFormField(
                  controller: tec,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  ],
                  decoration: InputDecoration(
                    // icon: Icon(Icons.check),
                    border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    labelText: '     운동시간을 입력해 주세요',
                    hintText: '  -  분  ',

                  )
              ),
            ],

            ElevatedButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 15),
              ),
              child: const Text("확인"),
              onPressed: () {
                if (_c == Counter.sets) {
                  _postRequests(tea.text,teb.text);
                  showDialog(
                    context: context,
                    barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                    builder: (BuildContext context) {
                      return AlertDialog(
                        // content: const ScreenVideoTips(),
                        content: new Text(tea.text + " 세트" + "   " + teb.text +
                            " 회"),
                        insetPadding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
                        actions: [
                          TextButton(
                            child: const Text('확인'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Get.to(() => RoutinePage());
                            },
                          ),
                        ],
                      );
                    },
                  );
   //               _postRequest();
                } else {
                  _postRequestt(tec.text);
                  showDialog(
                    context: context,
                    barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                    builder: (BuildContext context) {
                      return AlertDialog(
                        // content: const ScreenVideoTips(),
                        content: new Text(tec.text + " 분"),
                        insetPadding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
                        actions: [
                          TextButton(
                            child: const Text('확인'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Get.to(() => RoutinePage());
                            },
                          ),
                        ],
                      );
                    },
                  );

                }
              },

            ),

          ],
        ),
      ),
    );
  }
}
void _postRequests(String tea, String teb) async{
  String url = 'http://15.164.168.230:8080/members/1/routines';
  var data = {
    "memberRoutineWorkoutContentList": [
      {
        "memberRoutineWorkoutName": "PUSH_UP",
        "memberRoutineWorkoutWeight": null,
        "memberRoutineWorkoutCount": tea,
        "memberRoutineWorkoutSet": teb,
        "memberRoutineWorkoutTime": null
      }
    ],
    "routineRegisterdate": "2022-11-10"
  };
  var body = jsonEncode(data);
  http.Response _res = await http.post(Uri.parse(url), headers: {"content-type": "application/json"}, body: body);

  print('post : ${_res.body}');
}

void _postRequestt(String tec) async{
  String url = 'http://15.164.168.230:8080/members/1/routines';
  var data = {
    "memberRoutineWorkoutContentList": [
      {
        "memberRoutineWorkoutName": "PUSH_UP",
        "memberRoutineWorkoutWeight": null,
        "memberRoutineWorkoutCount": null,
        "memberRoutineWorkoutSet": null,
        "memberRoutineWorkoutTime": tec
      }
    ],
    "routineRegisterdate": "2022-11-10"
  };
  var body = jsonEncode(data);
  http.Response _res = await http.post(Uri.parse(url), headers: {"content-type": "application/json"}, body: body);

  print('post : ${_res.body}');
}