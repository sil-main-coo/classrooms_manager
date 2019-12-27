import 'package:quanly_sinhvien/model/response/profile/student_profile.dart';
import 'package:quanly_sinhvien/model/response/profile/user.dart';
import 'package:quanly_sinhvien/model/response/response_result.dart';

class ResponseStudentProfile extends ResponseResult{
  StudentProfile _user;

  ResponseStudentProfile(bool success, int stt, String mess, this._user) : super(success, stt, mess);

  ResponseStudentProfile.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    _user = json['user'] != null ? new StudentProfile.fromJson(json['user']) : null;
  }

  ResponseStudentProfile.withError(ResponseResult err) : super.withError(err);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._user != null) {
      data['user'] = this._user.toJson();
    }
    return data;
  }

  StudentProfile get user => _user;
}