import 'package:get/get.dart';
import 'package:sunmi/data/model/auth_photo.dart';
import 'package:sunmi/data/repository/auth_photo_repository.dart';

class AuthPhotoController extends GetxController{
  final AuthPhotoRepository authPhotoRepository;
  final RxList<AuthPhoto> _authPhotos = <AuthPhoto>[].obs;
  get authPhotos => _authPhotos;
  set authPhotos(value) => _authPhotos.assignAll(value);

  final _currentChallengeId = 0.obs;
  get currentChallengeId => _currentChallengeId.value;
  set currentChallengeId(value) => _currentChallengeId.value = value;

  @override
  void onInit(){
    once(_currentChallengeId, (challengeId){
      authPhotoRepository.getAllByChallengeId(challengeId).then((data){
        authPhotos = data;
      });
    });
    super.onInit();
  }


  AuthPhotoController({
    required this.authPhotoRepository,
  });

  updateCurrentPhotos(){
    authPhotoRepository.getAllByChallengeId(currentChallengeId).then((data){
      authPhotos = data;
      print(authPhotos);
    });
  }

  getAllByChallengeId(challengeId){
    authPhotoRepository.getAllByChallengeId(challengeId).then((data){
      authPhotos = data;
    });
  }
}