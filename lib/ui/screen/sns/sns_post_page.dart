import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunmi/controller/sns_post_controller.dart';
import 'package:sunmi/ui/screen/sns/sns_home_screen.dart';
import 'package:sunmi/ui/widget/sns/sns_post_file.dart';

import '../../../controller/sns_controller.dart';
import '../../../routes/app_pages.dart';

class SNSPostPage extends GetView<SNSPostController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Every Health'),),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child:GetX<SNSPostController>(
          builder: (snsPostController){
            return Center(
              child: Column(
                children: [
                  Text('SNS 게시글 작성 페이지',style: TextStyle(fontSize: 30),),
                  buttonPick(snsPostController),
                  if(snsPostController.isFileLoaded) snsPostFile(snsPostController),
                  TextField(
                      controller: snsPostController.inputTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Content',
                      )
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        var response = await snsPostController.postNewSNSPost();
                        if(response is int){
                          response > 0
                              ?dialogSuccess()
                              :dialogFail();
                        } else {

                          dialogFailMessage(response);
                        }},
                      child: Text('완료')),
                ],
              ),
            );},
        ),
      )
    );
  }

  Row buttonPick(SNSPostController snsPostController) {
    return Row(
      children: [
        Expanded(child: ElevatedButton(onPressed: snsPostController.pickImage, child: Text('이미지 불러오기'))),
        Expanded(child: ElevatedButton(onPressed: snsPostController.pickVideo, child: Text('동영상 불러오기'))),
      ],
    );
  }

  void dialogFail() {
    Get.dialog(
      AlertDialog(
        content: Text('실패'),
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
  }

  void dialogFailMessage(message) {
    Get.dialog(
      AlertDialog(
        content: Text(message),
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
              Get.find<SnsController>().onInit;
            },
            child: Text('확인'),)
        ],
      ),
      barrierDismissible: false,
    );
  }
}