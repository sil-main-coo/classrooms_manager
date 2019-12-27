import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quanly_sinhvien/bloc/bloc_application.dart';
import 'package:quanly_sinhvien/events/logout_event.dart';
import 'package:quanly_sinhvien/utils/values/colors.dart';

class DialogLogOut{
  static showDialogLogOut(BuildContext context,){
    showDialog(
      context: context,
      builder: (context)=> AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        content: Text(AppLocalizations.of(context).tr('dialog.logout.msg'), style: TextStyle(color: textLightPrimary),),
        actions: [
          new FlatButton(
              child: Text(AppLocalizations.of(context).tr('dialog.yes').toUpperCase(),style: TextStyle(color: primaryLight),),
              onPressed: () => _logOut(context),
          ),
          new FlatButton(
              child: Text(AppLocalizations.of(context).tr('dialog.no').toUpperCase(),style: TextStyle(color: primaryLight),),
              onPressed: (){
                Navigator.pop(context);
              }
          ),
        ],
      ),
    );
  }

  static _logOut(BuildContext context){
    final appBloc= Provider.of<ApplicationBloc>(context);
    appBloc.sinkEvent.add(LogOutEvent());
  }
}