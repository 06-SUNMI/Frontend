import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunmi/routes/tab_page.dart';

class ChallengeDatePage extends StatefulWidget {
  const ChallengeDatePage({super.key});

  @override
  State<ChallengeDatePage> createState() => _ChallengeDatePageState();
}

class _ChallengeDatePageState extends State<ChallengeDatePage> {
  var days_copy = days;
  List challengeDays = [];
  @override
  Widget build(BuildContext context) {
    insertDays(challengeYear, challengeMonth);
    return Scaffold(
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 80.0)),
          Container(
            width: 350,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for(int i = 0; i<week.length;i++)
                  Container(
                    width: 30,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: TextButton(onPressed: (){},child: Text(week[i], style: TextStyle(color: Colors.black),),),
                  ),
              ],
            ),
          ),
          SizedBox(
            width: 350,
            child: Wrap(
              children: [
                for(int i=0;i<days_copy.length;i++)
                  Container(
                    width: 30,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: Center(
                      child: TextButton(onPressed: (){
                        if(days_copy[i]["selected"]==false){
                          challengeDays.add(DateTime(challengeYear, challengeMonth, days[i]["day"],),);

                        }
                        else{
                          challengeDays.remove(DateTime(challengeYear, challengeMonth, days[i]["day"],),);
                        }
                        days_copy[i]["selected"] = !days_copy[i]["selected"];
                        setState(() {
                        });
                        print(challengeDays.length);
                        },child: Text(days_copy[i]["day"].toString(),style: TextStyle(fontSize: 12, color: Colors.black),),style:days_copy[i]["selected"]==false?TextButton.styleFrom(backgroundColor: Colors.transparent): TextButton.styleFrom(backgroundColor: Colors.pink),)//(days[i]["day"].toString(), style: TextStyle(fontSize: 17),),
                    ),
                  )
              ],
            ),
          ),
          ElevatedButton(
            onPressed: (){
              print("confirm cliked");
            }, child: Text("Confirm"),
          ),
        ],
      ),
    );
  }
}





var week = ['일', '월', '화', '수', '목', '금', '토'];
DateTime now = DateTime.now();
int challengeYear = DateTime.now().year;
int challengeMonth = DateTime.now().month;
List days = [];

int lastDay = DateTime(DateTime.now().year, DateTime.now().month+1, 0).day;

insertDays(int year, int month){
  days.clear();

  int lastDay = DateTime(year, month+1, 0).day;
  for(int i=1;i<=lastDay;i++){
    days.add({
      "day" : i,
      "selected" : false,
    });
  }

  if(DateTime(year, month, 1).weekday !=7){
    var temp = [];
    int preLastDay = DateTime(year, month, 0).day;
    for(int i= DateTime(year, month, 1).weekday-1;i>=0;i--){
      temp.add({
        "day" : preLastDay - i,
        "selected" : false,
      });
    }
    days = [...temp, ...days];
  }
  var temp = [];
  for (int i = 1; i <= 42 - days.length; i++) {
      temp.add({
        "day" : i,
        "selected": false,
      });
  }

  days = [...days, ...temp];
}