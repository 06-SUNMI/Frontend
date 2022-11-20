import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../data/model/challenge.dart';
import 'challenge_inforout.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sunmi/ui/screen/challenge/challenge_date.dart';
import 'package:sunmi/ui/screen/challenge/challenge_date.dart';
import 'package:sunmi/routes/app_pages.dart';
import 'package:sunmi/data/model/challenge.dart';
import 'package:sunmi/data/model/registered_challenge.dart';
import 'package:sunmi/data/repository/registered_challenge_repository.dart';
import 'package:sunmi/ui/widget/challenge/registered_challenge_progress.dart';
import 'package:sunmi/controller/registered_challenge_info_controller.dart';


class ChallengeCheck extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var challenges_data = Get.arguments["challenge"];
    var _startdays =  challenges_data.startDate;
    var _enddays = challenges_data.endDate;
    String startdays = "${_startdays.year}-${_startdays.month}-${_startdays.day}";
    int _selectcays = challenges_data.numPerWeek;
    int _peoples = challenges_data.participatedNum;
    int _id = challenges_data.challengeId;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("everyhealth")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 50, // 높이 설정
              color: Colors.white,
              child: Text("함께하는 공식 챌린지 \n",style: TextStyle(fontSize: 20, fontFamily: 'Signatra',fontWeight: FontWeight.normal,color: Colors.blue),),
              padding: EdgeInsets.fromLTRB(15, 10,5,10),
            ),
            Container(
              color: Colors.white,
              child: Text("매주 도전하는", style: TextStyle(fontSize: 35,fontFamily: 'Signatra', fontWeight: FontWeight.bold),),
              padding: EdgeInsets.fromLTRB(30, 0,0,0),
            ),
            Container(
              color: Colors.white,
              child: Text.rich(
                  TextSpan(
                      text: '주 $_selectcays 일',
                      style: TextStyle(fontSize: 50,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, color: Colors.redAccent,),
                      children: <TextSpan> [
                        TextSpan(
                             text: '  루틴 챌린지 ',
                              style: TextStyle(fontSize: 35,fontFamily: 'Signatra', fontWeight: FontWeight.bold,color: Colors.black,)
                         ),
                      ]
                  ),
                ),
                padding: EdgeInsets.fromLTRB(100, 0,0,0)
            ),
            Container(
              color: Colors.white,
              height: 30, // 높이 설정
              padding: EdgeInsets.fromLTRB(0,0,25,0),
              child: Text("기간 : $startdays  부터 시작, "+"4 주 동안 진행 ", style: TextStyle(fontSize: 12,fontFamily: 'Signatra',
                  fontWeight: FontWeight.bold),textAlign: TextAlign.end,),
            ),
            Container(
              color: Colors.white,
              height: 30,
              padding: EdgeInsets.fromLTRB(0,0,25,0), // 높이 설정
              child: Text("누적 참여자 수 :"+" $_peoples 명", style: TextStyle(fontSize: 20,fontFamily: 'Signatra',
                  fontWeight: FontWeight.bold,color: Colors.deepPurple),textAlign: TextAlign.end),
            ),
            Container(
              child: Center(
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children : <Widget>[
                      Image.asset('assets/images/challenge.png',fit: BoxFit.scaleDown),
                    ],
                  )
              ),
              color: Colors.white,
            ),
            Container(
              height: 50,
              child: TextButton(
                child:Text("루틴 미리 살펴보기 >",style: TextStyle(fontSize: 15,fontFamily: 'Signatra',fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.left,),
                onPressed: () async{
                  Get.toNamed(Routes.challengeRoutInfo, arguments: {'challenge': challenges_data});
                //   Get.to(() => ChallengeRoutine());//arguments: {'challenge': 'challenges_data'}
                },
              ),
            ),
            SizedBox(
                      width:double.infinity,
                       height: 80,

                       child: ElevatedButton(
                          child:Text("신청하기", style: TextStyle(fontSize: 25,fontFamily: 'Signatra',fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                          onPressed: (){
                            // String enddays = "${_enddays.year}-${_enddays.month}-${_enddays.day}";
                            //
                            Get.toNamed(Routes.challengeDate, arguments: {"challengeId":_id,"start_date" : DateTime(_startdays.year, _startdays.month, _startdays.day), "end_date" : DateTime(_enddays.year, _enddays.month, _enddays.day)});
                          },
                        ),
            ),

          ],
        ),
      ),
    );

  }

}