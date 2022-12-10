import 'package:get/get.dart';
import 'package:sunmi/binding/challenge_auth_binding.dart';
import 'package:sunmi/binding/sns_post_binding.dart';
import 'package:sunmi/binding/sns_user_routine_binding.dart';

import 'package:sunmi/binding/workout_binding.dart';
import 'package:sunmi/ui/screen/add_person_info.dart';
import 'package:sunmi/ui/screen/challenge/challenge_auth_page.dart';
import 'package:sunmi/ui/screen/challenge/challenge_auth_photo_info_page.dart';
import 'package:sunmi/ui/screen/challenge/challenge_auth_photos_page.dart';
import 'package:sunmi/ui/screen/challenge/challenge_inforout.dart';
import 'package:sunmi/ui/screen/challenge/registered_challenge_info_page.dart';
import 'package:sunmi/ui/screen/login_view.dart';
import 'package:sunmi/ui/screen/pay_page.dart';
import 'package:sunmi/ui/screen/routine/Setcount.dart';
import 'package:sunmi/ui/screen/routine/workout_select_page.dart';
import 'package:sunmi/binding/home_binding.dart';
import 'package:sunmi/ui/screen/sns/sns_post_page.dart';
import 'package:sunmi/ui/screen/user_info_edit_page.dart';
import '../binding/challenge_info_binding.dart';
import '../binding/sns_binding.dart';
import '../data/model/workout.dart';
import 'package:sunmi/ui/screen/challenge/challenge_infomation.dart';
import 'package:sunmi/binding/registered_challenge_binding.dart';
import '../ui/screen/sns/sns_account_screen.dart';
import '../ui/screen/sns/sns_followuserpage.dart';
import '../ui/screen/sns/sns_searchscreen.dart';
import '../ui/widget/sns/sns_postitems.dart';
import 'homepage.dart';
import 'package:sunmi/ui/screen/challenge/challenge_date.dart';
import 'package:sunmi/binding/challenge_date_binding.dart';


part 'app_routes.dart';

class AppPages {
  static final pages =[
    GetPage(name: Routes.initial, page: ()=> HomePage(), binding: HomeBinding()),
    GetPage(name: Routes.workoutSelect, page: ()=> WorkoutPage(), binding: WorkoutBinding()),
    GetPage(name: Routes.routineRegister, page: ()=>Setcount()),
    GetPage(name: Routes.challengeInfo, page: ()=> ChallengeCheck()),
    GetPage(name: Routes.registeredChallengeInfo, page: ()=> RegisteredChallengeInfoPage(),binding: RegisteredChallengeBinding()),
    GetPage(name: Routes.challengeAuth, page: ()=>ChallengeAuthPage(), binding: ChallengeAuthBinding()),
    GetPage(name: Routes.challengeAuthPhotos, page: ()=>ChallengeAuthPhotosPage()),
    GetPage(name: Routes.challengeAuthPhotoInfo, page: ()=>ChallengeAuthPhotoInfoPage()),
     GetPage(name: Routes.challengeDate, page: ()=>ChallengeDatePage(), binding: ChallengeDateBinding()),
    GetPage(name: Routes.challengeRoutInfo, page: ()=>ChallengeInfoRoutine(), binding: ChallengeInfoBinding()),
    GetPage(name: Routes.login, page: ()=>LoginPage()),
    GetPage(name: Routes.addInfo, page: ()=>AddInfo()),
    GetPage(name: Routes.snsPost, page: ()=> SNSPostPage(), binding: SNSPostBinding()),
    GetPage(name: Routes.searchInfo, page: ()=>SearchScreen(), binding: ChallengeInfoBinding()),
    GetPage(name: Routes.userfollowpage, page: ()=>SNSFollowUser(), binding: SNSRoutineBinding(),),
    GetPage(name: Routes.pay, page: ()=>Payment()),
    GetPage(name: Routes.snsPage, page: ()=>PostItems(), binding: SNSBinding()),
    GetPage(name: Routes.userEdit, page: ()=>UserInfoEditPage()),
    GetPage(name: Routes.accountPage, page: ()=>AccountScreen())
  ];
}

