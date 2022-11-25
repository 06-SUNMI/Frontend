import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sunmi/controller/user_info_controller.dart';
import 'package:sunmi/routes/app_pages.dart';


class AddInfo extends StatelessWidget {
  const AddInfo({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserInfoController());

    TextEditingController heightController = TextEditingController();
    TextEditingController weightController = TextEditingController();
    TextEditingController gymController = TextEditingController();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("추가 정보 입력"),
      ),

      body: Center(
        child: Padding(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: heightController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: Colors.purple),
                    ),
                    hintText: '키',
                  ),
                  keyboardType: TextInputType.number,
                ),
                Padding(padding: EdgeInsets.only(top: 10.0)),
                TextField(
                  controller: weightController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: Colors.purple),
                    ),
                    hintText: '몸무게',
                  ),
                  keyboardType: TextInputType.number,
                ),
                Padding(padding: EdgeInsets.only(top: 20.0),),

                TextField(
                  controller: gymController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: Colors.purple),
                    ),
                    hintText: '헬스장',
                  ),
                  keyboardType: TextInputType.text,
                ),
                Padding(padding: EdgeInsets.only(top: 20.0),),
                GetBuilder<UserInfoController>( 
                  builder: (controller) {
                    return TextButton(
                      child: Text('확인'),
                      onPressed: () {
                        controller.setUser(heightController.text, weightController.text, gymController.text);
                        Get.toNamed(Routes.initial);
                      },
                   );
                  },
                ),
              ],
            ),
          ),
          padding: EdgeInsets.all(20.0),
        ),
      ),
    );
  }
}