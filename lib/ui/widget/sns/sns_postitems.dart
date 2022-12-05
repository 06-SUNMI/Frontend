import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import 'package:sunmi/data/post.dart';

import '../../../controller/sns_controller.dart';


class PostItems extends GetView<SnsController> {
  const PostItems({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SnsController());
    //in= controller.counts() as int;
    int favindex = 0;
    int index = 0;
    List favicon = [
      favindex == index ? (Icon(Icons.favorite, color: Colors.black26))
          : Icon(Icons.favorite,color: Colors.red,)
    ];

    controller.onIniit();


    //print(controller.info[0]);
    //print(controller.info[1]);
    for(int i =0; i<controller.info.length; i++){
      if(controller.info[i]["memberProfilePhotoUrl"].toString()=='null'){
        controller.info[i]["memberProfilePhotoUrl"]=controller.info[i]["snsImageOrVideoLinkList"].toString();//임시 이미지
      }
    }
    return Obx(() =>Column(

        children: List.generate(

          controller.info.length, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,

                                  image: DecorationImage(
                                      image:NetworkImage(controller.info[index]["memberProfilePhotoUrl"][0]),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              controller.info[index]["memberName"],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.more_vert),
                          color: Colors.black,
                          iconSize: 25,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 400.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(controller.info[index]["snsImageOrVideoLinkList"]),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              //icon: Icon(favicon[favindex]),
                             icon: Icon(Icons.favorite),
                              color: Colors.black26,
                              iconSize: 25,
                              onPressed: (){
                                //color: controller.info[index]["favcheck"] ? 0 : Colors.black26: Colors.redAccent,
                                favcheck( controller.info[index]["snsPostId"],  controller.info[index]["memberId"]);
                                controller.increase(index);
                                //favindex = 1;

                              },

                            ),
                            SizedBox(
                              width: 20,
                            ),
                            IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.comment),
                              color: Colors.black26,
                              iconSize: 25,
                            ),
                            SizedBox(
                              width: 20,
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '좋아요  ${controller.info[index]["snsLikesNum"]} 개',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${controller.info[index]["memberName"]}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              ),
                              TextSpan(
                                text: '    ${controller.info[index]["snsContent"]}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              );

          },
        )
    ),
    );
  }
}

void favcheck(var snsPostId, var memberId) async {
  String url = 'http://15.164.168.230:8080/sns/posts/2/likes/$snsPostId/$memberId';
  http.Response _res = await http.post(
    Uri.parse(url), headers: {"content-type": "application/json"},
  );
}
