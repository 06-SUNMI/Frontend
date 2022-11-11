class Challenge{
  int challengeId;
  String challengeName;
  DateTime startDate;
  DateTime endDate;

  Challenge({
    required this.challengeId,
    required this.challengeName,
    required this.startDate,
    required this.endDate
  });

  factory Challenge.fromJson(Map<String, dynamic> json){
    return Challenge(
        challengeId: json['challengeId'],
        challengeName: json['challengeName'],
        startDate: json['startDate'],
        endDate: json['endDate']
    );
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> challengeJson = Map<String, dynamic>();

    challengeJson['challengeId'] = challengeId;
    challengeJson['challengeName'] = challengeName;
    challengeJson['startDate'] = startDate;
    challengeJson['endDate'] = endDate;

    return challengeJson;
  }
}