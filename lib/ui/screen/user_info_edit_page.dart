

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sunmi/controller/user_info_controller.dart';

import '../../routes/app_pages.dart';

class UserInfoEditPage extends GetView<UserInfoController> {

  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController gymController = TextEditingController();
  late int gymId;
  late String gymName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("정보 수정 페이지"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [ 
            Padding(padding: EdgeInsets.only(top: 20.0),),
            CircleAvatar(
              radius: 50.0,
              child :ClipOval(child: Image.network(controller.image),),
            ),
            Padding(padding: EdgeInsets.only(top: 10.0),),
            Text(controller.name, style: TextStyle(fontSize: 25.0,),),
              
            
            Container(
              margin: EdgeInsets.only(top: 20.0),
              width: 280,
              child : TextField(
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
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              width: 280,
              child :
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
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child :
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 230,
                      child:  TextField(
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
                  ],
                ),
            ),
                        
                      
                    Obx(()=>
                    Container(
                      width: controller.gymList.length==0?0:280,
                    child : SingleChildScrollView(
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
                    ),),
                    ), 

              TextButton(onPressed: (){
                if(heightController.text!=""&& weightController.text!=""&& controller.isGymSelected==1){
                  controller.putUserData(heightController.text, weightController.text);
                  Get.back();
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
    );
  }
}