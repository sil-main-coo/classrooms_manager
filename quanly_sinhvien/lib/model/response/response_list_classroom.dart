import 'package:quanly_sinhvien/model/response/classroom/classroom.dart';
import 'package:quanly_sinhvien/model/response/response_result.dart';
import 'package:quanly_sinhvien/model/response/schedule/schedule.dart';

class ResponseListClassroom extends ResponseResult{
  List<Classroom> _classrooms;

  ResponseListClassroom(bool success, int stt, String mess, this._classrooms) : super(success, stt, mess);

  ResponseListClassroom.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    if (json['classrooms'] != null) {
      _classrooms = new List<Classroom>();
      json['classrooms'].forEach((v) {
        _classrooms.add(new Classroom.fromJson(v));
      });
    }
  }

  ResponseListClassroom.withError(ResponseResult err) : super.withError(err);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._classrooms != null) {
      data['classrooms'] = this._classrooms.map((v) => v.toJson()).toList();
    }
    return data;
  }

  List<Classroom> get classrooms => _classrooms;
}