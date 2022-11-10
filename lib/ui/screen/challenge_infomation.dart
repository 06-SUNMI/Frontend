import 'package:flutter/material.dart';
import 'package:sunmi/main.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

////// Tempbutton = 챌린지 목록 확인 임의로 만들어 둔 페이지, 나중에 지울게요
class Tempbutton extends StatelessWidget{
  // late Sdays selectdays;

  String _selectcays = "3";

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('challenge'),
      ),
      body: Container(
        child: Column(
          children: [
            TextButton(
              onPressed: () async{
                _selectcays = "3";
                Get.to(() => Challendge_check(), arguments: _selectcays);
              },
              child: Text("주3회 챌린지"),
              style: TextButton.styleFrom(
                primary: Colors.blueGrey,
              ),
            ),
            TextButton(
              onPressed: () async{
                _selectcays= "5";
                Get.to(() => Challendge_check(), arguments: _selectcays);
              },
              child: Text("  주5회 챌린지"),

            ),

          ],
        ),
      ),
    );
  }
}





class Challendge_check extends StatelessWidget {
  var _selectcays = Get.arguments;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("everyhealth")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Center(
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children : <Widget>[
                      //makeImage(BoxFit.scaleDown),
                      Image.asset('images/challenge.png',fit: BoxFit.scaleDown),
                    ],
                  )
              ),
              // height: 300,
              color: Colors.white,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 200, // 가로 설정
                    height: 200, // 높이 설정
                    color: Colors.white,
                    child: Text("11월 28일 ~ 12월 26일 \n"+"주 $_selectcays 일, 한 달 동안 ", style: TextStyle(fontSize: 13,fontFamily: 'Signatra',
                        fontWeight: FontWeight.normal),textAlign: TextAlign.center,),
                    padding: EdgeInsets.all(12),
                  ),
                  SizedBox(
                    child : Container(
                      color: Colors.white,
                      child: ElevatedButton(
                        //   child:
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            primary: Colors.red,
                            onPrimary: Colors.white,
                            minimumSize: Size(300,100),

                            alignment: Alignment.center,
                            textStyle: const TextStyle(fontSize: 30)
                        ),
                        child:Text("신청하기"),
                        onPressed: (){
                          Get.to(() => TempPage(), arguments: _selectcays);
                          Colors.green;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    //Center(child: Text("$selectdays"),),
    //  body: hallendge_checkpage(selectdays),

    // );

  }

}

//다음 페이지
class TempPage extends StatelessWidget{
  var _selectcays = Get.arguments;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Text(
              '주 ${_selectcays}일 날짜 선택 페이지입니다.'
          ),
        ),
      ),
    );
  }
}