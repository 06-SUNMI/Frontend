import 'package:flutter/material.dart';
import './main.dart';
import 'package:flutter/services.dart';
import './Exercisesetcount.dart';
import './exercise.dart';




class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class Setcount extends StatelessWidget {
  Exercise exercise;
  DateTime date;

  //


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

  late Exercise exercise;
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
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]')),],
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
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  FilteringTextInputFormatter.deny(' ')],
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
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]')),],
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
                if(_c ==Counter.sets){
                showDialog(
                context: context,
                barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                builder: (BuildContext context) {
                return AlertDialog(
                  // content: const ScreenVideoTips(),
                  content: new Text(tea.text + " 세트" + "   " + teb.text + " 회"),
                  insetPadding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
                  actions: [
                    TextButton(
                    child: const Text('확인'),
                    onPressed: () {
                    Navigator.of(context).pop();
                    },
                    ),
                  ],
                  );
                  },
                );
                } else{
                  showDialog(
                  context: context,
                  barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                  builder: (BuildContext context) {
                  return AlertDialog(
                  // content: const ScreenVideoTips(),
                    content : new Text(tec.text+" 분"),
                    insetPadding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
                    actions: [
                      TextButton(
                        child: const Text('확인'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ]
                  ,
                  );
                  },
                  );
                }

              /*
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TempPage (exercise, date, exercisesetcount)),
                );*/
                // Respond to button press
              },

            ),
            /*
            SizedBox(
              height: 40,
            ),
            Text(
                '선택 : $_c'
            )
            */
          ],
        ),
      ),
    );
  }
}