import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quanly_sinhvien/utils/values/colors.dart';
class LoaderCircle extends StatefulWidget {
  @override
  _LoadingCustom1State createState() => _LoadingCustom1State();
}


class _LoadingCustom1State extends State<LoaderCircle> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Center(
      child:
      SpinKitRipple(
          size: 60.0,
          controller: AnimationController(
              vsync: this, duration: Duration(milliseconds: 800)),
          color: primary
      ),
    );
  }
}
