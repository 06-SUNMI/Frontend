import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../../../controller/sns_samegym_controller.dart';
import '../../../routes/app_pages.dart';
import '../../screen/sns/sns_followuserpage.dart';


class StoryItem extends GetView<SnsgymController> {

  const StoryItem({
    required this.storyname,
    required this.storyimg,
    required this.num,
    Key? key,
  }) : super(key: key);
  final String storyname; //storys[index]['image']
  final String storyimg;
  final int num;//storys[index]['name'],
  //getpost();
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SnsgymController());
    return Padding(

        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10.0),
      child: Column(

        children: [
          Container(
            height: 67,
            width: 67,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [Colors.purpleAccent, Colors.yellow],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter

                )

            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple, width: 2),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(storyimg), fit: BoxFit.cover)),
                  child: InkWell(
                    onTap: () {
                        Get.toNamed(Routes.userfollowpage, arguments: {'name': "$storyname", 'id':  controller.info[num]["memberId"],
                        'gymName' :  controller.info[num]["memberRegisteredGymName"], 'customProfileImageUrl' :  controller.info[num]["customProfileImageUrl"]} );
                  },
                ),
              ),
            ),

          ),
          SizedBox(
            height: 7,
          ),
          Text(
            storyname,
            style: TextStyle(
                overflow: TextOverflow.ellipsis, color: Colors.black, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
