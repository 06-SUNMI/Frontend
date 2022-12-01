import 'dart:core';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            /*Row(
              children: List.generate(1/*storys.length*/, (index) {
                return StoryItem(
                  storyimg: storys[1]['image'],
                  storyname: storys[1]['name'],
                );
              }),

            ),*/
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                      child:CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('images/eh.png'),//임시 이미지
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 15, left: 20),
                      child: Text(
                        userName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 5, left: 20),
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
                Container(
                  padding: const EdgeInsets.only(top: 5, left: 50),
                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[100],
                      minimumSize: const Size(60, 20),
                      //  alignment: const Alignment(150,0),
                      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.0),

                      ),
                    ),
                    child: const Text('팔로우'),
                    onPressed: () => {
                      _postRequests(Get.arguments['id']),
                    }
                  ),
                ),
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
        ),),
    );
  }
}

void _postRequests(var id) async {
    String url = 'http://15.164.168.230:8080/members/$id/1'; //임시
    http.Response _res = await http.post(
        Uri.parse(url), headers: {"content-type": "application/json"},
    );
    print(_res.request);
}