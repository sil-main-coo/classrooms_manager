import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quanly_sinhvien/bloc/bloc_application.dart';
import 'package:quanly_sinhvien/check/check_i_connecting.dart';
import 'package:quanly_sinhvien/model/response/response_student_profile.dart';
import 'package:quanly_sinhvien/model/response/response_teacher_profile.dart';
import 'package:quanly_sinhvien/utils/values/name_role.dart';
import 'package:quanly_sinhvien/view/student/views/home/home_student.dart';
import 'package:quanly_sinhvien/view/teacher/views/home/home_teacher.dart';
import 'package:quanly_sinhvien/view/widgets/error/err_connection.dart';
import 'package:quanly_sinhvien/view/widgets/error/err_token_timeout.dart';
import 'package:quanly_sinhvien/view/widgets/loader/custom/loader_circle.dart';
import 'package:quanly_sinhvien/view/widgets/show_toast.dart';

class HomePage extends StatefulWidget {
  NameOfRole _nameOfRole;

  HomePage(this._nameOfRole);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  ApplicationBloc _bloc;
  ConnectionStatusSingleton _statusSingleton; // listen conn stt

  // Listen logout
  _changedLogin(bool isLogin){
    if(isLogin!=null &&!isLogin){
      Navigator.pushNamedAndRemoveUntil(context, '/pick_role',  (Route<dynamic> route) => false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _statusSingleton= ConnectionStatusSingleton.getInstance();
    _statusSingleton.streamConnChange.listen(onChanged);
  }

  void onChanged(dynamic hasConn){
    print(hasConn.toString());
    if(hasConn) {
      ShowToast.showToastLight(context, AppLocalizations.of(context).tr('toast.online'),);
    }else
      ShowToast.showToastDark(context, AppLocalizations.of(context).tr('toast.offline'),);
  }

  @override
  Widget build(BuildContext context) {
    _bloc = Provider.of<ApplicationBloc>(context);
    _bloc.streamCheckLogin.listen((isLogin)=> _changedLogin(isLogin.isLogin));

    switch(widget._nameOfRole){
      case NameOfRole.TEACHER:
        return SafeArea(
          child: Scaffold(
            body: _streamTeacherProfile(),
          ),
        );
      case NameOfRole.STUDENT:
        return SafeArea(
          child: Scaffold(
            body: _streamStudentProfile(),
          ),
        );
      default:
        return SafeArea(
          child: Scaffold(
            body: _buildRoleOther(),
          ),
        );
    }
  }

  _streamStudentProfile(){
    return StreamBuilder<ResponseStudentProfile>(
        stream: _bloc.streamStudentProfile,
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return WidgetErrorConnection(snapshot.error);
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting: return LoaderCircle();
            case ConnectionState.active:
              if(!snapshot.data.success && snapshot.data.status!=1){
                return WidgetErrorConnection(snapshot.data.message);
              }else if(snapshot.data.status==401){
                return WidgetErrorTokenTimeOut();
              }
              return HomeStudent();
            case ConnectionState.done:
          }
          return null; // unreachable
        }
    );
  }

  _streamTeacherProfile(){
    return StreamBuilder<ResponseTeacherProfile>(
        stream: _bloc.streamTeacherProfile,
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return WidgetErrorConnection(snapshot.error);
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting: return LoaderCircle();
            case ConnectionState.active:
              if(!snapshot.data.success && snapshot.data.status!=1){
                return WidgetErrorConnection(snapshot.data.message);
              }else if(snapshot.data.status==401){
                return WidgetErrorTokenTimeOut();
              }
              return HomeTeacher();
            case ConnectionState.done:
          }
          return null; // unreachable
        }
    );
  }

  _buildRoleOther(){
    return Center(child: Text('Đang phát triển role'));
  }
}
