
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../controller/sns_search_controller.dart';
import '../../../controller/sns_user_routine_info_controller.dart';
import '../../../controller/user_info_controller.dart';

class SNSfollower extends GetView<SNSRoutineController> {
  SNSfollower({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    int userId=Get.find<UserInfoController>().userId!;
  //  Get.lazyPut(() => UserInfoController());

    int l= controller.userpagegetfollow(userId);
    print(l);
    return Scaffold(
      appBar: AppBar(
        title: Text("팔로워"),
        backgroundColor: Colors.purple[300],

      ),
      body: ListView.separated(
          scrollDirection:
          Axis.vertical, //vertical : 수직으로 나열 / horizontal : 수평으로 나열
          separatorBuilder: (BuildContext context, int index) => const Divider(
            color: Colors.black,
          ), //separatorBuilder : item과 item 사이에 그려질 위젯 (개수는 itemCount -1 이 된다)
          itemCount: 7, //리스트의 개수
          itemBuilder: (BuildContext context, int index) {
            //리스트의 반목문 항목 형성
            return Container(
              height: 70,
              color: Colors.purple[index * 100],
              alignment: Alignment.center,
              child: Text('item : $index'),
            );
          }),
    );
  }
}