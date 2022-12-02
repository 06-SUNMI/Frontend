import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sunmi/controller/registered_challenge_info_controller.dart';

challengeAuthBottomSheet() {
  var registeredChallengeController = Get.find<RegisteredChallengeInfoController>();

  if(registeredChallengeController.registeredChallenge.progressRate == 100){
    return Container(
      width: Get.mediaQuery.size.width,
      padding: EdgeInsets.only(left: 10.0,bottom: 20.0,right: 10.0,top: 10.0),
      decoration: BoxDecoration(
        color: Colors.green,
      ),
      child: Text(
        '챌린지 성공',
        style: TextStyle(
          fontSize: 20,
        ),),
    );
  }
  else if(DateTime.now().difference(registeredChallengeController.registeredChallenge.endDate).inDays > 0){
    return Container(
      width: Get.mediaQuery.size.width,
      padding: EdgeInsets.only(left: 10.0,bottom: 20.0,right: 10.0,top: 10.0),
      decoration: BoxDecoration(
        color: Colors.amberAccent,
      ),
      child: Text(
        '챌린지 기간이 끝났습니다',
        style: TextStyle(
          fontSize: 20,
        ),),
    );
  } else if(registeredChallengeController.registeredChallenge.challengeParticipantStatus == 'FAIL'){
    return Container(
      width: Get.mediaQuery.size.width,
      padding: EdgeInsets.only(left: 10.0,bottom: 20.0,right: 10.0,top: 10.0),
      decoration: BoxDecoration(
        color: Colors.redAccent,
      ),
      child: Text(
          '챌린지에 실패했습니다',
          style: TextStyle(
          fontSize: 20,
          ),),
    );
  } else return Container(
      alignment: AlignmentDirectional.bottomCenter,
      child: ElevatedButton(
          child: Text('인증하기'),
          onPressed: () => Get.find<RegisteredChallengeInfoController>().toChallengeAuth()
      ),
      width: Get.mediaQuery.size.width ,
      height: 50,
    );
}