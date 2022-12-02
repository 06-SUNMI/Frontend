import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:sunmi/controller/challenges_controller.dart';

Widget challengeListItems(context, index) {
  final challengeController = Get.find<ChallengeController>();
  return InkWell(
    child: Row(
      children: [
        Image.asset(
          challengeController.challenges[index].imagePath,
          height: 100,
          width: 100,
          fit: BoxFit.cover,),
        Column(
          children: [
            Text(
                '${challengeController.challenges[index].challengeName}'),
            Text(
                '${challengeController.challenges[index].startDate}'
                    '\nto ${challengeController.challenges[index].endDate}'),],
        )],
    ),
    onTap: ()=>challengeController.challengeInfo(index),
  );
}

Widget registeredChallengeItems(context, index) {
  final challengeController = Get.find<ChallengeController>();

  return InkWell(
    onTap: ()=>challengeController.registeredChallengeInfo(index),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.asset(
          challengeController.registeredChallenges[index].imagePath,
          height: 100,
          width: 100,
          fit: BoxFit.contain,
        ),
        Column(
            children: [
              Text(
                  '${challengeController.registeredChallenges[index].challengeName}'),
              Text(
                  '${challengeController.registeredChallenges[index].startDate}'
                      '\nto ${challengeController.registeredChallenges[index].endDate}'),
              Text(
                  '진행율: ${challengeController.registeredChallenges[index].progressRate} 상태:${challengeController.registeredChallenges[index].challengeParticipantStatus}'
              ),
              ]
        )],
    ),
  );
}
