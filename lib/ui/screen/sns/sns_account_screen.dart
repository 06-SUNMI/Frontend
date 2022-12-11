import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:sunmi/ui/screen/sns/sns_follower.dart';

import '../../../controller/sns_post_controller.dart';
import '../../../controller/sns_search_controller.dart';
import '../../../controller/sns_user_routine_info_controller.dart';
import '../../../controller/user_info_controller.dart';
import '../../../data/storys.dart';
import '../../../routes/app_pages.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("내 페이지"),
          backgroundColor: Colors.purple[300],
          ),

      body: DefaultTabController(
        length: 2,
        child: Container(
            color: Colors.black,
            child: Column(
              children: const [
                ProfileHeader(),
                SizedBox(
                  height: 20,
                )
              ],
            )
        ),
      ),
    );
  }
}
class ProfileHeader extends GetView<UserInfoController> {
  const ProfileHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // Get.lazyPut(()=>SearchController());
    Get.lazyPut(() => UserInfoController());
    Get.lazyPut(() => SNSRoutineController());
    dynamic flowercount = 0;

    flowercount=Get.find<SNSRoutineController>().userpagegetfollow(controller.userId!);
   // userpagegetfollow();
    print("flowercount");
    print(flowercount);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(controller.image), fit: BoxFit.cover)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  Row(
                  children: [
                    Text(
                      controller.name.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '의 페이지',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 12),
                    ),
                  ],
                ), SizedBox(
                      height: 10,
                    ),
                Row(
                  children: [
                    TextButton( onPressed: () => Get.toNamed(Routes.followerPage),
                      child: Text( flowercount.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    TextButton( onPressed: () => Get.toNamed(Routes.followerPage),
                      child: Text(
                      '   131',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 18),
                      ),
                    ),
                    TextButton( onPressed: () { },
                      child: Text(
                      '   팔로잉',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '   39',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                  ],
                ),
              ],
              ),
              Column(
                children: [

                ],
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),

          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '키 : ',
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.white, fontSize: 16),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                controller.height.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.white, fontSize: 12),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                '몸무게 : ',
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.white, fontSize: 16),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                controller.weight.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.white, fontSize: 12),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                '헬스장 : ',
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.white, fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                controller.gymName.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.white, fontSize: 12),
              ),
            ]
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 38,
                  child: OutlinedButton(

                    onPressed: () => {
                    Get.toNamed(Routes.userEdit,),
                    },
                    child: Text('프로필 편집', //isFollowed
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        )),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3)),
                      side: BorderSide(
                        width: 1,
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),

        ],
      ),
    );
  }
}
