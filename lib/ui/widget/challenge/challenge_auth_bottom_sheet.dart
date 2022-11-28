import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sunmi/controller/registered_challenge_info_controller.dart';

challengeAuthBottomSheet() {
  var registeredChallengeController = Get.find<RegisteredChallengeInfoController>();

  if(registeredChallengeController.registeredChallenge.progressRate == 100){
    return Container(
      child: Text('챌린지 성공'),
    );
  }
  else if(DateTime.now().difference(registeredChallengeController.registeredChallenge.endDate).inDays > 0){
    return Text('챌린지 기간이 끝났습니다');
  }
  else return Container(
      alignment: AlignmentDirectional.bottomCenter,
      child: ElevatedButton(
          child: Text('인증하기'),
          onPressed: () => Get.find<RegisteredChallengeInfoController>().toChallengeAuth()
      ),
      width: Get.mediaQuery.size.width ,
      height: 50,
    );
}