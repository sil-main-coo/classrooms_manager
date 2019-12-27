import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quanly_sinhvien/utils/values/colors.dart';
import 'package:toast/toast.dart';

class ShowToast{
  static void showToastDark(BuildContext context, String mess){
    Toast.show(mess, context, duration: Toast.LENGTH_LONG, backgroundColor: Colors.black87);
  }
  static void showToastLight(BuildContext context, String mess){
    Toast.show(mess, context, duration: Toast.LENGTH_LONG, backgroundColor: primary);
  }

}