import 'package:quanly_sinhvien/model/response/profile/student_profile.dart';
import 'package:quanly_sinhvien/model/response/profile/teacher_profile.dart';
import 'package:quanly_sinhvien/model/response/profile/user.dart';
import 'package:quanly_sinhvien/model/response/response_result.dart';

class ResponseTeacherProfile extends ResponseResult{
  TeacherProfile _user;

  ResponseTeacherProfile(bool success, int stt, String mess, this._user) : super(success, stt, mess);

  ResponseTeacherProfile.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    _user = json['user'] != null ? new TeacherProfile.fromJson(json['user']) : null;
  }

  ResponseTeacherProfile.withError(ResponseResult err) : super.withError(err);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._user != null) {
      data['user'] = this._user.toJson();
    }
    return data;
  }

  TeacherProfile get user => _user;
}