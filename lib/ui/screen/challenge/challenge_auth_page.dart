import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sunmi/controller/challenge_auth_controller.dart';
import 'package:sunmi/routes/app_pages.dart';

class ChallengeAuthPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Every Health"),
      ),
      body: GetX<ChallengeAuthController>(
        builder: (authPageController){
          return Center(
            child: Column(
              children: [
                Text("챌린지 인증 페이지입니다",
                  style: TextStyle(
                      fontSize: 20
                  ),),
                ElevatedButton(
                  child: Text('이미지 불러오기'),
                  onPressed: authPageController.pickImage,
                ),
                authPageController.isImageLoaded?
                Expanded(
                    child: Image.file(
                        authPageController.selectedImage,
                        fit: BoxFit.contain,
                    )
                )
                    : Text("이미지를 불러와주세요"),
                ElevatedButton(
                  child: Text('보내기'),
                  onPressed: () async {
                    var value = await authPageController.authChallenge();
                    if(value is int){
                      if(value == -4 ){
                        dialogFail('업로드할 이미지의 날짜가 다릅니다');
                      } else if (value <= 0){
                        dialogFail('실패');
                      }else {
                        dialogSuccess();
                      }
                    } else {
                      dialogFail(value['message']);
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void dialogSuccess() {
    Get.dialog(
      AlertDialog(
        content: Text('성공'),
        actions: [
          FloatingActionButton(
            onPressed: (){
              Get.back();
              Get.back();
            },
            child: Text('확인'),)
        ],
      ),
      barrierDismissible: false,
    );
  }

  void dialogFail(String text) {
    Get.dialog(
        AlertDialog(
          content: Text(text),
          actions: [
            FloatingActionButton(
              onPressed: (){
                Get.back();
              },
              child: Text('확인'),)
          ],
        ),
        barrierDismissible: false,
    );
  }
}