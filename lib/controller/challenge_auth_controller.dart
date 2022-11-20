import 'dart:io';

import 'package:exif/exif.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sunmi/controller/calendar_controller.dart';
import 'package:sunmi/controller/challenges_controller.dart';
import 'package:sunmi/controller/registered_challenge_info_controller.dart';
import 'package:sunmi/data/model/routine_detail.dart';

import 'package:sunmi/data/repository/challenge_auth_repository.dart';
import 'package:sunmi/data/repository/routine_detail_repository.dart';


class ChallengeAuthController extends GetxController {
  final ChallengeAuthRepository challengeAuthRepository;
  final RoutineDetailRepository routineDetailRepository = RoutineDetailRepository();

  RoutineDetail? todayRoutineDetail;

  final RxBool _isImageLoaded = false.obs;
  get isImageLoaded => _isImageLoaded.value;
  set isImageLoaded(value) => _isImageLoaded.value = value;

  final Rx<File> _selectedImage = Rx<File>(File(''));
  get selectedImage => _selectedImage.value;
  set selectedImage(value) => _selectedImage.value = value;

  ChallengeAuthController({
    required this.challengeAuthRepository
  });

  authChallenge() async {
    if(isImageLoaded){

      var dateString = await getImageDate();
      print(dateString);
      DateTime imageDateOriginal = DateFormat('yyyy:MM:dd').parse(dateString.toString());
      print(imageDateOriginal);
      int  difference = DateTime.now().difference(imageDateOriginal).inDays;
      print(difference);
      if(difference != 0) {
        print('photo is not for today');
        return -4;
      }

      await getTodayRoutineDetail();
      for (var routine in todayRoutineDetail!.routines){
        if(routine.workoutChecked == false) return -5;
      }
      var response = await challengeAuthRepository.authChallenge(
          todayRoutineDetail!.routineChallengeId,
          todayRoutineDetail!.memberRoutineId,
          selectedImage);

      if(response > 0){
        Get.find<ChallengeController>().getAll();
      }
      return response;
    }
  }

  getTodayRoutineDetail() async {
    CalendarController calendarController = Get.find<CalendarController>();
    List days = calendarController.days;
    int todayRoutineId = -1;
    for(var day in days){
      if(calendarController.isToday(day['year'], day['month'], day['day'])){
        todayRoutineId = day['routineId'];
      }
    }
    print(todayRoutineId);
    this.todayRoutineDetail = await routineDetailRepository.getById(todayRoutineId);
    return;
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

  getImageDate() async{
    var exif = await readExif();
    print(exif['EXIF DateTimeOriginal']);
    String dateString = exif['EXIF DateTimeOriginal'].toString().substring(0,10);
    print(dateString);
    DateTime imageDateOriginal = DateFormat('yyyy:MM:dd').parse(dateString);
    print(imageDateOriginal);
    return dateString;
  }

  readExif() async {
    final fileBytes = File(selectedImage.path).readAsBytesSync();
    final data = await readExifFromBytes(fileBytes);

    if(data.isEmpty) {
      print('There is no EXIF data');
      return;
    }
    return data;
  }
}