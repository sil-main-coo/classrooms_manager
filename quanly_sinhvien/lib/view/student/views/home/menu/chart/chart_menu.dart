import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/utils/values/colors.dart';
import 'package:quanly_sinhvien/view/widgets/show_toast.dart';

class ChartMenu extends StatelessWidget {
  double _sizeIcon;

  ChartMenu(this._sizeIcon);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> ShowToast.showToastDark(context, 'This feature is under development'),
      // Navigator.pushNamed(context, '/view.student/chart_subject'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Image.asset('asset/image/chart.png', height: _sizeIcon, width: _sizeIcon, fit: BoxFit.contain,),
          ),
          Text(AppLocalizations.of(context).tr(
              'main_student.home.grid_menu.chart'), style: Theme.of(context).primaryTextTheme.subtitle.copyWith(color: textLightPrimary),)
        ],
      ),
    );
  }
}
