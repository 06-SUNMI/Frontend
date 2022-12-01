import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:sunmi/controller/sns_post_controller.dart';

snsPostFile(SNSPostController snsPostController){
  if(snsPostController.isImage) {
    return Expanded(
        child: Image.file(
          snsPostController.selectedImage,
          fit: BoxFit.contain,
        ));
  } else if(snsPostController.isVideo) {
    return Expanded(
        child: Stack(
          children: [
            Center(
              child: AspectRatio(
                aspectRatio: snsPostController.videoController!.value.aspectRatio,
                child: VideoPlayer(snsPostController.videoController!),
              ),
            ),
            Center(
              child: FloatingActionButton(
                onPressed: () {
                  snsPostController.videoController!.value.isPlaying
                      ? snsPostController.videoController!.pause()
                      : snsPostController.videoController!.play();
                  snsPostController.isPlaying =
                      snsPostController.videoController!.value.isPlaying;
                },
                child: Icon(
                    snsPostController.isPlaying ? Icons.pause : Icons.play_arrow),
              ),
            )
          ],
        )
    );
  }
}