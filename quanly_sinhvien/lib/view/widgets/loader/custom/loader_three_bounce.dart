import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quanly_sinhvien/utils/values/colors.dart';

class LoaderThreeBounce extends StatefulWidget {
  @override
  _LoadingThreeBounceState createState() => _LoadingThreeBounceState();
}

class _LoadingThreeBounceState extends State<LoaderThreeBounce> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Center(
      child:
      SpinKitThreeBounce(
          size: 15.0,
          controller: AnimationController(
              vsync: this, duration: Duration(milliseconds: 800)),
          color: secondary
      ),
    );
  }
}
