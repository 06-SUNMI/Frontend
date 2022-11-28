import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunmi/controller/auth_photo_controller.dart';
import 'package:sunmi/data/model/auth_photo.dart';


class ChallengeAuthPhotoInfoPage extends GetView{
  final AuthPhotoController authPhotoController = Get.find<AuthPhotoController>();
  late AuthPhoto selectedAuthPhoto;

  @override
  Widget build(BuildContext context) {
    selectedAuthPhoto = Get.arguments['selectedAuthPhoto'];
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
                onPressed: (){},
                child: Text('신고하기')),
            Expanded(
              child: Image.network(selectedAuthPhoto.photoPath),
            )
          ],
        ),
      ),
    );
  }
}