class Challenge{
  int challengeId;
  String challengeName;
  DateTime startDate;
  DateTime endDate;
  int participationFee;
  int participatedNum;
  int numPerWeek;
  String imagePath;

  Challenge({
    required this.challengeId,
    required this.challengeName,
    required this.startDate,
    required this.endDate,
    required this.participationFee,
    required this.participatedNum,
    required this.numPerWeek,
    required this.imagePath,
  });

  factory Challenge.fromJson(Map<String, dynamic> json){
    return Challenge(
      challengeId: json['challengeId'],
      challengeName: json['name'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      participationFee: json['participationFee'],
      participatedNum: json['participationNum'],
      numPerWeek: json['numPerWeek'],
      imagePath: 'assets/images/challenge_routine.jpg',
    );
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> challengeJson = Map<String, dynamic>();

    challengeJson['challengeId'] = challengeId;
    challengeJson['name'] = challengeName;
    challengeJson['startDate'] = startDate;
    challengeJson['endDate'] = endDate;
    challengeJson['participationFee'] = participationFee;
    challengeJson['participationNum'] = participatedNum;
    challengeJson['numPerWeek'] = numPerWeek;

    return challengeJson;
  }
}