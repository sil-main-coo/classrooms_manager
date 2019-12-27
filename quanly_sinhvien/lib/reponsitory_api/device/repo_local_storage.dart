
import 'package:quanly_sinhvien/model/login_session.dart';
import 'package:quanly_sinhvien/model/response/response_schedule.dart';
import 'package:quanly_sinhvien/model/response/response_student_profile.dart';
import 'package:quanly_sinhvien/model/response/response_teacher_profile.dart';

abstract class LocalStorageRepo{
  Future<bool> saveData(String key, String data);

  Future<LoginSessionModel> getToken();

  Future<ResponseSchedule> getStudentSchedule();

  Future<ResponseStudentProfile> getProfileMeStudent();

  Future<ResponseTeacherProfile> getProfileMeTeacher();

  void clearData();
}