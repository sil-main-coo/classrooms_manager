import 'package:quanly_sinhvien/model/response/profile/user.dart';

class TeacherProfile extends User{
  String _department;

  TeacherProfile.fromJson(Map<String, dynamic> json) : super.fromJson(json){
    _department= json['department'];
  }

  String get department => _department;

  Map<String, dynamic> toJson() {
    return super.toJson().putIfAbsent('department', ()=> this._department); // put new object if key not exist
  }

}