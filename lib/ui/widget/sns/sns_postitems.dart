import 'package:flutter/material.dart';

import 'package:sunmi/data/post.dart';



class PostItems extends StatefulWidget {

  const PostItems({
    Key? key,
  }) : super(key: key);

  @override
  State<PostItems> createState() => _PostItemsState();
}

class _PostItemsState extends State<PostItems> {
  bool temp =false;
  @override
  Widget build(BuildContext context) {

    int favindex = 0;
    int index = 0;

    List favicon = [
      favindex == index ? (Icon(Icons.favorite, color: Colors.black26))
          : Icon(Icons.favorite,color: Colors.red,)
    ];

    return Column(
        children: List.generate(

          posts.length,
              (index) {
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
                                      image:
                                      NetworkImage(posts[index]['profileImg']),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              posts[index]['name'],
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
                            image: NetworkImage(posts[index]['postImg']),
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
                              color:  posts[index]['isLoved']==false? Colors.black26: Colors.redAccent,
                              iconSize: 25,
                              onPressed: (){
                                posts[index]['isLoved'] =!posts[index]['isLoved'];
                                print("as");
                                //favindex = 1;
                                setState((){});
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
                                text: posts[index]['likedBy'] == null
                                    ? ''
                                    : posts[index]['likedBy'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                              TextSpan(
                                text:
                                posts[index]['likedBy'] == null ? '' : '님 외 ',
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                    fontSize: 14),
                              ),
                              TextSpan(
                                text: posts[index]['Likescount'],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                              TextSpan(
                                text: posts[index]['likedBy'] == null
                                    ? ''
                                    : '명이 좋아합니다',
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
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
                                text: '${posts[index]['name']}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              ),
                              TextSpan(
                                text: '${posts[index]['caption']}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "댓글 ${posts[index]['commentCount']}개 모두 보기",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          posts[index]['timeAgo'],
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
