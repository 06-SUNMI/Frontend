import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunmi/controller/user_info_controller.dart';

class UserInfoEditPage extends GetView<UserInfoController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("정보 수정 페이지"),
      ),
      body: Column(
        children: [
          //Padding(padding: EdgeInsets.only(top: 50.0),),
          Container(
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 248, 251),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.pink,
              ),
              boxShadow: [BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
                spreadRadius: 3.0,
              ),],
            ),
            child: Center(
              child: Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 20.0),),
                  CircleAvatar(
                    radius: 40.0,
                    child :ClipOval(child: Image.network(controller.image),),
                  ),
                  Padding(padding: EdgeInsets.only(left: 30.0),),
                  Column(
                    children: [
                      Text(controller.name, style: TextStyle(fontSize: 25.0,),),
                    ],
                  )
                ],
              ),
            ),
          ),
          
          Container(
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 248, 251),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.pink,
              ),
              boxShadow: [BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
                spreadRadius: 3.0,
              ),],
            ),
            child: Column(
              children: [
                TextField(
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
                TextField(
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
                TextField(
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
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}