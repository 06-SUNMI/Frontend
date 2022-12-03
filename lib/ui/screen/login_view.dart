import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:get/get.dart';
import 'package:sunmi/routes/app_pages.dart';
import 'package:sunmi/controller/user_info_controller.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  
  @override
  Widget build(BuildContext context) {
        Get.put(UserInfoController());

    final mainLogin = MainLogin(Kakao());
    return  Scaffold(
          body: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 100.0)),
              Center(
                child: Image(image: AssetImage("assets/images/eh.png")),
              ),
               GetBuilder<UserInfoController>(
                  builder: (controller) {
                    return TextButton(onPressed: () async{
                        await mainLogin.login();
                        print(mainLogin.user);
                        if(await controller.isNew(mainLogin.user!.id)==true){
                          controller.setName(mainLogin.user!.properties!["nickname"]);
                          controller.setMail(mainLogin.user!.kakaoAccount!.email);
                          Get.toNamed(Routes.addInfo);
                        }
                        else{
                          controller.getUserData();
                          Get.toNamed(Routes.initial);
                        }
                      }, 
                        child: Image(image: AssetImage("assets/images/kakao_login_medium_narrow.png"),
                      ),
                    );
                  }
               ),
            ],
          )
    );
  }
}

class Kakao implements SocialLogin{

  @override
  Future<bool> login() async{
    try{
      print("isKakaoTalkInstalled");
      bool isInstalled = await isKakaoTalkInstalled();
      if(isInstalled){
        try {
          await UserApi.instance.loginWithKakaoTalk();
          return true;
        } catch (e) {
          return false;
        }
      }
      else{
        try {
          print("login");
          await UserApi.instance.loginWithKakaoAccount();
          return true;
        } catch (e) {
          return false;
        }
      }
    }catch (e) {
        return false;
    }
  }

  @override
  Future<bool> logout() async{
    try {
      await UserApi.instance.unlink();
      return true;
    } catch (error) {
      return false;
    }
  }
}

class MainLogin{
  final SocialLogin _socialLogin;
  bool isLogined = false;
  User? user;
  MainLogin(this._socialLogin);

  Future login() async{
    isLogined = await _socialLogin.login();
    if(isLogined){
      user = await UserApi.instance.me();
    }
  }

  Future logout() async{
    await _socialLogin.logout();
    isLogined = false;
    user = null;
  }

}

abstract class SocialLogin {
  Future<bool> login();

  Future<bool> logout();
}