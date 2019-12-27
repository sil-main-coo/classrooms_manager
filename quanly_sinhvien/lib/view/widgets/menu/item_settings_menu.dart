import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/utils/values/colors.dart';
import 'package:quanly_sinhvien/view/widgets/show_toast.dart';

class SettingMenuItem extends StatelessWidget {
  double _sizeIcon;

  SettingMenuItem(this._sizeIcon);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>ShowToast.showToastDark(context, 'This feature is under development'),
      child: Column(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Image.asset('asset/image/setting.png', height: _sizeIcon, width: _sizeIcon, fit: BoxFit.contain,),
              ),
              Text(AppLocalizations.of(context).tr(
                  'main_student.home.grid_menu.setting'), style: Theme.of(context).primaryTextTheme.subtitle.copyWith(color: textLightPrimary),)
            ],
          ),
        ],
      ),
    );
  }
}
