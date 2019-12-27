import 'package:quanly_sinhvien/model/response/profile/student_profile.dart';
import 'package:quanly_sinhvien/model/response/profile/user.dart';
import 'package:quanly_sinhvien/model/response/response_result.dart';
import 'package:quanly_sinhvien/model/response/schedule/schedule.dart';

class ResponseSchedule extends ResponseResult{
  List<Schedule> _schedules;

  ResponseSchedule(bool success, int stt, String mess, this._schedules) : super(success, stt, mess);

  ResponseSchedule.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    final js= json['schedule'];

    if (js['data'] != null) {
      _schedules = new List<Schedule>();
      js['data'].forEach((v) {
        _schedules.add(new Schedule.fromJson(v));
      });
    }
  }

  ResponseSchedule.withError(ResponseResult err) : super.withError(err);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._schedules != null) {
      data['schedule'] = this._schedules.map((v) => v.toJson()).toList();
    }
    return data;
  }

  List<Schedule> get schedules => _schedules;
}