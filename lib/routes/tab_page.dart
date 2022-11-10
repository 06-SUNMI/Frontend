import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunmi/controller/tap_page_controller.dart';
import 'package:sunmi/ui/screen/challenge_date.dart';
import 'package:sunmi/ui/screen/routine_calendar.dart';


class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  final TabPageController _tabPageCtrl = Get.put(TabPageController());
  List pages = [
    const RoutinePage(),
    const ChallengeDatePage(),
    const TempPage(),
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
    )
    );
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
