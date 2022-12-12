
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:sunmi/data/storys.dart';

import '../../../controller/sns_search_controller.dart';
import '../../../controller/sns_user_routine_info_controller.dart';
import '../../../controller/user_info_controller.dart';
import '../../../routes/app_pages.dart';

class SNSfollower extends GetView<SNSRoutineController> {
  SNSfollower({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => UserInfoController());
    Get.lazyPut(()=>SearchController());
    Get.lazyPut(()=>SNSRoutineController());

    RxInt m=Get.arguments["count"].value;
    int? userids=Get.find<UserInfoController>().userId;
    //controller.userpagegetfollow(Get.find<UserInfoController>().userId!);
    int num=controller.followlist.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("팔로워"),
        backgroundColor: Colors.purple[300],
      ),
      body:  ListView.builder(
         // scrollDirection: Axis.vertical,
          itemCount: m.value,
          itemBuilder: (context, int index) {
            controller.followgetUserData(controller.followlist[index]["userid"]);
           return Obx(() => ListTile(

              leading: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image:NetworkImage(controller.userDatalist[index]["image"]),
                        fit: BoxFit.cover)),
              ),
              tileColor: Colors.purple[index * 100],
              title: Align(
                alignment: Alignment(-1, 0),
                child: new Text(controller.userDatalist[index]["name"]),
              ),
              contentPadding:EdgeInsets.all(10),
              onTap: () {
                controller.userId = controller.userDatalist[index]["id"];
                Get.toNamed(Routes.userfollowpage, arguments: {'name': controller.userDatalist[index]["name"].toString(), 'id':  controller.userDatalist[index]["id"],
                  'gymName' :  controller.userDatalist[index]["gymName"], 'customProfileImageUrl' :  controller.userDatalist[index]["image"]} );
              },

            ),);
          },

      ),
      );
  }
}

