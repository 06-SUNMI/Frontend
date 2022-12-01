import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sunmi/controller/auth_photo_controller.dart';
import 'package:sunmi/controller/registered_challenge_info_controller.dart';
import 'package:sunmi/data/provider/auth_photo_provider.dart';
import 'package:sunmi/data/repository/auth_photo_repository.dart';

challengeAuthPhotos(){
  AuthPhotoController authPhotoController = Get.put(AuthPhotoController(authPhotoRepository: AuthPhotoRepository(authPhotoProvider: AuthPhotoProvider())));
  authPhotoController.currentChallengeId = Get.find<RegisteredChallengeInfoController>().currentChallengeId;
  return Column(
    children: [
      Text('사진'),
      Container(
        height: 200,
        child: GridView.builder(
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 80,
            mainAxisSpacing: 15.0,
            crossAxisSpacing: 15.0,
          ),
          itemCount: authPhotoController.authPhotos.length,
          itemBuilder: (context,index){
            return InkWell(
              onTap: () => Get.find<RegisteredChallengeInfoController>().toChallengeAuthPhotoInfo(authPhotoController.authPhotos[index]),
              child: Image.network(authPhotoController.authPhotos[index].photoPath,),
            );
          },
        ),
      ),
    ],
  );
}