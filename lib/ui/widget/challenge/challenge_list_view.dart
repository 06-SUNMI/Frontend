import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:sunmi/controller/challenges_controller.dart';
import 'package:sunmi/ui/widget/challenge/challenge_list_item.dart';

challengeListView() {
  return Expanded(
      child: ListView.separated(
          itemCount: Get.find<ChallengeController>().challenges.length ,
          itemBuilder: challengeListItems,
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.black,
              thickness: 1.0,
            );
          }
      )
  );
}

registeredChallengeListView(){
  return Expanded(
      child: ListView.separated(
          itemCount: Get.find<ChallengeController>().registeredChallenges.length,
          itemBuilder: registeredChallengeItems,
          separatorBuilder: (context, index){
            return const Divider(
              color: Colors.black,
              thickness: 1.0,
            );
          }
      )
  );
}