import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunmi/routes/app_pages.dart';

import 'package:sunmi/ui/screen/sns/sns_home_screen.dart';

import '../../../routes/app_pages.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sunmi/ui/screen/routine/Setcount.dart';
import 'package:sunmi/ui/screen/sns/sns_home_screen.dart';
import 'package:sunmi/ui/screen/sns/sns_searchscreen.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({Key? key}) : super(key: key);

  @override
  _NavigatorScreenState createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int pageindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(),
      body: getbody(),
     // bottomNavigationBar: getFooter(),
    );
  }

  Widget getbody() {
    List<Widget> Screens = [
      HomeScreen(),
      /*    SearchScreen(),
      ReelScreen(),
      LikesScreen(),
      AccountScreen(),*/
    ];
    return IndexedStack(
      index: pageindex,
      children: List.generate(Screens.length, (index) => Screens[index]),
    );
  }

  PreferredSizeWidget? getAppbar() {
    if (pageindex == 0) {
      return AppBar(
        backgroundColor: Colors.purple[300],
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "EveryhHealth",
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Billabong', fontSize: 32),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                IconButton(
                  onPressed: () => Get.toNamed(Routes.searchInfo),
                  icon: Icon(Icons.search_rounded),
                  color: Colors.white,
                  iconSize: 23,

                ),
                IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.person_outline),
                  color: Colors.white,
                  iconSize: 25,
                ),
                IconButton(
                  onPressed: ()=>Get.toNamed(Routes.snsPost),
                  icon: Icon(Icons.add_box_outlined),
                  color: Colors.white,
                  iconSize: 25,
                ),
              ],
            ),
          ],
        ),
      );
    }
    AppBar(
      backgroundColor: Colors.purple[300],
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [],
      ),
    );
    return null;
  }

  SelectTab(index) {
    setState(() {
      pageindex = index;
    });
  }
}
