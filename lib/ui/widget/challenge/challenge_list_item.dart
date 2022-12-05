import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
          fit: BoxFit.contain,),
        Container(
          padding: EdgeInsets.only(left: 15.0),
          child: Column(
            children: [
              Text(
                  '${challengeController.challenges[index].challengeName}'),
              Text(
                  '${DateFormat('yyyy년 M월 d일').format(challengeController.challenges[index].startDate)}'
                      ' ~ ${DateFormat('yyyy년 M월 d일').format(challengeController.challenges[index].endDate)}'),],
          ),
        )
      ],
    ),
    onTap: ()=>challengeController.challengeInfo(index),
  );
}

Widget registeredChallengeItems(context, index) {
  final challengeController = Get.find<ChallengeController>();
  return InkWell(
    child: Row(
      children: [
        Image.asset(
          challengeController.registeredChallenges[index].imagePath,
          height: 100,
          width: 100,
          fit: BoxFit.contain,),
        Container(
          padding: EdgeInsets.only(left: 15.0),
          child: Column(
              children: [
                Text(
                    '${challengeController.registeredChallenges[index].challengeName}'),
                Text(
                    '${DateFormat('yyyy년 M월 d일').format(challengeController.registeredChallenges[index].startDate)}'
                        ' ~ ${DateFormat('yyyy년 M월 d일').format(challengeController.registeredChallenges[index].endDate)}'),]
          ),
        )],
    ),
    onTap: ()=>challengeController.registeredChallengeInfo(index),
  );
}
