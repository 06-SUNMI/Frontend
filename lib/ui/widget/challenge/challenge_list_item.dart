import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:sunmi/controller/challenges_controller.dart';

Widget challengeListItems(context, index) {
  final challengeController = Get.find<ChallengeController>();
  return InkWell(
    child: Row(
      children: [
        Image.asset(
          'assets/images/checkimage.png',
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
    onTap: ()=>challengeController.challengeDetails(index),
  );
}

Widget registeredChallengeItems(context, index) {
  final challengeController = Get.find<ChallengeController>();

  return InkWell(
    onTap: ()=>challengeController.registeredChallengeDetails(index),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.asset(
          'assets/images/checkimage.png',
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Column(
            children: [
              Text(
                  '${challengeController.registeredChallenges[index].challengeName}'),
              Text(
                  '${challengeController.registeredChallenges[index].startDate}'
                      '\nto ${challengeController.registeredChallenges[index].endDate}'),]
        )],
    ),
  );
}
