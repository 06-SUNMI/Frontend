import 'dart:convert';
import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sunmi/data/storys.dart';
import 'package:sunmi/ui/widget/sns/sns_storyitem.dart';
import 'package:sunmi/controller/calendar_controller.dart';
import 'package:sunmi/routes/app_pages.dart';
import 'package:sunmi/ui/screen/sns/sns_searchscreen.dart';
import 'package:sunmi/controller/sns_user_routine_info_controller.dart';
import 'package:sunmi/data/model/workout.dart';


class SNSFollowUser extends GetView<SNSRoutineController> {
  SNSFollowUser({Key? key}) : super(key: key);

  var userName=Get.arguments["name"];
  var gymName=Get.arguments["gymName"];
  var userimg=Get.arguments["customProfileImageUrl"];

  @override
  Widget build(BuildContext context) {
    /*int? userid=controller.userId;
    Future<bool> checkinuser = getfollow(userid!);

    if(userimg=='null'){
      userimg='assets/images/eh.png';//임시 이미지
    }
*/
    return Scaffold(
      appBar: AppBar(
        title: Text("유저 조회"),

      ),
      body: Obx(()=>SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.0,width: 200.0,),
            Row(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                      child:CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage("assets/images/eh.png"),//임시 이미지
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 10,left: 20),
                          child: Text(
                            userName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 15, left: 10),
                          child: Text(
                            gymName,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: Colors.black),
                          ),
                        ),
                      ],

                    ),

                    Row(
                     children: [
                        TextButton(
                         // padding: const EdgeInsets.only(bottom: 5, left: 20),
                          onPressed: () {  },
                          child: Text(
                            "팔로워",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: Colors.black),
                          ),
                        ),
                       TextButton(
                         // padding: const EdgeInsets.only(bottom: 5, left: 20),
                         onPressed: () {  },
                         child: Text(
                           "팔로잉",
                           style: TextStyle(
                               fontWeight: FontWeight.normal,
                               fontSize: 12,
                               color: Colors.black),
                         ),
                       ),
                      ]
                    ),

                  ],
                ),
                Container(
                    padding: const EdgeInsets.only(left: 50, bottom: 5),
                    child: ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple[100],
                          minimumSize: const Size(60, 20),
                          //  alignment: const Alignment(150,0),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0),

                          ),
                        ),
                        child: const Text('팔로우'),
                        onPressed: () =>
                        {
                          
                        }
                    ),
                  ),
                
              ],
            ),
            Container(//요일 표시
              width: 350,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < controller.week.length; i++)
                    Container(
                      width: 30,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        controller.week[i],
                        style: TextStyle(
                          color: i == 0 ? Colors.red : i == controller.week.length - 1 ? Colors.blue : Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(//달력 날짜 표시
              width: 350,
              child: Wrap(
                children: [
                  for (var i = 0; i < controller.days.length; i++)
                  InkWell(
                    onTap: () => controller.pickDate(i),
                    child : Container(     
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      width: 40,
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: controller.days[i]["hasRoutine"] == true? Colors.blueGrey: null,
                        border: controller.days[i]["picked"].value ? Border.all(width: 2, color: Colors.red) : null,
                      ),
                      child: Center(
                        child: Text(
                          controller.days[i]["day"].toString(),
                          style: TextStyle(
                            fontWeight: controller.isToday(controller.days[i]["year"], controller.days[i]["month"], controller.days[i]["day"]) ? FontWeight.bold : null,
                            color: controller.isToday(controller.days[i]["year"], controller.days[i]["month"], controller.days[i]["day"])
                                ? Colors.black
                                : controller.days[i]["inMonth"]
                                    ? Color.fromARGB(210, 0, 0, 0)
                                    : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    ),
                ],
              ),
            ),
            
            Container(// 일반 루틴 표시
              margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for(int i=0;i<controller.getUserRoutineCount();i++)
                      ListTile(
                        onTap: () {
                            controller.pickUserWorkout(i);
                            //Get.toNamed(Routes.addInfo);
                            //Get.toNamed(Routes.initial);
                        },
                        leading: controller.userRoutineList[controller.pickString]["memberRoutineData"]["memberRoutineContentList"][i]["memberRoutineIsChecked"]==true ? Icon(Icons.check_box) :  Icon(Icons.check_box_outline_blank),
                        title: Text(workoutNameTranslated[controller.userRoutineList[controller.pickString]["memberRoutineData"]["memberRoutineContentList"][i]["memberRoutineWorkoutName"]].toString()),
                        onLongPress: () {
                            showDialog(context: context, builder: (BuildContext context){
                              return AlertDialog(
                                actions: [
                                  TextButton(onPressed: (){
                                    Get.back(); 
                                    showDialog(context: context, builder: (BuildContext context){
                                      return AlertDialog(
                                        title: Text("EDIT WORKOUT"),
                                        
                                        actions: [
                                          TextButton(onPressed: (){
                                            print("수정");
                                            //controller.editWorkout(i, controller.dayTemp);
                                            Get.back();
                                          }, child: Text("확인")),
                                        ],
                                      );
                                    });
                                    print("수정 clicked");
                                  }, child: Text("수정")),
                                  TextButton(onPressed: (){
                                    controller.deleteWorkout(i);
                                    //controller.onInit();
                                    Get.back();
                                  }, child: Text("삭제")),
                                ],
                              );
                            });
                          },
                      ),
                  ],
                ),
              ),
            ),
            Container(//챌린지 루틴 표시
              margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for(int i=0;i<controller.getChallengeRoutineCount();i++)
                      ListTile(
                        leading: controller.challengeRoutineList[controller.pickString]["memberRoutineData"]["memberRoutineContentList"][i]["memberRoutineIsChecked"]==true ? Icon(Icons.check_box) :  Icon(Icons.check_box_outline_blank),
                        title: Text(workoutNameTranslated[controller.challengeRoutineList[controller.pickString]["memberRoutineData"]["memberRoutineContentList"][i]["memberRoutineWorkoutName"]].toString()),
                        onTap: () {
                          controller.pickChallengeWorkout(i);
                          //Get.toNamed(Routes.addInfo);
                          //Get.toNamed(Routes.initial);
                        },
                        onLongPress: (){
                          showDialog(context: context, builder: (BuildContext context){
                              return AlertDialog(
                                content: Text("챌린지 루틴은 수정 및 삭제가 불가능합니다."),
                                actions: [
                                  TextButton(onPressed: (){
                                    Get.back();
                                  }, child: Text("확인")),
                                ],
                              );
                            });
                        },
                      ),
                  ],
                ),
              ),
            ),

          ],
        )
      ),),


/*
      body:  SingleChildScrollView(
        physics: BouncingScrollPhysics(),

        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0,width: 200.0,),
            Row(
              children: [
                Container(
                 // padding: EdgeInsets.only(top: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),

                      child:CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('$userimg'),//임시 이미지
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 10,left: 20),
                          child: Text(
                            userName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 15, left: 10),
                          child: Text(
                            gymName,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: Colors.black),
                          ),
                        ),
                      ],

                    ),

                    Row(
                     children: [
                        TextButton(
                         // padding: const EdgeInsets.only(bottom: 5, left: 20),
                          onPressed: () {  },
                          child: Text(
                            "팔로워",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: Colors.black),
                          ),
                        ),
                       TextButton(
                         // padding: const EdgeInsets.only(bottom: 5, left: 20),
                         onPressed: () {  },
                         child: Text(
                           "팔로잉",
                           style: TextStyle(
                               fontWeight: FontWeight.normal,
                               fontSize: 12,
                               color: Colors.black),
                         ),
                       ),
                      ]
                    ),

                  ],
                ),
                if(Get.arguments['id']!=userid || checkinuser==false)...[
                  Container(
                    padding: const EdgeInsets.only(left: 50, bottom: 5),
                    child: ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple[100],
                          minimumSize: const Size(60, 20),
                          //  alignment: const Alignment(150,0),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0),

                          ),
                        ),
                        child: const Text('팔로우'),
                        onPressed: () =>
                        {
                          _postRequests(Get.arguments['id'], userid!),
                        }
                    ),
                  ),
                ]
              ],
            ),

            Container(
              width: 350,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < controller.week.length; i++)
                    Container(
                      width: 30,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        controller.week[i],
                        style: TextStyle(
                          color: i == 0
                              ? Colors.red
                              : i == controller.week.length - 1
                              ? Colors.blue
                              : Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: 350,
              child: Wrap(
                children: [
                  for (var i = 0; i < controller.days.length; i++)
                    InkWell(
                      onTap: () => controller.pickDate(i),
                      child : Obx(()=>Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        width: 40,
                        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: controller.days[i]["routineId"] ==0? null: controller.days[i]["allChecked"]==100 ? Color.fromARGB(255, 109, 195, 111) : Color.fromARGB(255, 215, 215, 215),
                          border: controller.days[i]["picked"].value ? Border.all(width: 2, color: Colors.blueGrey) : null,
                        ),
                        child: Center(
                          child: Text(
                            controller.days[i]["day"].toString(),

                            style: TextStyle(
                              fontWeight: controller.isToday(controller.days[i]["year"], controller.days[i]["month"], controller.days[i]["day"]) ? FontWeight.bold : null,
                              color: controller.isToday(controller.days[i]["year"], controller.days[i]["month"], controller.days[i]["day"])
                                  ? Colors.black
                                  : controller.days[i]["inMonth"]
                                  ? Color.fromARGB(210, 0, 0, 0)
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      ),),
                ],
              ),
            ),

            SizedBox(

              child: Obx(()=>Column(

                children: [

                  for(int i=0;i<controller.routineDay.length;i++)

                    ListTile(

                      leading: controller.routineDay[i]["isChecked"]==true ? Icon(Icons.check_box) :  Icon(Icons.check_box_outline_blank),
                      title: Text(controller.routineDay[i]["workoutName"].toString()),
                      contentPadding: EdgeInsets.all(25),

                    ),


                    ],
              ),),
            ),
          ],
        ),),*/
    );
  }

}
Future<bool> getfollow(int userid) async {
  var Info;
  var url = 'http://15.164.168.230:8080/sns/members/$userid/follow-members';
  final response = await http.get(Uri.parse((url)));
  Info = jsonDecode(response.body);
  for(int i=0; i<Info.length; i++){
    if(Info[i] == userid){
      print("안받아짐");
      return false;
    }
  }
  return true;
}
void _postRequests(var id, int userid) async {
    String url = 'http://15.164.168.230:8080/sns/follow/$id/$userid';
    http.Response _res = await http.post(
        Uri.parse(url), headers: {"content-type": "application/json"},
    );
}
