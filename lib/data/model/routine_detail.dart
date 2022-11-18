class Routine {
  int routineDetailId;
  int? challengeRoutineId;
  String workoutName;
  int? workoutWeight;
  int? workoutCount;
  int? workoutSets;
  int? workoutTime;
  bool workoutChecked;

  Routine({
    required this.routineDetailId,
    required this.workoutName,
    required this.workoutChecked,
    this.workoutCount,
    this.workoutSets,
    this.workoutTime,
    this.workoutWeight,
    this.challengeRoutineId
  });

  factory Routine.fromJson(Map<String, dynamic> json){
    return Routine(
        routineDetailId: json['memberRoutineContentId'],
        workoutName: json['memberRoutineWorkoutName'],
        workoutChecked: json['memberRoutineIsChecked'],
        workoutCount: json['memberRoutineWorkoutCount'],
        workoutSets: json['memberRoutineWorkoutSet'],
        workoutTime: json['memberRoutineWorkoutTime'],
        workoutWeight: json['memberRoutineWorkoutWeight'],
        challengeRoutineId: json['challengeRoutineContentId']
    );
  }
}

class RoutineDetail {
  int memberRoutineId;
  int? routineChallengeId;
  List<Routine> routines = [];

  RoutineDetail({
    required this.memberRoutineId,
    this.routineChallengeId,
    required this.routines,
  });
}