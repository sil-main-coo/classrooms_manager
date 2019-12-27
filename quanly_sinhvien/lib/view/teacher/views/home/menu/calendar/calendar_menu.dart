import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/utils/values/colors.dart';
import 'package:quanly_sinhvien/view/widgets/show_toast.dart';

class CalendarMenu extends StatelessWidget {
  double _sizeIcon;

  CalendarMenu(this._sizeIcon);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>ShowToast.showToastDark(context, 'This feature is under development'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Image.asset('asset/image/calendar_teacher.png', height: _sizeIcon, width: _sizeIcon, fit: BoxFit.contain,),
          ),
          Text("My Calendar", style: Theme.of(context).primaryTextTheme.subtitle.copyWith(color: textLightPrimary),)
        ],
      ),
    );
  }
}
