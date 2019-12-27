import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/utils/values/colors.dart';

class AlertResult{
  static showAlertError(BuildContext context, String error){
    showDialog(
      context: context,
      builder: (context)=> AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        content: Text(error, style: TextStyle(color: textLightPrimary),),
        title: Icon(Icons.error),
        actions: [
          new FlatButton(
              child: Text("OK",style: TextStyle(color: primaryLight),),
              onPressed: (){
                Navigator.pop(context);
              }
          ),
        ],
      ),
    );
  }

  static showAlertSuccess(BuildContext context, String error){
    showDialog(
      context: context,
      builder: (context)=> AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        content: Text(error, style: TextStyle(color: textLightPrimary),),
        actions: [
          new FlatButton(
              child: Text("OK",style: TextStyle(color: primaryLight),),
              onPressed: (){
                Navigator.pop(context);
              }
          ),
        ],
      ),
    );
  }
}