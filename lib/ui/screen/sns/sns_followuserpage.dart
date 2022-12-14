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

import '../../../controller/sns_search_controller.dart';
import '../../../controller/user_info_controller.dart';


class SNSFollowUser extends GetView<SNSRoutineController> {
  SNSFollowUser({Key? key}) : super(key: key);

  var userName=Get.arguments["name"];
  var gymName=Get.arguments["gymName"];
  var userimg=Get.arguments["customProfileImageUrl"];
  var Id=Get.arguments["id"];

//  int userId = ;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => UserInfoController());
    Get.lazyPut(()=>SearchController());

    int? userId=Get.find<UserInfoController>().userId;
    controller.onInit();
    controller.getfollow(userId!,Id);
    var ck;
    return Scaffold(
      appBar: AppBar(
        title: Text("์ ์  ์กฐํ"),

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
                        backgroundImage: NetworkImage(userimg.toString()),
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
                            "ํ๋ก์",
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
                           "ํ๋ก์",
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

                if(controller.ck==0)...[
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
                        child: const Text('ํ๋ก์ฐ'),
                        onPressed: () =>
                        {
                          controller.postRequests(Id,Get.find<UserInfoController>()!.userId),
                        }
                    ),
                  ),
                ],
              ],
            ),
            Container(//์์ผ ํ์
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
            SizedBox(//๋ฌ๋ ฅ ๋ ์ง ํ์
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
            
            Container(// ์ผ๋ฐ ๋ฃจํด ํ์
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
                        leading: controller.userRoutineList[controller.pickString]["memberRoutineData"]["memberRoutineContentList"][i]["memberRoutineIsChecked"]==true ? Icon(Icons.check_box) :  Icon(Icons.check_box_outline_blank),
                        title: Text(workoutNameTranslated[controller.userRoutineList[controller.pickString]["memberRoutineData"]["memberRoutineContentList"][i]["memberRoutineWorkoutName"]].toString()),
                      ),
                  ],
                ),
              ),
            ),
            Container(//์ฑ๋ฆฐ์ง ๋ฃจํด ํ์
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
                      ),
                  ],
                ),
              ),
            ),

          ],
        )
      ),),
    );
  }

}

