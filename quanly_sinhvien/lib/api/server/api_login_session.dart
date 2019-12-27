import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:quanly_sinhvien/api/device/api_device.dart';
import 'package:quanly_sinhvien/reponsitory_api/server/repo_login_session.dart';
import 'package:quanly_sinhvien/utils/setups/connection/dio_setup.dart';
import 'package:quanly_sinhvien/utils/setups/connection/url.dart';
import 'package:quanly_sinhvien/check/check_i_connected.dart';
import 'package:quanly_sinhvien/model/response/response_login.dart';
import 'package:quanly_sinhvien/model/request/account.dart';
import 'package:quanly_sinhvien/model/response/response_result.dart';

class LoginSessionApi implements LoginSessionRepoApi{
  @override
  Future<LoginResponse> logIn(Account account) async {
    debugPrint('>>> Login: ${account.toJson().toString()}');
    final hasConn = await CheckConnection.checkConnection();
    if (hasConn) {
      final url = AppURL.login;
      final setupDio = SetupDio();
      Dio dio = setupDio.createDio();

      try {
        Response response = await dio.post(url, data: account.toJson());
        final model = LoginResponse.fromJson(response.data);
        final deviceApi = DeviceApi();
        final imei = await deviceApi.getIMEI();

        if (imei == model.imei) {
          model.isOwner = true; // is the owner
        } else {
          model.isOwner = false; // isn't the owner
        }

        return model;
      } catch (error, stacktrace) {
        debugPrint('Exception dio: $error stackTrace: $stacktrace ');
        return LoginResponse.withError(setupDio.handleError(error));
      }
    } else {
      return LoginResponse.withError(ResponseResult.withDisconnect());
    }
  }
}