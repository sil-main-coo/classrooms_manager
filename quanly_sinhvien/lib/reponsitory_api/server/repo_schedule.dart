import 'package:quanly_sinhvien/model/response/response_schedule.dart';

abstract class ScheduleApiRepo{
  Future<ResponseSchedule> getScheduleStudent(String token);
}