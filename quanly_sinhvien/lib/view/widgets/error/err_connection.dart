import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/utils/values/colors.dart';

class WidgetErrorConnection extends StatelessWidget {
  String _err;

  WidgetErrorConnection(this._err);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.cloud_off, color: primary, size: 30,),
          Text(_err, style: Theme.of(context).primaryTextTheme.subhead.copyWith(color: textLightPrimary),)
        ],
      ),
    );
  }
}
