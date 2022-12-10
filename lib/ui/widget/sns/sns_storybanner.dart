import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:sunmi/data/storys.dart';

import 'package:sunmi/ui/widget/sns/sns_storyitem.dart';

import '../../../controller/sns_samegym_controller.dart';

class StoryBanner extends GetView<SnsgymController> {
    @override
  Widget build(BuildContext context) {
      Get.lazyPut(() => SnsgymController());
      controller.onIniit();

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Obx(() => Row(
          children: [
            Row(
              children: List.generate(controller.info.length, (index) {
                if(controller.info[index]['customProfileImageUrl'].toString()=="null"){
                  controller.info[index]['customProfileImageUrl']= "assets/images/eh.png";
                }
                return StoryItem(
                  num:index,
                  storyimg: controller.info[index]['customProfileImageUrl'],
                  storyname: controller.info[index]['memberName'],
                );
              }),
            ),
          ],
        ),
        ),
      );
    }
}
