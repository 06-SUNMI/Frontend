import 'package:sunmi/data/provider/auth_photo_provider.dart';

class AuthPhotoRepository{
  AuthPhotoProvider authPhotoProvider;

  AuthPhotoRepository({
    required this.authPhotoProvider
  });

  getAllByChallengeId(int challengeId){
    return authPhotoProvider.getAllByChallengeId(challengeId);
  }

  reportAuthPhoto(authPhotoId, memberId, content){
    // return authPhotoProvider.reportAuthPhoto(authPhotoId, memberId, content);
    return 0;
  }
}