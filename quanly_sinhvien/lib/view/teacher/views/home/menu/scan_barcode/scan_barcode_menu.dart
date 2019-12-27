import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/utils/values/colors.dart';

class CreateQRCodeMenu extends StatelessWidget {
  double _sizeIcon;

  CreateQRCodeMenu(this._sizeIcon);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/classrooms');
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Image.asset('asset/image/bar_code.png', height: _sizeIcon, width: _sizeIcon, fit: BoxFit.contain,),
          ),
          Text("Scan Barcode", style: Theme.of(context).primaryTextTheme.subtitle.copyWith(color: textLightPrimary),)
        ],
      ),
    );
  }
}
