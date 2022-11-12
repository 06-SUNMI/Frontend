import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChallengeAuthPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Every Health"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("챌린지 인증 사진 정보 페이지입니다",
              style: TextStyle(
                  fontSize: 20
              ),),
            ElevatedButton(
              child: Text('뒤로가기'),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }
}