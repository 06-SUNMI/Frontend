import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunmi/controller/sns_post_controller.dart';
import 'package:video_player/video_player.dart';

class SNSPostPage extends GetView<SNSPostController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Every Health'),),
      body: GetX<SNSPostController>(
        builder: (snsPostController){
          return Center(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                children: [
                  Text('SNS 게시글 작성 페이지',style: TextStyle(fontSize: 30),),
                  Row(
                    children: [
                      Expanded(child: ElevatedButton(onPressed: snsPostController.pickImage, child: Text('이미지 불러오기'))),
                      Expanded(child: ElevatedButton(onPressed: snsPostController.pickVideo, child: Text('동영상 불러오기'))),
                    ],
                  ),
                  if(snsPostController.isImage)
                    Expanded(
                        child: Image.file(
                          snsPostController.selectedImage,
                          fit: BoxFit.contain,
                    )),
                  if(snsPostController.isVideo)
                    Expanded(child: AspectRatio(
                      aspectRatio: snsPostController.videoController!.value.aspectRatio,
                      child: VideoPlayer(snsPostController.videoController!),
                    ))
                    ,
                  TextField(
                    controller: snsPostController.inputTextController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Content',
                    )
                  ),
                  ElevatedButton(onPressed: () async {
                    FocusScope.of(context).unfocus();
                    var response = await snsPostController.postNewSNSPost();
                    print(response);
                    if(response > 0){
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
                  }, child: Text('완료')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}