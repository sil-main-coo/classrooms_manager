
import 'package:quanly_sinhvien/model/response/response_result.dart';
import 'package:quanly_sinhvien/model/response/response_student_profile.dart';
import 'package:quanly_sinhvien/model/response/response_teacher_profile.dart';

abstract class UserDataRepo{
  Future<ResponseStudentProfile> getStudentData(String token, {String idUser});
  Future<ResponseTeacherProfile> getTeacherData(String token, {String idUser});
  Future<ResponseResult> updateUserProfile(String token, String idUser, String key,String data);
}