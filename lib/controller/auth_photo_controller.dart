import 'package:get/get.dart';
import 'package:sunmi/data/model/auth_photo.dart';
import 'package:sunmi/data/repository/auth_photo_repository.dart';

class AuthPhotoController extends GetxController{
  final AuthPhotoRepository authPhotoRepository;
  RxList<AuthPhoto> _authPhotos = <AuthPhoto>[].obs;
  get authPhotos => _authPhotos.value;
  set authPhotos(value) => _authPhotos.value = value;

  RxInt _currentChallengeId = 0.obs;
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

  getAllByCurrentId(){
    authPhotoRepository.getAllByChallengeId(currentChallengeId).then((data){
      authPhotos = data;
      print(authPhotos);
      _authPhotos.refresh();
    });
  }

  getAllByChallengeId(challengeId){
    authPhotoRepository.getAllByChallengeId(challengeId).then((data){
      authPhotos = data;
    });
  }
}