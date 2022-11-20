import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunmi/controller/calendar_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RoutineCalendar extends GetView<CalendarController> {

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
            IconButton(
              onPressed: () {
               controller.onInit();
              },
              icon: Icon(
                Icons.refresh,
                size: 20,
                color: Colors.blue,
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
        child: Column(
          children: [
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
                          color: controller.isToday(controller.days[i]["year"], controller.days[i]["month"], controller.days[i]["day"]) ? Colors.blueGrey : null,
                          border: controller.days[i]["picked"].value ? Border.all(width: 2, color: Colors.blueGrey) : null,
                        ),
                        child: Center(
                          child: Text(
                            controller.days[i]["day"].toString(),
                            style: TextStyle(
                              color: controller.isToday(controller.days[i]["year"], controller.days[i]["month"], controller.days[i]["day"])
                                  ? Colors.white
                                  : controller.days[i]["inMonth"]
                                      ? Colors.black
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
                        Obx(()=>ListTile(
                          leading: controller.routineDay[i]["isChecked"]==true ? Icon(Icons.check_box) :  Icon(Icons.check_box_outline_blank),
                          title: Text(controller.routineDay[i]["workoutName"].toString()),
                          onTap: () {
                            
                            controller.pickWorkout(i);
                          },
                          onLongPress: () {
                            showDialog(context: context, builder: (BuildContext context){
                              return AlertDialog(
                                
                                actions: [
                                  TextButton(onPressed: (){
                                    print("수정 clicked");
                                  }, child: Text("수정")),
                                  TextButton(onPressed: (){
                                    controller.deleteWorkout(i, controller.dayTemp);////
                                  }, child: Text("삭제")),
                                ],
                              );
                            });
                          },
                        ),),

                      TextButton(
                        onPressed: (){
                          Get.toNamed('/workouts_select_page', arguments: {'date': controller.pick});
                        }, 
                        child: Icon(Icons.add), 
                        style: TextButton.styleFrom(
                          //shape: CircleBorder(), 
                          side: BorderSide(
                            color: Color.fromRGBO(147,125,194,1),
                            width: 2.0,
                          ),
                          minimumSize: Size(80, 50),
                        ),
                       ),
                    ],
                  ),),
                ),
        ],
      ),),
    );
  }
}