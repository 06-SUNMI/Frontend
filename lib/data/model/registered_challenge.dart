class RegisteredChallenge {
  int challengeId;
  String challengeName;
  DateTime startDate;
  DateTime endDate;
  int progressRate;
  int participationFee;
  int participatedNum;
  int numPerWeek;
  String challengeParticipantStatus;
  String imagePath;


  RegisteredChallenge({
    required this.challengeId,
    required this.challengeName,
    required this.startDate,
    required this.endDate,
    required this.progressRate,
    required this.participationFee,
    required this.participatedNum,
    required this.numPerWeek,
    required this.challengeParticipantStatus,
    required this.imagePath,
  });

  factory RegisteredChallenge.fromJson(Map<String, dynamic> json){
    return RegisteredChallenge(
      challengeId: json['challengeId'],
      challengeName: json['name'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      progressRate: json['progressRate'],
      participationFee: json['participationFee'],
      participatedNum: json['participationNum'],
      numPerWeek: json['numPerWeek'],
      challengeParticipantStatus: json['challengeParticipantStatus'],
      imagePath: 'assets/images/burpee.png',
    );
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> registeredChallengeJson = Map<String, dynamic>();

    registeredChallengeJson['challengeId'] = challengeId;
    registeredChallengeJson['name'] = challengeName;
    registeredChallengeJson['startDate'] = startDate;
    registeredChallengeJson['endDate'] = endDate;
    registeredChallengeJson['participationFee'] = participationFee;
    registeredChallengeJson['participationNum'] = participatedNum;
    registeredChallengeJson['numPerWeek'] = numPerWeek;

    return registeredChallengeJson;
  }
}