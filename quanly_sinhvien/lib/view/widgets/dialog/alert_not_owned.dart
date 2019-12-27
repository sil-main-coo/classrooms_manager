import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/utils/values/colors.dart';

class AlertNotOwned{
  static showDialogNotOwned(BuildContext context, String mess){
    showDialog(
      context: context,
      builder: (context)=> AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.info, color: primary, size: 48,),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Text(mess,
                  style: Theme.of(context).primaryTextTheme.title.copyWith(color: textLightPrimary)),
            ),
          ],
        ),
        actions: [
          new FlatButton(
              child: Text(AppLocalizations.of(context).tr('dialog.ok').toUpperCase(),style: TextStyle(color: primaryLight),),
              onPressed: (){
                Navigator.pop(context);
              }
          ),
        ],
      ),
    );
  }
}