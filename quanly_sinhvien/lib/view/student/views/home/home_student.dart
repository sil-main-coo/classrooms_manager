import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/view/student/views/home/box_student.dart';
import 'package:quanly_sinhvien/view/student/views/home/grid_menu.dart';

class HomeStudent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        BoxStudent(),
        GridMenuStudent()
      ],
    );
  }
}
