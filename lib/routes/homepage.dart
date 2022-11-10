import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunmi/controller/home_controller.dart';
import 'package:sunmi/ui/screen/challenge_date.dart';
import 'package:sunmi/ui/screen/challenge_infomation.dart';
import 'package:sunmi/ui/screen/routine_calendar.dart';
import 'package:sunmi/ui/screen/sns_navigator.dart';

import '../ui/screen/challenge_list_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _tabPageCtrl = Get.put(HomeController());
  List pages = [
    const RoutinePage(),
    ChallengeListPage(),
    const NavigatorScreen(),
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

class TempPage extends StatelessWidget {
  const TempPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SNS Temp Page'),),
      body: Center(
        child: Text('sns temp page'),
      ),
    );
  }
}
