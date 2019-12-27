import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/utils/values/colors.dart';
import 'package:quanly_sinhvien/view/widgets/show_toast.dart';

class ManagerClassesMenu extends StatelessWidget {
  double _sizeIcon;

  ManagerClassesMenu(this._sizeIcon);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>ShowToast.showToastDark(context, 'This feature is under development'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Image.asset('asset/image/classes.png', height: _sizeIcon, width: _sizeIcon, fit: BoxFit.contain,),
          ),
          Text("Classes", style: Theme.of(context).primaryTextTheme.subtitle.copyWith(color: textLightPrimary),)
        ],
      ),
    );
  }
}
