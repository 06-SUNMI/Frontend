import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sunmi/controller/challenges_controller.dart';
import 'package:sunmi/ui/widget/challenge/challenge_list_view.dart';

class ChallengeListPage extends GetView<ChallengeController> {
  ChallengeListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('챌린지 리스트 페이지'),
      ),
      body: GetX<ChallengeController>(
        builder: (challengeController) {
          print(challengeController.challenges.length);
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Column(
                children: [
                  Container(
                    color: Colors.grey,
                    child: TabBar(
                        labelColor: Colors.black,
                        indicator: const BoxDecoration(color: Colors.white),
                        tabs: [challengeTab(), registeredChallengeTab()]
                    ),
                  ),
                  Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TabBarView(
                          children: [challengeListView(), registeredChallengeListView()],
                        ),
                      )
                  ),]
              )
            ),
          );},
      ),
    );
  }
}

challengeTab(){
  return Tab(text: '신청가능한 챌린지');
}

registeredChallengeTab(){
  return Tab(text: '신청한 챌린지',);
}

class RegisteredChallengeDetailsPage extends StatelessWidget{
  RegisteredChallengeDetailsPage({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
          child: InkWell(
            onTap: () => Get.back(),
            child: Text('신청한 챌린지 ${Get.arguments['index']}의 상세정보 '),
          )
      ),
    );
  }
}