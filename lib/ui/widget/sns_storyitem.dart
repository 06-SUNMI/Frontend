import 'package:flutter/material.dart';


class StoryItem extends StatelessWidget {
  const StoryItem({
    required this.storyname,
    required this.storyimg,
    Key? key,
  }) : super(key: key);
  final String storyname; //storys[index]['image']
  final String storyimg; //storys[index]['name'],

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10.0),
      child: Column(
        children: [
          Container(
            height: 67,
            width: 67,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [Colors.purpleAccent, Colors.yellow],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter

                )

            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple, width: 2),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(storyimg), fit: BoxFit.cover)),
                  child: InkWell(
                    onTap: () {
                      print('$storyname');
                  },
                ),
              ),
            ),

          ),
          SizedBox(
            height: 7,
          ),
          Text(
            storyname,
            style: TextStyle(
                overflow: TextOverflow.ellipsis, color: Colors.black, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
