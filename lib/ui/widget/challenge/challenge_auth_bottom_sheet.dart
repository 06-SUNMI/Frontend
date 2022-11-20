import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sunmi/controller/registered_challenge_info_controller.dart';

challengeAuthBottomSheet() {
  var registeredChallengeController = Get.find<RegisteredChallengeInfoController>();
  if(DateTime.now().difference(registeredChallengeController.registeredChallenge.endDate).inDays > 0){
    return Text('챌린지 기간이 끝났습니다');
  }
  else return ElevatedButton(
      child: Text('인증하기'),
      onPressed: () => Get.find<RegisteredChallengeInfoController>().toChallengeAuth()
  );
}