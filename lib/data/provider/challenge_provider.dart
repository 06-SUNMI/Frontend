import 'package:sunmi/data/model/challenge.dart';
import 'package:get/get.dart';

import 'url.dart' as url;

class ChallengeProvider extends GetConnect{
  Future<Response> getChallenges()=>get(url.baseURL+'/challenges');
  
  getAll() async{
    var challengeResponse = await getChallenges();
    final challengeJson = challengeResponse.body as List;
    final List<Challenge> challengesFromHttp = challengeJson.map(
            (challenge) => Challenge.fromJson(challenge)).toList();
    return challengesFromHttp;
  }
}
