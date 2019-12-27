import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quanly_sinhvien/bloc/bloc_application.dart';
import 'package:quanly_sinhvien/singleton/size_screen.dart';
import 'package:quanly_sinhvien/utils/values/colors.dart';

class BoxTeacher extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final sc= SizeScreen.getSize(context);
    final sizeOfAvatar= sc.width/4;
    final heightSizeBox= sc.height/3.5;

    return Container(
        height: heightSizeBox,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            _backgroundTrans(),
            _buildBox(sizeOfAvatar, context,)
          ],
        )
    );
  }

  _buildBox(double sizeOfAvatar, BuildContext context){
    final bloc = Provider.of<ApplicationBloc>(context);
    final profile = bloc.profileTeacher;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0,8,16,8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(child: _avatar(sizeOfAvatar), flex: 1,),
                Flexible(
                  child: Column(
                    children: <Widget>[
                      _fullName(context, profile.name),
                      _codeTeacher(context, profile.username),
                      _department(context, profile.department)
                    ],
                  ),
                  flex: 2,
                ),
              ],
            ),
            _currentDate(context),
          ],
        ),
      ),
    );
  }

  _backgroundTrans() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [primaryTeachDark, primaryTeach]
          )
      ),
      width: double.infinity,
    );
  }


  _currentDate(BuildContext context){
    return Text('Today: Tuesday, 09th July, 2019', style: Theme.of(context).primaryTextTheme.subtitle.copyWith(fontWeight: FontWeight.w400),);
  }

  _avatar(double sizeOfAvatar) {
    return Container(
      width: sizeOfAvatar, // sizeof avatar
      height: sizeOfAvatar,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(90.0),
        child: new Image.asset(
          "asset/image/logo.png",
          fit: BoxFit.cover,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90.0),
        border: Border.all(
          color: Colors.white,
          width: 4.0,
        ),
      ),
    );
  }

  _fullName(BuildContext context, String name) {
    return Padding(
      padding: const EdgeInsets.only(top : 8.0),
      child: Text(name, style: Theme.of(context).primaryTextTheme.title.copyWith(fontWeight: FontWeight.bold),),
    );
  }

  _codeTeacher(BuildContext context, String username) {
    return Padding(
      padding: const EdgeInsets.only(top :8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text("Username:", style: Theme.of(context).primaryTextTheme.body2.copyWith(fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic),),
          Text(username, style: Theme.of(context).primaryTextTheme.subtitle.copyWith(fontWeight: FontWeight.w600),),
        ],
      ),
    );
  }

  _department(BuildContext context, String department) {
    return Padding(
      padding: const EdgeInsets.only(top :8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(AppLocalizations.of(context).tr('main_student.home.box_header.major')+":", style: Theme.of(context).primaryTextTheme.body2.copyWith(fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic),),
          Text(department, style: Theme.of(context).primaryTextTheme.subtitle.copyWith(fontWeight: FontWeight.w600),),
        ],
      ),
    );
  }

}
