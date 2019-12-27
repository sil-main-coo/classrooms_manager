import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/singleton/size_screen.dart';
import 'package:quanly_sinhvien/utils//values/colors.dart';

class PickYourRole extends StatefulWidget {
  @override
  _PickYourRoleState createState() => _PickYourRoleState();
}

class _PickYourRoleState extends State<PickYourRole> {
  @override
  Widget build(BuildContext context) {
    debugPrint('>>> BUILD PICK UR ROLE');
    final sc= SizeScreen.getSize(context);
    final localizProvider= EasyLocalizationProvider.of(context); // get data InheritedWidget multi language
    
    return SafeArea(
      child: Scaffold(
        body: EasyLocalizationProvider(
          data: localizProvider.data,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(AppLocalizations.of(context).tr('pick_role.title'), style: Theme.of(context).primaryTextTheme.headline
                    .copyWith(color: textLightPrimary, fontWeight: FontWeight.w600),),
                SizedBox(height: sc.height/10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: FlatButton(
                        padding: const EdgeInsets.all(8.0),
                        onPressed: (){
                          Navigator.pushReplacementNamed(context, '/login/view.student');
                        },
                        child: Column(
                          children: <Widget>[
                            Image.asset('asset/image/ic_student.png'),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text('Student',
                                style:  Theme.of(context).primaryTextTheme.title.copyWith(color: textLightPrimary),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: sc.width/25,),
                    Flexible(
                      flex: 1,
                      child: FlatButton(
                        padding: const EdgeInsets.all(8.0),
                        onPressed: (){
                          Navigator.pushReplacementNamed(context, '/login/view.teacher');
                        },
                        child: Column(
                          children: <Widget>[
                            Image.asset('asset/image/ic_teacher.png'),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text('Teacher',
                                style:  Theme.of(context).primaryTextTheme.title.copyWith(color: textLightPrimary),),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


}