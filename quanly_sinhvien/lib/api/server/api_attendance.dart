import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/utils/setups/connection/dio_setup.dart';
import 'package:quanly_sinhvien/utils/setups/connection/url.dart';
import 'package:quanly_sinhvien/reponsitory_api/server/repo_attendance.dart';
import 'package:quanly_sinhvien/check/check_i_connected.dart';
import 'package:quanly_sinhvien/model/request/attendance.dart';
import 'package:quanly_sinhvien/model/response/response_result.dart';

class AttendanceApi extends AttendanceRepo{
  @override
  Future<ResponseResult> attendance(String token, AttendanceData attendance) async {
    debugPrint('>>> Attendance: ${attendance.toJson().toString()}');
    final hasConn= await CheckConnection.checkConnection();
    if(hasConn) {
      final url = AppURL.classrooms+'/attendance_by_student';
      final setupDio = SetupDio();
      Dio dio = setupDio.createDio(accessToken: token);

      try {
        Response response = await dio.post(url, data: attendance.toJson());
        return ResponseResult.fromJson(response.data);
      } catch (error, stacktrace) {
        debugPrint('Exception dio: $error stackTrace: $stacktrace ');
        return ResponseResult.withError(setupDio.handleError(error));
      }
    }else{
      return ResponseResult.withError(ResponseResult.withDisconnect());
    }
  }

  @override
  Future<ResponseResult> scanBarcodeTeacher(String token, String idClass, String studentCode) async {
    debugPrint('>>> Attendance by teacher: $idClass');
    final hasConn= await CheckConnection.checkConnection();
    if(hasConn) {
      final url = AppURL.classrooms+'/:$idClass/attendance_by_teacher';
      final setupDio = SetupDio();
      Dio dio = setupDio.createDio(accessToken: token);

      try {
        Response response = await dio.post(url, data: {'student_username': studentCode});
        return ResponseResult.fromJson(response.data);
      } catch (error, stacktrace) {
        debugPrint('Exception dio: $error stackTrace: $stacktrace ');
        return ResponseResult.withError(setupDio.handleError(error));
      }
    }else{
      return ResponseResult.withError(ResponseResult.withDisconnect());
    }
  }

}