import 'package:get/get.dart';
import 'package:sunmi/data/model/registered_challenge.dart';

String _baseURL = 'http://15.164.168.230:8080';

class RegisteredChallengeProvider extends GetConnect{
  Future<Response> getRegisteredChallenges(int memberId) => get('$_baseURL/challenges/members/$memberId');

  getAllByMemberId(int memberId) async {
    var registeredChallengesResponse = await getRegisteredChallenges(memberId);
    final registeredChallengesJson = registeredChallengesResponse.body as List;
    final List<RegisteredChallenge> registeredChallenges = registeredChallengesJson.map(
            (challenge) => RegisteredChallenge.fromJson(challenge)).toList();
    return registeredChallenges;
  }

  getById(int challengeId, int memberId){

  }
}