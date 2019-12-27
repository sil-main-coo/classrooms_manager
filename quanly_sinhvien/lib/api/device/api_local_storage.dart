import 'dart:convert';
import 'package:quanly_sinhvien/utils/setups/local_storage_api/key_storage.dart';
import 'package:quanly_sinhvien/utils/setups/local_storage_api/shared_preferences_api.dart';
import 'package:quanly_sinhvien/reponsitory_api/device/repo_local_storage.dart';
import 'package:quanly_sinhvien/model/login_session.dart';
import 'package:quanly_sinhvien/model/response/response_schedule.dart';
import 'package:quanly_sinhvien/model/response/response_student_profile.dart';
import 'package:quanly_sinhvien/model/response/response_teacher_profile.dart';

class LocalStorageApi extends LocalStorageRepo{
  @override
  Future<LoginSessionModel> getToken() async {
    // TODO: implement getToken
    final json= await Preferences.getData(KeyStorageApplication.tokenKey);
    if(json!=null){
      return LoginSessionModel.fromJson(jsonDecode(json));
    }
    return null;
  }


  @override
  Future<ResponseSchedule> getStudentSchedule() async {
    final json= await Preferences.getData(KeyStorageStudent.stScheduleKey);
    if(json!=null){
      return ResponseSchedule.fromJson(jsonDecode(json));
    }
    return null;
  }


  @override
  Future<ResponseStudentProfile> getProfileMeStudent() async {
    final json= await Preferences.getData(KeyStorageStudent.stProfileMeKey);
    if(json!=null){
      return ResponseStudentProfile.fromJson(jsonDecode(json));
    }
    return null;
  }


  @override
  Future<ResponseTeacherProfile> getProfileMeTeacher() async {
    final json= await Preferences.getData(KeyStorageTeacher.teachProfileMeKey);
    if(json!=null){
      return ResponseTeacherProfile.fromJson(jsonDecode(json));
    }
    return null;
  }


  @override
  Future<bool> saveData(String key, String data) async {
    final saved= await Preferences.saveData(key, data);
    return saved;
  }

  @override
  clearData() {
    // TODO: implement clearData
    Preferences.deleteDataWithKey(KeyStorageApplication.tokenKey); // clear data
    Preferences.deleteDataWithKey(KeyStorageStudent.stProfileMeKey); // clear data
    Preferences.deleteDataWithKey(KeyStorageTeacher.teachProfileMeKey); // clear data
  }

}