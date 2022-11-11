import 'package:flutter/material.dart';
import 'package:sunmi/ui/widget/sns/sns_postitems.dart';
import 'package:sunmi/ui/screen/sns/sns_navigator.dart';

import 'package:sunmi/ui/widget/sns/sns_storybanner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFE6F7),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            StoryBanner(),
            Divider(
              height: 1,
              color: Colors.white.withOpacity(0.2),
            ),
            PostItems(),
          ],
        ),
      ),
    );
  }
}
