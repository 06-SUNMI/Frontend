import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;


import '../../../controller/sns_search_controller.dart';
import '../../../routes/app_pages.dart';




class SearchScreen extends GetView<SearchController> {
  TextEditingController tea = TextEditingController();
  FocusNode focusNode = FocusNode();
  final String _searchText = "";
  int ck=0;
  bool _isChecked = false;
  int len=0;
  final Rxn<int> selected = Rxn<int>();
  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Get.put(SearchController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("검색"),
        backgroundColor: Colors.purple[300],
      ),
    body : SafeArea(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.purple[100],
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
              child: Container(
                width: double.infinity - 30,
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: TextField(
                  controller: tea,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: '검색',
                      hintStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.purpleAccent.withOpacity(0.5)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.purpleAccent.withOpacity(0.8),
                      ),
                  ),
                  style: TextStyle(color: Colors.black.withOpacity(0.4)),
                ),
              ),
            ),
          ),
        Container(

            color: Colors.purple[100],

            child: Row(
            mainAxisAlignment: MainAxisAlignment.end,

            children:[
              TextButton(
                onPressed: () { ck=_ckone(ck);print(ck); },
                child: Text("같은 헬스장 검색"),
                style: TextButton.styleFrom( primary: Colors.blue, ),
              ),
              ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[300],
                      minimumSize: const Size(80, 40),
                      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
                    icon: Icon(Icons.send),
                    onPressed: () async {
                   //   ck = 1;
                      if(ck==0) {
                        controller.getSearch(tea.text);
                      }
                      else{
                        controller.gymgetSearch(tea.text);
                      }
                    }, label: Text("Search"),
              ),
            ],
          ),
        ),
          SizedBox(
              child: Obx(() =>
                  Column(
                      children: [
                    // if(ck==0)...[
                          for (int i = 0; i < controller.list.length; i++) ...[
                            Obx(() =>
                                ListTile(
                                  leading: Icon(Icons.people_alt_outlined),
                                  title: Text(controller.list[i]["name"].toString()),
                                  tileColor: Colors.purple[50],
                                  onTap: () {
                                    Get.toNamed(Routes.userfollowpage, arguments: {'name': controller.list[i]["name"].toString(), 'id':  controller.list[i]["id"],
                                      'gymName' :  controller.list[i]["gymName"], 'customProfileImageUrl' :  controller.list[i]["customProfileImageUrl"]} );
                                  },
                                ),
                            ),
                          ]
                      /*  ]
                        else if(ck==1)...[
                          for (int i = 0; i < controller.list.length; i++) ...[
                            if(controller.list[i]["gymName"] == '나이스짐')...[
                            //  Obx(() =>
                                  ListTile(
                                    leading: Icon(Icons.people_alt_outlined),
                                    title: Text(controller.list[i]["name"].toString()),
                                    tileColor: Colors.purple[50],
                                    onTap: () {
                                      Get.toNamed(Routes.userfollowpage, arguments: {'name': controller.list[i]["name"].toString(), 'id':  controller.list[i]["name"],
                                        'gymName' :  controller.list[i]["gymName"], 'customProfileImageUrl' :  controller.list[i]["customProfileImageUrl"]} );
                                    },
                                  ),
                            //  ),
                            ]
                            else...[]
                          ],
                          ck=_ckset(ck),
                        ],
*/
                      ]

                  )
              )
          ),
          Expanded(
            child: Container(
              color: Colors.purple[100],
            ),
          ),
        ]
      )
    ),
    );
  }
   _ckset(int ck) {
    ck=0;
    return ck;
  }
   _ckone(int ck) {
     ck=1;
    return 1;
  }
}
