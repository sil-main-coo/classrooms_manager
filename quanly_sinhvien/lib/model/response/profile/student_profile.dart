import 'package:quanly_sinhvien/model/response/profile/user.dart';

class StudentProfile extends User{
  String _major, _className;

  StudentProfile.fromJson(Map<String, dynamic> json) : super.fromJson(json){
    _major= json['major'];
    _className= json['class_name'];
  }

  String get major => _major;

  get className => _className;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map= super.toJson().putIfAbsent('major', ()=> this._major); // put new object if key not exist
    return map.putIfAbsent('class_name', ()=> this._className);
  }

}