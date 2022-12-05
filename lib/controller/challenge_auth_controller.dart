import 'dart:io';

import 'package:exif/exif.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:sunmi/controller/calendar_controller.dart';
import 'package:sunmi/controller/challenges_controller.dart';
import 'package:sunmi/controller/user_info_controller.dart';
import 'package:sunmi/data/model/routine_detail.dart';
import 'package:sunmi/data/repository/challenge_auth_repository.dart';
import 'package:sunmi/data/repository/routine_detail_repository.dart';


class ChallengeAuthController extends GetxController {
  final ChallengeAuthRepository challengeAuthRepository;
  final RoutineDetailRepository routineDetailRepository = RoutineDetailRepository();

  int? routineChallengeId;
  int? memberRoutineId;

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
      DateTime imageDateOriginal = DateFormat('yyyy:MM:dd').parse(dateString.toString());
      int  difference = DateTime.now().difference(imageDateOriginal).inDays;
      if(difference != 0) {
        print('photo is not for today');
        return -4;
      }

      if(getTodayRoutineDetail() == false){
        return -1;
      }
      var response = await challengeAuthRepository.authChallenge(
          routineChallengeId!,
          memberRoutineId!,
          selectedImage);
      try {
        print(response['message']);
        return response;
      } catch(err){
        print(err);
      }
      if(response > 0){
        Get.find<ChallengeController>().getAll();
      }
      return response;
    }
  }

  getTodayRoutineDetail() {
    CalendarController calendarController = Get.find<CalendarController>();
    var today = DateFormat('yyyy-M-d').format(DateTime.now());
    print('today is $today');
    routineChallengeId = calendarController.challengeRoutineList[today]['challengeRoutineId'];
    memberRoutineId = calendarController.challengeRoutineList[today]['memberRoutineId'];
    print(Get.find<UserInfoController>().userId);
    if(routineChallengeId == null){
      return false;
    }
    return true;
  }

  pickImage() async {
    final picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);

    if(image != null){
      selectedImage = File(image.path);
      isImageLoaded = true;
    }
  }

  getImageDate() async{
    var exif = await readExif();
    String dateString = exif['EXIF DateTimeOriginal'].toString().substring(0,10);
    DateTime imageDateOriginal = DateFormat('yyyy:MM:dd').parse(dateString);
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