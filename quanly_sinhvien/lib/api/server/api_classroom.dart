import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/reponsitory_api/server/repo_classroom.dart';
import 'package:quanly_sinhvien/utils/setups/connection/dio_setup.dart';
import 'package:quanly_sinhvien/utils/setups/connection/url.dart';
import 'package:quanly_sinhvien/check/check_i_connected.dart';
import 'package:quanly_sinhvien/model/response/response_list_classroom.dart';
import 'package:quanly_sinhvien/model/response/response_result.dart';

class ClassroomApi implements ClassroomRepo{
  @override
  String getInfoClassroom(String id) {
    // TODO: implement getInfoClassroom
    return null;
  }

  @override
  Future<ResponseListClassroom> getListClassroom(String token) async {
    final hasConn = await CheckConnection.checkConnection();
    if (hasConn) {
      final url= AppURL.classrooms;
      final setupDio = SetupDio();
      Dio dio = setupDio.createDio(accessToken: token);
      try {
        Response response = await dio.get(url);
        return ResponseListClassroom.fromJson(response.data);
      } catch (error, stacktrace) {
        debugPrint('Exception dio: $error stackTrace: $stacktrace ');
        return ResponseListClassroom.withError(setupDio.handleError(error));
      }
    }else {
      return ResponseListClassroom.withError(ResponseResult.withDisconnect());
    }
  }

}