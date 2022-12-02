import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sunmi/controller/user_info_controller.dart';
import 'package:video_player/video_player.dart';

import 'package:sunmi/data/repository/sns_post_repository.dart';


class SNSPostController extends GetxController {
  final SNSPostRepository snsPostRepository;
  final inputTextController = TextEditingController();
  VideoPlayerController? videoController;
  VideoPlayerController? _toBeDisposed;

  final Rx<File> _selectedImage = Rx<File>(File(''));
  get selectedImage => _selectedImage.value;
  set selectedImage(value) => _selectedImage(value);

  final Rx<File> _selectedVideo = Rx<File>(File(''));
  get selectedVideo => _selectedVideo.value;
  set selectedVideo(value) => _selectedVideo(value);

  final RxBool _isFileLoaded = false.obs;
  get isFileLoaded => _isFileLoaded.value;
  set isFileLoaded(value) => _isFileLoaded.value = value;

  final RxBool _isImage = false.obs;
  get isImage => _isImage.value;
  set isImage(value) => _isImage.value = value;

  final RxBool _isVideo = false.obs;
  get isVideo => _isVideo.value;
  set isVideo(value) => _isVideo.value = value;

  final RxBool _isPlaying = false.obs;
  get isPlaying => _isPlaying.value;
  set isPlaying(value) => _isPlaying.value = value;

  SNSPostController({
    required this.snsPostRepository,
  });

  @override
  void onInit(){
    super.onInit();
  }

  @override
  void onClose(){
    if(videoController != null){
      disposeVideoController();
    }
    super.onClose();
  }

  disposeVideoController() async{
    if(_toBeDisposed != null){
      await _toBeDisposed!.dispose();
    }
    try {
      selectedVideo = File('');
      _toBeDisposed = videoController;
      await videoController!.dispose();
    } catch(err){
      print(err);
    }
    print('in dispose');
  }

  postNewSNSPost() async {
    var response;
    if(!isFileLoaded) return -10;
    if(inputTextController.text.isEmpty){
      inputTextController.text = ' ';
    }
    if(isImage){
      response = await snsPostRepository.postNewSNSPost(
          Get.find<UserInfoController>().userId!,
          selectedImage,
          'jpg',
          inputTextController.text);
    } else if (isVideo){
      response = await snsPostRepository.postNewSNSPost(
          Get.find<UserInfoController>().userId!,
          selectedVideo,
          'mp4',
          inputTextController.text);
    }

    if(response is int){
      print('response: $response');
      return response;
    } else {
      try{
        print(response);
        print('error message: ${response['message']}');
        return response['message'];
      } catch(err){
        print(err);
      }
      return -9;
    }
  }

  pickImage() async {
    final picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.camera);
    if(image != null){
      selectedImage = File(image.path);
      disposeVideoController();
      isFileLoaded = true;
      isImage = true;
      isVideo = false;
    }
  }

  pickVideoByGallery() async {
    final picker = ImagePicker();
    var video = await picker.pickVideo(source: ImageSource.gallery);

    if(video != null){
      selectedVideo = File(video.path);
      videoController = VideoPlayerController.file(File(selectedVideo.path));
      await videoController!.initialize();
      await videoController!.setLooping(true);
      await videoController!.pause();
      selectedImage = File('');
      isFileLoaded = true;
      isImage = false;
      isVideo = true;
    } else if(video == null){
      print('not found');
    }
  }

  pickVideo() async {
    final picker = ImagePicker();
    var video = await picker.pickVideo(source: ImageSource.camera);

    if(video != null){
      selectedVideo = File(video.path);
      videoController = VideoPlayerController.file(File(selectedVideo.path));
      await videoController!.initialize();
      await videoController!.setLooping(true);
      await videoController!.pause();
      selectedImage = File('');
      isFileLoaded = true;
      isImage = false;
      isVideo = true;
    } else if(video == null){
      print('not found');
    }
  }
}