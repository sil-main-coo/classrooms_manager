import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/utils/values/colors.dart';

import '../dialog/dialog_logout.dart';

class LogOutMenuItem extends StatelessWidget {
  double _sizeIcon;

  LogOutMenuItem(this._sizeIcon);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        DialogLogOut.showDialogLogOut(context);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Image.asset('asset/image/logout.png', height: _sizeIcon, width: _sizeIcon, fit: BoxFit.contain,),
          ),
          Text(AppLocalizations.of(context).tr(
              'main_student.home.grid_menu.logout'), style: Theme.of(context).primaryTextTheme.subtitle.copyWith(color: textLightPrimary),)
        ],
      ),
    );
  }
}
