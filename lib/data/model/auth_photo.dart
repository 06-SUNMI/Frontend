class AuthPhoto {
  String photoPath;
  int authPostId;
  int memberId;

  AuthPhoto({
    required this.photoPath,
    required this.authPostId,
    required this.memberId,
  });

  factory AuthPhoto.fromJson(Map<String,dynamic> json){
    return AuthPhoto(
      photoPath: json['photoPath'],
      authPostId: json['challengeAuthPostId'],
      memberId: json['memberId'],
    );
  }

  toJson(){
    Map<String, dynamic> authPhotoJson = {};
    authPhotoJson['challengeAuthPostId'] = authPostId;
    authPhotoJson['photoPath'] = photoPath;
    authPhotoJson['memberId'] = memberId;
    return authPhotoJson;
  }

}