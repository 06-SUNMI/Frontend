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
                authPageController.isImageLoaded?
                Expanded(
                    child: Image.file(
                        authPageController.selectedImage,
                        fit: BoxFit.contain,
                    )
                )
                // Image.file(
                //            authPageController.selectedImage)
                    : Text("이미지를 불러와주세요"),
                ElevatedButton(
                  child: Text('보내기'),
                  onPressed: () async {
                    var value = await authPageController.authChallenge();
                    if(value == -4 ){
                      Get.dialog(
                          AlertDialog(
                            content: Text('업로드할 이미지의 날짜가 다릅니다'),
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
                    } else if (value == -3){
                      Get.dialog(
                        AlertDialog(
                          content: Text('오늘 루틴을 모두 완료하지 못했니다'),
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
                    else if (value == -2){
                      Get.dialog(
                        AlertDialog(
                          content: Text('이미 인증을 하였습니다'),
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
                    else if(value == -1){
                      Get.dialog(
                        AlertDialog(
                          content: Text('오늘은 인증할 루틴이 없습니다'),
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
                    } else if (value < 0){
                      Get.dialog(
                        AlertDialog(
                          content: Text('실패'),
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
                    }else {
                      Get.dialog(
                        AlertDialog(
                          content: Text('성공'),
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
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}