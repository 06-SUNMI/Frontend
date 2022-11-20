import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sunmi/controller/registered_challenge_info_controller.dart';

challengeProgress(){
  var registeredChallengeController = Get.find<RegisteredChallengeInfoController>();
  if(registeredChallengeController.registeredChallenge.progressRate == 100){
    return Obx(()=>Column(
      children: [
        Text('진행상황'),
        Center(
          child: LinearPercentIndicator(
            width: 300.0,
            lineHeight: 20.0,
            backgroundColor: Colors.grey,
            progressColor: Colors.blueAccent,
            percent: Get.find<RegisteredChallengeInfoController>().registeredChallenge.progressRate/100.0,
            center: Text('챌린지 성공'),
            barRadius: Radius.circular(10.0),
          ),
        ),
        Divider(thickness: 1.0, color: Colors.black,),
      ],
    ));
  }
  else return Obx(()=>Column(
    children: [
      Text('진행상황'),
      Center(
        child: LinearPercentIndicator(
          width: 300.0,
          lineHeight: 20.0,
          backgroundColor: Colors.grey,
          progressColor: Colors.blueAccent,
          // percent: Get.find<RegisteredChallengeInfoController>().registeredChallenge.progressRate/100.0,
          percent: 0.5,
          center: Text(registeredChallengeController.registeredChallenge.progressRate.toString()+'%'),
          barRadius: Radius.circular(10.0),
        ),
      ),
      Divider(thickness: 1.0, color: Colors.black,),
    ],
  ));
}