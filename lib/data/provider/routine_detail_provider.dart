import 'package:get/get.dart';
import 'package:sunmi/data/model/routine_detail.dart';


import 'url.dart';

class RoutineDetailProvider extends GetConnect{
  Future<Response>getRoutineDetail(routineId) => get('$baseURL/routines/$routineId');

  getById(routineId) async{
    var routineDetailResponse = await getRoutineDetail(routineId);
    final routinesJson = routineDetailResponse.body['memberRoutineData']['memberRoutineContentList'] as List;
    final List<Routine> routines = routinesJson.map(
            (detail) => Routine.fromJson(detail)).toList();
    int challengeRoutineId = routineDetailResponse.body['challengeRoutineId'];
    int memberRoutineId = routineDetailResponse.body['memberRoutineId'];
    RoutineDetail routineDetail = RoutineDetail(
        memberRoutineId: memberRoutineId,
        routineChallengeId: challengeRoutineId,
        routines: routines);
    return routineDetail;
  }
}