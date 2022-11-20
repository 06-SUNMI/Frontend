import 'package:get/get.dart';
import 'package:sunmi/data/model/registered_challenge.dart';

import 'url.dart' as url;

class RegisteredChallengeProvider extends GetConnect{
  Future<Response> getRegisteredChallenges(int memberId) => get('${url.baseURL}/challenges/members/$memberId');

  getAllByMemberId(int memberId) async {
    var registeredChallengesResponse = await getRegisteredChallenges(4);
    final registeredChallengesJson = registeredChallengesResponse.body as List;
    final List<RegisteredChallenge> registeredChallenges = registeredChallengesJson.map(
            (challenge) => RegisteredChallenge.fromJson(challenge)).toList();
    return registeredChallenges;
  }
}