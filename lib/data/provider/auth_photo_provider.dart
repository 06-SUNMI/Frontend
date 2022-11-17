import 'package:get/get.dart';

import 'package:sunmi/data/model/auth_photo.dart';
import 'url.dart' as url;

class AuthPhotoProvider extends GetConnect{
  Future<Response> getAuthPhoto(int challengeId) => get('${url.baseURL}/challenges/$challengeId/auth');

  getAllByChallengeId(int challengeId){

  }
}