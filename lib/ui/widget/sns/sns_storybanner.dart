import 'package:flutter/material.dart';
import 'package:sunmi/data/storys.dart';

import 'package:sunmi/ui/widget/sns/sns_storyitem.dart';

class StoryBanner extends StatelessWidget {
  const StoryBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Row(
        children: [
          Row(
            children: List.generate(storys.length, (index) {
              return StoryItem(
                storyimg: storys[index]['image'],
                storyname: storys[index]['name'],
              );
            }),
          ),
        ],
      ),
    );
  }
}
