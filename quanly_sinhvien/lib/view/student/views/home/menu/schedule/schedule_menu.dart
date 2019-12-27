import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/utils/values/colors.dart';


class MenuScheduleMenu extends StatelessWidget {
  double _sizeIcon;

  MenuScheduleMenu(this._sizeIcon);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/view.student/schedule');
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Image.asset('asset/image/calendar.png', height: _sizeIcon, width: _sizeIcon, fit: BoxFit.contain,),
          ),
          Text(AppLocalizations.of(context).tr(
              'main_student.home.grid_menu.schedule'), style: Theme
              .of(context)
              .primaryTextTheme
              .subtitle
              .copyWith(color: textLightPrimary),)
        ],
      ),
    );
  }
}
