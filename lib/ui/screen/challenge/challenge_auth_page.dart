import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunmi/controller/auth_photo_controller.dart';
import 'package:sunmi/controller/challenge_auth_controller.dart';
import 'package:sunmi/controller/challenges_controller.dart';
import 'package:sunmi/controller/registered_challenge_info_controller.dart';
import 'package:sunmi/data/provider/challenge_auth_provider.dart';
import 'package:sunmi/data/repository/challenge_auth_repository.dart';
import 'package:sunmi/routes/app_pages.dart';

class ChallengeAuthPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Every Health"),
      ),
      body: GetX<ChallengeAuthController>(
        init: Get.put(ChallengeAuthController(challengeAuthRepository: ChallengeAuthRepository(challengeAuthProvider: ChallengeAuthProvider()))),
        builder: (authPageController){
          return Center(
            child: Column(
              children: [
                Text("챌린지 인증 사진 정보 페이지입니다",
                  style: TextStyle(
                      fontSize: 20
                  ),),
                ElevatedButton(
                  child: Text('이미지 불러오기'),
                  onPressed: authPageController.pickImage,
                ),
                ElevatedButton(
                  child: Text('뒤로가기'),
                  onPressed: () => Get.back(),
                ),
                ElevatedButton(
                  child: Text('보내기'),
                  onPressed: () async {
                    var value = await authPageController.authChallenge();
                    if(value < 0){
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              content: Text('실패'),
                              actions: [
                                FloatingActionButton(
                                  onPressed: (){
                                    Get.back();
                                  },
                                  child: Text('확인'),)
                              ],
                            );
                          });
                    } else {
                      print('in challenge auth page after get back--------');
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Text('성공'),
                            actions: [
                              FloatingActionButton(
                                  onPressed: (){
                                    Get.find<AuthPhotoController>().updateCurrentPhotos();
                                    Get.find<RegisteredChallengeInfoController>().updateCurrentChallenge();
                                    Get.back();
                                    Get.back();
                                  },
                                child: Text('확인'),
                              )
                            ],
                          ));
                    }
                  },
                ),
                authPageController.isImageLoaded?
                Image.file(authPageController.selectedImage) : Text("이미지를 불러와주세요")
              ],
            ),
          );
        },
      ),
    );
  }
}