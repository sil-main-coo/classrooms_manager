import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/singleton/size_screen.dart';
import 'package:quanly_sinhvien/view/teacher/views/home/menu/calendar/calendar_menu.dart';
import 'package:quanly_sinhvien/view/teacher/views/home/menu/my_profile/my_profile_menu.dart';
import 'package:quanly_sinhvien/view/widgets/menu/item_menu_logout.dart';
import 'package:quanly_sinhvien/view/widgets/menu/item_settings_menu.dart';
import 'menu/manager_classes/manager_classes_menu.dart';
import 'menu/scan_barcode/scan_barcode_menu.dart';


class GridMenuTeacher extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final sc= SizeScreen.getSize(context);
    final sizeItemMenu= sc.width/3;
    final heightMenu= sc.height - sc.height/2.5;
    final sizeIcon= sc.width / 9;

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
          height: heightMenu,
          child: _buildMenu(sizeItemMenu, context, sizeIcon)
      ),
    );
  }

  _buildMenu(double sizeItemMenu, BuildContext context, double sizeIcon){

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(width: sizeItemMenu ,child: CreateQRCodeMenu(sizeIcon)),
            SizedBox(width: sizeItemMenu ,child: CalendarMenu(sizeIcon)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(width: sizeItemMenu, child: ManagerClassesMenu(sizeIcon)),
            SizedBox(width: sizeItemMenu, child: MyProfileTeacherMenu(sizeIcon)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(width: sizeItemMenu, child: LogOutMenuItem(sizeIcon),),
            SizedBox(width: sizeItemMenu, child: SettingMenuItem(sizeIcon)),
          ],
        ),
      ],
    );
  }
}
