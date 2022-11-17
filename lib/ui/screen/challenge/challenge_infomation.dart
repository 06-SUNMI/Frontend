import 'package:flutter/material.dart';
import 'challenge_inforoutine.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sunmi/ui/screen/challenge/challenge_date.dart';
import 'package:sunmi/ui/screen/challenge/challenge_inforoutine.dart';
import 'package:sunmi/ui/screen/challenge/challenge_date.dart';
import 'package:sunmi/routes/app_pages.dart';

class ChallengeCheck extends StatelessWidget {
  var _selectcays = Get.arguments;

  @override
  Widget build(BuildContext context) {
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
              height: 50, // 높이 설정
              child: Text("기간 : 11월 28일 ~ 12월 26일 "+"주 $_selectcays 일, 한 달 동안 진행 ", style: TextStyle(fontSize: 12,fontFamily: 'Signatra',
                  fontWeight: FontWeight.bold),textAlign: TextAlign.end,),
              padding: EdgeInsets.all(10),
            ),
            Container(
              color: Colors.white,
              height: 50, // 높이 설정
              child: Text("참여자 수 "+"n명", style: TextStyle(fontSize: 15,fontFamily: 'Signatra',
                  fontWeight: FontWeight.bold,color: Colors.blue),),
              padding: EdgeInsets.fromLTRB(30, 0,0,0),
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
                   Get.to(() => ChallengeRoutine(), arguments: {'numPerWeek': '${_selectcays}'});
                },
              ),
            ),
            SizedBox(
                      width:double.infinity,
                       height: 80,

                       child: ElevatedButton(
                          child:Text("신청하기", style: TextStyle(fontSize: 25,fontFamily: 'Signatra',fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                          onPressed: (){
                            Get.toNamed(Routes.challengeDate, arguments: {"start_date" : DateTime(2022, 11, 11), "end_date" : DateTime(2022, 11, 25)});

                          },
                        ),
            ),

          ],
        ),
      ),
    );

  }

}