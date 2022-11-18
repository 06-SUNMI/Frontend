import 'dart:io';
import 'package:get/get.dart';
import 'url.dart';

class ChallengeAuthProvider extends GetConnect {
  Future<Response> postChallengeAuth(challengeRoutineId, memberRoutineId, data) =>
      post('$baseURL/challenges/auth/challenge-routines/$challengeRoutineId/member-routines/$memberRoutineId', data);
  
  authChallenge(int challengeRoutineId,int memberRoutineId, File image) async{
    final challengeAuthPhoto = MultipartFile(image.path, filename: 'image.jpg');
    print(challengeAuthPhoto.length);
    final formData = FormData({
      'challengeAuthPostPhoto': challengeAuthPhoto,

    });

    var authChallengeResponse = await postChallengeAuth(challengeRoutineId, memberRoutineId, formData);
    print('head: '+ authChallengeResponse.headers.toString());
    print('body: '+ authChallengeResponse.body.toString());
    return authChallengeResponse.body;
  }
}