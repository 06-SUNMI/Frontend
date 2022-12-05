import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunmi/controller/calendar_controller.dart';
import 'package:sunmi/routes/app_pages.dart';
import 'package:sunmi/data/model/workout.dart';


class RoutineCalendar extends GetView<CalendarController>{
  Widget build(BuildContext context){ 
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("루틴 페이지"),
      ),
      body: Obx(()=>SingleChildScrollView(
        child: Column(
          children: [
            Row(//캘린더 년월
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(controller.year.toString()+"."+controller.month.toString(), style: TextStyle(fontSize: 25.0),),
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
            TextButton(//운동 추가 버튼
              onPressed: (){
                if(controller.getUserRoutineCount()==0){
                  Get.toNamed(Routes.workoutSelect, arguments: {'date' : controller.pickday, 'add' : 0});
                }
                else{
                  Get.toNamed(Routes.workoutSelect, arguments: {'date' : controller.pickday, 'add' : controller.userRoutineList[controller.pickString]["memberRoutineId"]});
                }
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
        ),
      ),
    ),);
  }
}
/*
class RoutineCalendar extends GetView<CalendarController> {

  Widget build(BuildContext context) {
    Get.put(UserInfoController());
    return GetBuilder<UserInfoController>( 
                  builder: (userController) {
                    controller.setId(userController.userId);
                    return Scaffold(
        appBar: AppBar(
        title: Obx(()=>Text(
                controller.year.toString() + "." + controller.month.toString(),
                style: TextStyle(fontSize: 20),
              ),),
        actions: [
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
              Obx(()=>
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
              ),),
              
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
                                    Get.back(); 
                                    showDialog(context: context, builder: (BuildContext context){
                                      return AlertDialog(
                                        title: Text("EDIT WORKOUT"),
                                        
                                        actions: [
                                          TextButton(onPressed: (){
                                            print("수정");
                                            controller.editWorkout(i, controller.dayTemp);
                                            Get.back();
                                          }, child: Text("확인")),
                                        ],
                                      );
                                    });
                                    print("수정 clicked");
                                  }, child: Text("수정")),
                                  TextButton(onPressed: (){
                                    controller.deleteWorkout(i, controller.dayTemp);
                                    controller.onInit();
                                    Get.back();
                                  }, child: Text("삭제")),
                                ],
                              );
                            });
                          },
                        ),),

                      TextButton(
                        onPressed: (){
                          if(controller.routineDay.length==0){
                            Get.toNamed(Routes.workoutSelect, arguments: {'date' : controller.pick, 'add' : 0});
                            print("post");
                          }
                          else{
                            Get.toNamed(Routes.workoutSelect, arguments: {'date' : controller.pick, 'add' : controller.pickDateRoutineId});
                            print(controller.pickDateRoutineId);
                          }
                          //Get.toNamed('/workouts_select_page', arguments: {'date': controller.pick});
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
                  },);
  }
}
*/