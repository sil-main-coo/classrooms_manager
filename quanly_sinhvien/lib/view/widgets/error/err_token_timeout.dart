import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quanly_sinhvien/bloc/bloc_application.dart';
import 'package:quanly_sinhvien/events/logout_event.dart';
import 'package:quanly_sinhvien/utils/values/colors.dart';

class WidgetErrorTokenTimeOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.block, color: primary,),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Text('Token time out ! Let\'s login again',
                style: Theme.of(context).primaryTextTheme.title.copyWith(color: textLightPrimary),),
            ),
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: Text("OK",style: Theme.of(context).primaryTextTheme.button.copyWith(color: primaryLight),),
              onPressed: () => _logOut(context)
          ),
        ],
    );
  }
  _logOut(BuildContext context){
    final appBloc= Provider.of<ApplicationBloc>(context);
    appBloc.sinkEvent.add(LogOutEvent());
  }

}
