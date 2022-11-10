import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChallengeListPage extends StatelessWidget {
  ChallengeListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('챌린지 리스트 페이지'),
      ),
      body: GetX<ChallengeController>(
        init: Get.put(ChallengeController(challengeRepository: ChallengeRepository(challengeProvider: ChallengeProvider()))),
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
                        tabs: [challengeTab(), registeredChallengeTab()]),
                  ),
                  Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: TabBarView(
                          children: [challengeListView(), registeredChallengeListView()],
                        ),
                      )
                  ),
                ]
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

challengeListView() {
  return Expanded(
      child: ListView.separated(
        //shrinkWrap: true,
        itemCount: Get.find<ChallengeController>().challenges.length ,
        itemBuilder: (context, index) {
          return InkWell(
            child: Row(
              children: [
                Image.asset(
                  'assets/images/checkimage.png',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                Column(
                  children: [
                    Text(
                        '${Get.find<ChallengeController>().challenges[index].challengeName}'),
                    Text(
                        '${Get.find<ChallengeController>().challenges[index].startDate}'
                            '\nto ${Get.find<ChallengeController>().challenges[index].endDate}'),
                  ],
                )
              ],
            ),
            onTap: ()=>Get.find<ChallengeController>().challengeDetails(index),
          );},
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.black,
            thickness: 1.0,
          );
        }
      )
  );
}

registeredChallengeListView(){
  return Expanded(
      child: ListView.separated(
        //shrinkWrap: true,
        itemCount: Get.find<ChallengeController>().registeredChallenges.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: ()=>Get.find<ChallengeController>().registeredChallengeDetails(index),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  'assets/images/checkimage.png',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                Column(
                    children: [
                      Text(
                          '${Get.find<ChallengeController>().registeredChallenges[index].challengeName}'),
                      Text(
                          '${Get.find<ChallengeController>().registeredChallenges[index].startDate}'
                              '\nto ${Get.find<ChallengeController>().registeredChallenges[index].endDate}'),
                    ]
                )
              ],
            ),
          );},
        separatorBuilder: (context, index){
          return const Divider(
            color: Colors.black,
            thickness: 1.0,
          );
        }
      )
  );
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
>>>>>>> Stashed changes
  }
}