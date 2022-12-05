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


class SNSFollowUser extends GetView<CalendarController> {
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
      /*appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                if (controller.month.value == 1) {
                  controller.month(12);
                  controller.year -= 1;
                } else {
                  controller.month -= 1;
                }
                controller.insertDays(controller.year.value, controller.month.value);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.black,
              ),
            ),
            Obx(()=>Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                controller.year.toString() + "." + controller.month.toString(),
                style: TextStyle(fontSize: 20),
              ),
            ),),
            IconButton(
              onPressed: () {
                if (controller.month.value == 12) {
                  controller.month(1);
                  controller.year += 1;
                } else {
                  controller.month += 1;
                }
                controller.insertDays(controller.year.value, controller.month.value);
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        toolbarHeight: 50,

      ),



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
