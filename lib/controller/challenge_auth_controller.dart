import 'dart:io';

import 'package:exif/exif.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import 'package:sunmi/data/repository/challenge_auth_repository.dart';


class ChallengeAuthController extends GetxController {
  final ChallengeAuthRepository challengeAuthRepository;

  ChallengeAuthController({
    required this.challengeAuthRepository
  });

  final RxBool _isImageLoaded = false.obs;
  get isImageLoaded => _isImageLoaded.value;
  set isImageLoaded(value) => _isImageLoaded.value = value;

  final Rx<File>? _selectedImage = Rx<File>(File(''));
  get selectedImage => _selectedImage!.value;
  set selectedImage(value) => _selectedImage!.value = value;

  tempPost() async{
    if(this.isImageLoaded){
      final dio.MultipartFile _challengeAuth = await dio.MultipartFile.fromFile(selectedImage.path);
      final formData = dio.FormData.fromMap({
        'file': _challengeAuth,
      });
      final response = await dio.Dio().post("http://15.164.168.230:8080/challenges/auth/challenge-routines/1/members/1",
          data: formData,
          options: dio.Options(contentType: dio.Headers.formUrlEncodedContentType));
    }
  }

  pickImage() async {
    final picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);

    if(image != null){
      print('image found');
      selectedImage = File(image.path);
      isImageLoaded = true;
    }
  }

  readExif() async {
    final fileBytes = File(selectedImage!.path).readAsBytesSync();
    final data = await readExifFromBytes(fileBytes);

    if(data.isEmpty) {
      print('There is no EXIF data');
      return;
    }
    print('keys of data:');
    for (final entry in data.entries){
      print('${entry.key} : ${entry.value}');
    }
  }
}