import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunmi/controller/challenge_date_controller.dart';
import 'package:sunmi/routes/homepage.dart';
import 'package:sunmi/routes/app_pages.dart';


class ChallengeDatePage extends GetView<ChallengeDateController>{
  DateTime startDay = Get.arguments["start_date"];
  DateTime endDay = Get.arguments["end_date"];
  int challengeId = Get.arguments["challengeId"];
  
  late int dateDuration = endDay.difference(startDay).inDays;
  @override
  Widget build(BuildContext context) {
    controller.setFirst(startDay, endDay);
    controller.setId(challengeId);
    return Scaffold(
      appBar: AppBar(
        title: Text("챌린지 날짜 선택"),
      ),
      body: Column(children: [
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
                        child: Obx((() => Container(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          width: 40,
                          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(
                            border: controller.days[i]["picked"].value ? Border.all(width: 2, color: Colors.blueGrey) : null,
                          ),
                          child: Center(
                          child: Text(
                          controller.days[i]["day"].toString(),
                          style: TextStyle(
                          color: controller.days[i]["inChallenge"]
                                  ? Colors.black
                                  : Colors.grey,
                        ),
                      ),
                    ),
                        )),),
                      )
                  ],
                ),
              ),
        ElevatedButton(
            onPressed: (){
              controller.challengePush();
              Get.toNamed(Routes.pay);
            }, child: Text("Confirm"),
          ),
      ]),
    );
  }
}