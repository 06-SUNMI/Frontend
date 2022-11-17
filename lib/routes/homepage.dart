import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunmi/controller/home_controller.dart';
import 'package:sunmi/ui/screen/challenge/challenge_date.dart';
import 'package:sunmi/ui/screen/routine/routine_calendar_page.dart';
import 'package:sunmi/ui/screen/sns/sns_navigator.dart';
import 'package:sunmi/routes/app_pages.dart';

import '../ui/screen/challenge/challenge_list_page.dart';


class HomePage extends StatelessWidget {

  final HomeController _tabPageCtrl = Get.put(HomeController());

  List pages = [
    RoutineCalendar(),
    ChallengeListPage(),
    const NavigatorScreen(),
  ];

  List homeRoutes = [
    Routes.workoutSelect,
    Routes.challengeInfo,
    Routes.workoutSelect,
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
      body: pages[_tabPageCtrl.curPage.toInt()],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _tabPageCtrl.changeCurPage, 
        selectedItemColor: Color.fromRGBO(147,125,194,1),
        currentIndex: _tabPageCtrl.curPage.toInt(),
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'routine',),
        BottomNavigationBarItem(icon: Icon(Icons.local_fire_department), label: 'challenge',),
        BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'community',),
      ]),
    ));
  }
}