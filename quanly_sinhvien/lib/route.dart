import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/view/decentralize/application.dart';
import 'package:quanly_sinhvien/view/decentralize/home/home.dart';
import 'package:quanly_sinhvien/view/decentralize/login/student_login.dart';
import 'package:quanly_sinhvien/view/decentralize/login/teacher_login.dart';
import 'package:quanly_sinhvien/view/decentralize/pick_role.dart';
import 'package:quanly_sinhvien/view/student/views/home/menu/chart/chart_subject.dart';
import 'package:quanly_sinhvien/view/student/views/home/menu/my_profile/my_profile.dart';
import 'package:quanly_sinhvien/view/student/views/home/menu/schedule/schedule.dart';
import 'package:quanly_sinhvien/view/teacher/views/home/menu/my_profile/my_profile.dart';
import 'package:quanly_sinhvien/view/teacher/views/home/menu/scan_barcode/classrooms.dart';

class Router{
  static Route<dynamic> onGenerateRoute(RouteSettings settings){
    final args= settings.arguments;

    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => ApplicationPage());
      case '/pick_role':
        return FadeRoute(page: PickYourRole());
      case '/login/view.student':
        return FadeRoute(page: StudentLogin());
      case '/login/view.teacher':
        return FadeRoute(page: TeacherLogin());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage(args));
      case '/view.student/schedule':
        return MaterialPageRoute(builder: (_) => SchedulePage());
      case '/view.student/my_profile':
        return MaterialPageRoute(builder: (_) => MyProfilePage());
      case '/view.student/chart_subject':
        return MaterialPageRoute(builder: (_) => CharSubjectStudent());
      case '/view.teacher/my_profile':
        return MaterialPageRoute(builder: (_) => MyProfileTeacher());
      case '/classrooms':
        return MaterialPageRoute(builder: (_) => Classrooms());
      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            appBar: AppBar(
              title: Text("Lỗi"),
            ),
            body: Center(
              child: Text("Có vẻ bạn đã bị lạc đường?\n${settings.name}"),
            ),
          );
        });
    }
  }
}

/// Config animation switch page ////

// Fade animation
class FadeRoute extends PageRouteBuilder {
  final Widget page;
  FadeRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: child,
        ),
  );
}
