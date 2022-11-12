import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunmi/controller/registered_challenge_info_controller.dart';

class RegisteredChallengeInfoPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final registeredChallengeInfoController = Get.find<RegisteredChallengeInfoController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('등록한 챌린지 상세 조회 페이지'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: Text('뒤로가기'),
              onPressed: () => Get.back(),
            ),
            ElevatedButton(
              child: Text('인증 사진 리스트 페이지 가기'),
              onPressed: () => registeredChallengeInfoController.toChallengeAuthPhotos(),
            ),
            ElevatedButton(
              child: Text('인증 사진 정보 페이지 가기'),
              onPressed: () => registeredChallengeInfoController.toChallengeAuthPhotoInfo(),
            ),
            ElevatedButton(
              child: Text('챌린지 인증 페이지 가기'),
              onPressed: () => registeredChallengeInfoController.toChallengeAuth(),
            )
          ],
        ),
      ),
    );
  }
}