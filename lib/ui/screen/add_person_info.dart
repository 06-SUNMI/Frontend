import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sunmi/controller/user_info_controller.dart';
import 'package:sunmi/routes/app_pages.dart';


class AddInfo extends GetView<UserInfoController> {
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
                TextButton(onPressed: (){
                          if(gymController.text==""){
                            showDialog(context: context, builder: (BuildContext context){
                                  return AlertDialog(         
                                    content: Text("검색할 장소를 입력하세요"),  
                                    actions: [
                                      TextButton(onPressed: (){
                                        Get.back(); 
                                      }, child: Text("확인")),
                                    ],
                                  );
                                });
                          }else{
                            controller.searchGym(gymController.text);
                          }
                        }, child: Text("검색"),),
                Padding(padding: EdgeInsets.only(top: 20.0),),

                Obx(()=>
                    SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              for(int i=0;i<controller.gymList.length;i++)
                                ListTile(
                                  leading: controller.isGymSelected == 0 ? Icon(Icons.check_box_outline_blank): Icon(Icons.check_box),
                                  subtitle: Text(controller.gymList[i]["gymAddress"]),
                                  title: Text(controller.gymList[i]["gymName"]), 
                                  onTap: () {
                                    controller.setGym(i);
                                  },
                                ),
                            ],
                          ),
                        )
                          
                      ),
                    ),
                    ), 

                
                 
                TextButton(onPressed: (){
                  if(heightController.text!=""&& weightController.text!=""&& controller.isGymSelected==1){
                    controller.setUserData(heightController.text, weightController.text);
                    Get.toNamed(Routes.initial);
                  }
                  else if(controller.isGymSelected==1){
                    showDialog(context: context, builder: (BuildContext context){
                        return AlertDialog(         
                          content: Text("모두 입력하세요"),  
                          actions: [
                            TextButton(onPressed: (){
                              Get.back(); 
                            }, child: Text("확인")),
                          ],
                        );
                      });
                  }
                  else{
                    showDialog(context: context, builder: (BuildContext context){
                        return AlertDialog(         
                          content: Text("헬스장을 선택하세요"),  
                          actions: [
                            TextButton(onPressed: (){
                              Get.back(); 
                            }, child: Text("확인")),
                          ],
                        );
                      });
                  }
                }, child: Text("확인"),),
              ],
            ),
          ),
          padding: EdgeInsets.all(20.0),
        ),
      ),
    );
  }
}