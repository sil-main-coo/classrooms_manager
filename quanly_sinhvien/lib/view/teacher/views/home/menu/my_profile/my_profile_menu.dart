import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/utils/values/colors.dart';

class MyProfileTeacherMenu extends StatelessWidget {
  double _sizeIcon;

  MyProfileTeacherMenu(this._sizeIcon);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/view.teacher/my_profile');
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Image.asset('asset/image/profile.png',  height: _sizeIcon, width: _sizeIcon, fit: BoxFit.contain,),
          ),
          Text("My Profile", style: Theme.of(context).primaryTextTheme.subtitle.copyWith(color: textLightPrimary),)
        ],
      ),
    );
  }
}
