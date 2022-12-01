import 'package:get/get.dart';

import 'package:sunmi/data/model/auth_photo.dart';
import 'url.dart';

class AuthPhotoProvider extends GetConnect{
  Future<Response> getAuthPhoto(int challengeId) => get('$baseURL/challenges/$challengeId/auth');
  Future<Response> postAuthPhotoReport(reportedAuthPostId, reportingMemberId, data) =>
      post('$baseURL/challenges/auth/$reportedAuthPostId/report/members/$reportingMemberId', data);

  getAllByChallengeId(int challengeId) async {
    var authPhotoResponse = await getAuthPhoto(challengeId);
    final authPhotosJson = authPhotoResponse.body['challengeFindAllAuthPostDataList'] as List;
    List<AuthPhoto> authPhotos = authPhotosJson.map((authPhoto) => AuthPhoto.fromJson(authPhoto)).toList();
    return authPhotos;
  }

  reportAuthPhoto(int reportedAuthPostId, int reportingMemberId, String content) async {
    var data = {
      'ReportReason': content,
    };
    var reportResponse = await postAuthPhotoReport(reportedAuthPostId, reportingMemberId, data);
    return 0;
  }
}