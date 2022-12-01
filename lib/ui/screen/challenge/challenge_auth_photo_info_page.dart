import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunmi/controller/auth_photo_controller.dart';
import 'package:sunmi/data/model/auth_photo.dart';


class ChallengeAuthPhotoInfoPage extends GetView{
  final AuthPhotoController authPhotoController = Get.find<AuthPhotoController>();

  @override
  Widget build(BuildContext context) {
    authPhotoController.selectedAuthPhoto = Get.arguments['selectedAuthPhoto'];
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
                onPressed: (){
                  authPhotoController.inputTextController.clear();
                  Get.dialog(
                    AlertDialog(
                      content: GestureDetector(
                        onTap: ()=>FocusScope.of(context).unfocus(),
                        child: TextField(
                            controller: authPhotoController.inputTextController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '신고 사유',
                            )
                        ),
                      ),
                      actions: [
                        FloatingActionButton(
                          onPressed: (){
                            var text = authPhotoController.reportChallengeAuthPhoto();
                            Get.back();
                            Get.dialog(
                              AlertDialog(
                                content: Text(text),
                                actions: [
                                  FloatingActionButton(
                                    onPressed: (){
                                      Get.back();
                                    },
                                    child: Text('확인'),),
                                ],
                              ),
                              barrierDismissible: false,
                            );
                          },
                          child: Text('신고'),),
                        FloatingActionButton(
                          onPressed: (){
                            Get.back();
                          },
                          child: Text('취소'),),
                      ],
                    ),
                    barrierDismissible: false,
                  );
                },
                child: Text('신고하기')),
            Expanded(
              child: Image.network(authPhotoController.selectedAuthPhoto.photoPath),
            )
          ],
        ),
      ),
    );
  }
}