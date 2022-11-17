import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sunmi/controller/registered_challenge_info_controller.dart';

challengeAuthBottomSheet() {
  return ElevatedButton(
      child: Text('인증하기'),
      onPressed: () => Get.find<RegisteredChallengeInfoController>().toChallengeAuth()
  );
}