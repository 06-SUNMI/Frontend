import 'package:sunmi/data/provider/routine_detail_provider.dart';

class RoutineDetailRepository {
  final RoutineDetailProvider routineDetailProvider = RoutineDetailProvider();

  getById(routineId){
    return routineDetailProvider.getById(routineId);
  }
}