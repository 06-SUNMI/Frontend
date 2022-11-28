import 'package:get/get.dart';

import 'package:sunmi/data/model/auth_photo.dart';
import 'url.dart' as url;

class AuthPhotoProvider extends GetConnect{
  Future<Response> getAuthPhoto(int challengeId) => get('${url.baseURL}/challenges/$challengeId/auth');


  getAllByChallengeId(int challengeId) async {
    var authPhotoResponse = await getAuthPhoto(challengeId);
    final authPhotosJson = authPhotoResponse.body['challengeFindAllAuthPostDataList'] as List;
    List<AuthPhoto> authPhotos = authPhotosJson.map((authPhoto) => AuthPhoto.fromJson(authPhoto)).toList();
    return authPhotos;
  }

  reportAuthPhoto(int authPostId, int memberId, String content){
    return 0;
  }
}