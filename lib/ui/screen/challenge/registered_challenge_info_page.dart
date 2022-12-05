import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sunmi/controller/registered_challenge_info_controller.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sunmi/ui/widget/challenge/challenge_auth_bottom_sheet.dart';
import 'package:sunmi/ui/widget/challenge/challenge_auth_photos.dart';
import 'package:sunmi/ui/widget/challenge/registered_challenge_progress.dart';

class RegisteredChallengeInfoPage extends GetView<RegisteredChallengeInfoController>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Every Health'),
      ),
      body: GetX<RegisteredChallengeInfoController>(
        builder: (registeredChallengeInfoController){
          return GestureDetector(
            onTap: ()=>FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Text(registeredChallengeInfoController.registeredChallenge.challengeName,style: TextStyle(
                      fontSize: 25),),
                  Center(
                    child: Column(
                      children: [
                        Text('기간'),
                        Text('${DateFormat('yyyy년 M월 d일').format(registeredChallengeInfoController.registeredChallenge.startDate)}'
                        '부터 ${DateFormat('yyyy년 M월 d일').format(registeredChallengeInfoController.registeredChallenge.endDate)}까지'),
                        Divider(thickness: 1.0, color: Colors.black,)
                      ],
                    ),
                  ),
                  challengeProgress(),
                  challengeAuthPhotos(),
                ],
              ),
            ),
          );
        },
      ),
      bottomSheet: challengeAuthBottomSheet(),
    );
  }
}





