import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sunmi/controller/registered_challenge_info_controller.dart';

challengeAuthPhotos(){
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
          itemCount: 10,
          itemBuilder: (context,index){
            return InkWell(
              onTap: () => Get.find<RegisteredChallengeInfoController>().toChallengeAuthPhotoInfo(),
              child: Image.asset('assets/images/checkimage.png',),
            );
          },
        ),
      ),
    ],
  );
}