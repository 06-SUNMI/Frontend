import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sunmi/controller/registered_challenge_info_controller.dart';

challengeProgress(){
  var registeredChallengeController = Get.find<RegisteredChallengeInfoController>();
  return Obx(()=>Column(
    children: [
      Text('진행상황'),
      Center(
        child: LinearPercentIndicator(
          alignment: MainAxisAlignment.center,
          width: Get.mediaQuery.size.width-30,
          lineHeight: 20.0,
          backgroundColor: Colors.grey,
          progressColor: Colors.blueAccent,
          percent: Get.find<RegisteredChallengeInfoController>().registeredChallenge.progressRate/100.0,
          center: Text(registeredChallengeController.registeredChallenge.progressRate.toString()+'%'),
          barRadius: Radius.circular(10.0),
        ),
      ),
      Divider(thickness: 1.0, color: Colors.black,),
    ],
  ));
}