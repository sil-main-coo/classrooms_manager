import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/singleton/size_screen.dart';
import 'package:quanly_sinhvien/view/student/views/home/menu/chart/chart_menu.dart';
import 'package:quanly_sinhvien/view/student/views/home/menu/my_profile/my_profile_menu.dart';
import 'package:quanly_sinhvien/view/widgets/menu/item_menu_logout.dart';
import 'package:quanly_sinhvien/view/widgets/menu/item_settings_menu.dart';
import 'menu/qr_code/qr_code_menu.dart';
import 'menu/schedule/schedule_menu.dart';

class GridMenuStudent extends StatelessWidget {

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

  _buildMenu(double sizeItemMenu, BuildContext context, double sizeIcon, ){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(width: sizeItemMenu ,child: QRCodeMenu(sizeIcon)),
            SizedBox(width: sizeItemMenu ,child: MenuScheduleMenu(sizeIcon)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
                width: sizeItemMenu,
                child: ChartMenu(sizeIcon)
            ),
            SizedBox(
                width: sizeItemMenu,
                child: MyProfileMenu(sizeIcon)
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              width: sizeItemMenu,
              child: LogOutMenuItem(sizeIcon),
            ),
            SizedBox(
                width: sizeItemMenu,
                child: SettingMenuItem(sizeIcon)
            ),
          ],
        ),
      ],
    );
  }
}
