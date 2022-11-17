import 'dart:convert';
import 'package:sunmi/data/model/challenge.dart';
import 'package:get/get.dart';

String _baseURL = 'http://15.164.168.230:8080';

class ChallengeProvider extends GetConnect{
  Future<Response> getChallenges()=>get(_baseURL+'/challenges');
  
  getAll() async{
    var challengeResponse = await getChallenges();
    final challengeJson = challengeResponse.body as List;
    final List<Challenge> challengesFromHttp = challengeJson.map(
            (challenge) => Challenge.fromJson(challenge)).toList();
    return challengesFromHttp;
  }
}
