import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/api/device/api_local_storage.dart';
import 'package:quanly_sinhvien/api/server/api_user_data.dart';
import 'package:quanly_sinhvien/events/logout_event.dart';
import 'package:quanly_sinhvien/reponsitory_api/device/repo_local_storage.dart';
import 'package:quanly_sinhvien/base/base_bloc.dart';
import 'package:quanly_sinhvien/base/base_event.dart';
import 'package:quanly_sinhvien/model/response/profile/student_profile.dart';
import 'package:quanly_sinhvien/model/response/profile/teacher_profile.dart';
import 'package:quanly_sinhvien/model/response/response_student_profile.dart';
import 'package:quanly_sinhvien/model/response/response_teacher_profile.dart';
import 'package:quanly_sinhvien/reponsitory_api/server/repo_user_data.dart';
import 'package:quanly_sinhvien/singleton/singletont_token.dart';
import 'package:quanly_sinhvien/utils/values/name_role.dart';
import 'package:rxdart/rxdart.dart';

class ApplicationBloc extends BaseBloc {
  final SingletonToken _singletonToken = SingletonToken
      .getInstance(); // Manager login session: token, checkLogin, name role
  final LocalStorageRepo _apiStorage = LocalStorageApi();
  final DateTime dateTime = DateTime.now();

  StreamController<SingletonToken> _streamCheckLogin = StreamController
      .broadcast();

  Stream<SingletonToken> get streamCheckLogin => _streamCheckLogin.stream;

  Sink<SingletonToken> get sinkCheckLogin => _streamCheckLogin.sink;

  BehaviorSubject<
      ResponseStudentProfile> _streamStudentProfile = BehaviorSubject();

  Stream<ResponseStudentProfile> get streamStudentProfile =>
      _streamStudentProfile.stream;

  StudentProfile get profileStudent => _streamStudentProfile.value.user;

  BehaviorSubject<
      ResponseTeacherProfile> _streamTeacherProfile = BehaviorSubject();

  Stream<ResponseTeacherProfile> get streamTeacherProfile =>
      _streamTeacherProfile.stream;

  TeacherProfile get profileTeacher => _streamTeacherProfile.value.user;

  getTokenFromLocal() async {
    debugPrint('>>> get token from local');
    final loginSession = await _apiStorage
        .getToken(); // try get token from local

    if (loginSession != null) {
      _singletonToken.logIn(loginSession); // login with student's role
    } else {
      _singletonToken.logOut(); // not yet login
    }

    _streamCheckLogin.sink.add(_singletonToken); // add stream listen login
  }

  getMe(NameOfRole nameOfRole) async {
    final UserDataRepo _api = UserDataApi();

    if (nameOfRole == NameOfRole.STUDENT) {
      final response = await _api.getStudentData(
          _singletonToken.loginSession.token);
      if (response.success) {
        _singletonToken.loginSession.idUser = response.user.sId;
      }
      _streamStudentProfile.sink.add(response);
    } else if (nameOfRole == NameOfRole.TEACHER) {
      final response = await _api.getTeacherData(
          _singletonToken.loginSession.token);
      if (response.success) {
        _singletonToken.loginSession.idUser = response.user.sId;
      }
      _streamTeacherProfile.sink.add(response);
    }
  }

  // ############# EVENT #############

  _logout() {
    debugPrint('>> LOGOUT TOKEN : ${_singletonToken.loginSession.token}');

    _apiStorage.clearData(); // clear user data before login
    _singletonToken.logOut(); // not yet login
    _streamCheckLogin.sink.add(_singletonToken); // add stream listen logout
  //  _streamStudentProfile.add(null);
    //_streamTeacherProfile.add(null);
  }

  // ###################################

  @override
  void dispatchEvent(BaseEvent event) {
    // TODO: implement dispatchEvent
    if (event is LogOutEvent) {
      _logout();
    } else {
      throw Exception('Wrong event:  ${event.toString()}');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamCheckLogin.close();
    _streamStudentProfile.close();
    _streamTeacherProfile.close();
    super.dispose();
  }
}