import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/api/device/api_local_storage.dart';
import 'package:quanly_sinhvien/reponsitory_api/server/repo_schedule.dart';
import 'package:quanly_sinhvien/utils/setups/connection/dio_setup.dart';
import 'package:quanly_sinhvien/utils/setups/connection/url.dart';
import 'package:quanly_sinhvien/utils/setups/local_storage_api/key_storage.dart';
import 'package:quanly_sinhvien/reponsitory_api/device/repo_local_storage.dart';
import 'package:quanly_sinhvien/check/check_i_connected.dart';
import 'package:quanly_sinhvien/model/response/response_result.dart';
import 'package:quanly_sinhvien/model/response/response_schedule.dart';

class ScheduleApi implements ScheduleApiRepo {
  final LocalStorageRepo _localApi = LocalStorageApi();

  @override
  Future<ResponseSchedule> getScheduleStudent(String token) async {
    final hasConn = await CheckConnection.checkConnection();
    if (hasConn) {
      //  check data from local
      final local = await _localApi.getStudentSchedule();
      if (local != null) { // if exist
        return local;
      }
      return await _getFromApi(token);
    } else {
      // no connect ? -> get from local
      final local = await _localApi.getStudentSchedule();
      if (local != null) {
        return local;
      }

      // data from local is empty ? -> show disconnect err
      return ResponseSchedule.withError(ResponseResult.withDisconnect());
    }
  }

  // function get schedule from api
  _getFromApi(String token) async {
    final url = AppURL.schedule;
    final setupDio = SetupDio();
    Dio dio = setupDio.createDio(accessToken: token);
    try {
      Response response = await dio.get(url);
      final model = ResponseSchedule.fromJson(response.data);
      if (model.success) {
        final saved = await _localApi.saveData(
            KeyStorageStudent.stScheduleKey,
            jsonEncode(response.data));
        if (saved)
          return model;
        else
          throw Exception('Save schedule to local missed');
      }
    } catch (error, stacktrace) {
      debugPrint('Exception dio: $error stackTrace: $stacktrace ');
      return ResponseSchedule.withError(setupDio.handleError(error));
    }
  }

}