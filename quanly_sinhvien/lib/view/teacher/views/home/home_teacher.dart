import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/view/teacher/views/home/box_teacher.dart';
import 'package:quanly_sinhvien/view/teacher/views/home/grid_menu.dart';

class HomeTeacher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        BoxTeacher(),
        GridMenuTeacher()
      ],
    );
  }
}
