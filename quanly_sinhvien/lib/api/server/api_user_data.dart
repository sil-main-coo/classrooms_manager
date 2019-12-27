import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/api/device/api_local_storage.dart';
import 'package:quanly_sinhvien/reponsitory_api/server/repo_user_data.dart';
import 'package:quanly_sinhvien/utils/setups/connection/dio_setup.dart';
import 'package:quanly_sinhvien/utils/setups/connection/url.dart';
import 'package:quanly_sinhvien/utils/setups/local_storage_api/key_storage.dart';
import 'package:quanly_sinhvien/check/check_i_connected.dart';
import 'package:quanly_sinhvien/model/response/response_result.dart';
import 'package:quanly_sinhvien/model/response/response_student_profile.dart';
import 'package:quanly_sinhvien/model/response/response_teacher_profile.dart';

class UserDataApi implements UserDataRepo {


  @override
  Future<ResponseStudentProfile> getStudentData(String token,
      {String idUser}) async {
    final hasConn = await CheckConnection.checkConnection();
    if (hasConn) {
      String url;
      if (idUser == null) {
        // get me
        url = AppURL.getMe;
      } else {
        // get others
        url = AppURL.user + '/:' + idUser;
      }
      final setupDio = SetupDio();
      Dio dio = setupDio.createDio(accessToken: token);

      try {
        Response response = await dio.get(url);
        final model=  ResponseStudentProfile.fromJson(response.data);

        if(model.success){
          // save to local
          final storageApi= LocalStorageApi();
          storageApi.saveData(KeyStorageStudent.stProfileMeKey, jsonEncode(response.data)); // note: get and compare with key in api storage
        }

        return model;
      } catch (error, stacktrace) {
        debugPrint('Exception dio: $error stackTrace: $stacktrace ');
        return ResponseStudentProfile.withError(setupDio.handleError(error));
      }
    } else {
      // disconnect ?
      // -> get from local
      final storageApi= LocalStorageApi();
      final local= storageApi.getProfileMeStudent();
      if(local!=null)
        return local; // return if data from local is exist
      return ResponseStudentProfile.withError(ResponseResult.withDisconnect()); // return disconnection err
    }
  }

  @override
  Future<ResponseTeacherProfile> getTeacherData(String token,
      {String idUser}) async {
    final hasConn = await CheckConnection.checkConnection();
    if (hasConn) {
      String url;
      if (idUser == null) {
        // get me
        url = AppURL.getMe;
      } else {
        // get others
        url = AppURL.user + '/:' + idUser;
      }
      final setupDio = SetupDio();
      Dio dio = setupDio.createDio(accessToken: token);

      try {
        Response response = await dio.get(url);
        final model=  ResponseTeacherProfile.fromJson(response.data);

        if(model.success){
          // save to local
          final storageApi= LocalStorageApi();
          storageApi.saveData(KeyStorageTeacher.teachProfileMeKey, jsonEncode(response.data)); // note: get and compare with key in api storage
        }

        return model;
      } catch (error, stacktrace) {
        debugPrint('Exception dio: $error stackTrace: $stacktrace ');
        return ResponseTeacherProfile.withError(setupDio.handleError(error));
      }
    } else {
      // disconnect ?
      // -> get from local
      final storageApi= LocalStorageApi();
      final local= storageApi.getProfileMeTeacher();
      if(local!=null)
        return local; // return if data from local is exist
      return ResponseTeacherProfile.withError(ResponseResult.withDisconnect()); // return disconnection err
    }
  }

  /// @param: [key] is the key of data json when PUT: {key: data}
  @override
  Future<ResponseResult> updateUserProfile(String token, String idUser, String key, String data) async {
    final hasConn = await CheckConnection.checkConnection();
    if (hasConn) {
      final url = AppURL.user + '/:' + idUser;

      final setupDio = SetupDio();
      Dio dio = setupDio.createDio(accessToken: token);

      try {
        Response response = await dio.put(url, data: {key: data});
        final model=  ResponseResult.fromJson(response.data);
        return model;
      } catch (error, stacktrace) {
        debugPrint('Exception dio: $error stackTrace: $stacktrace ');
        return ResponseResult.withError(setupDio.handleError(error));
      }
    } else {
      return ResponseResult.withError(ResponseResult.withDisconnect()); // return disconnection err
    }
  }

}