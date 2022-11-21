
import 'package:sunmi/data/provider/challenge_auth_provider.dart';

class ChallengeAuthRepository{
  final ChallengeAuthProvider challengeAuthProvider;

  ChallengeAuthRepository({
    required this.challengeAuthProvider
  });

  authChallenge(challengeRoutineId, memberRoutineId, image){
    return challengeAuthProvider.authChallenge(challengeRoutineId, memberRoutineId, image);
  }
}