import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/bloc/bloc_scan_qr_code.dart';
import 'package:quanly_sinhvien/utils/values/colors.dart';
import 'package:quanly_sinhvien/view/widgets/dialog/alert_not_owned.dart';
import 'package:quanly_sinhvien/view/widgets/dialog/alert_result.dart';
import 'package:quanly_sinhvien/view/widgets/loader/loading_dialog.dart';

class QRCodeMenu extends StatefulWidget {
  double _sizeIcon;

  QRCodeMenu(this._sizeIcon);

  @override
  _QRCodeState createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCodeMenu> {
  final _isOwner= ScanQRCodeBloc().isOwner();
  final _scanBloc= ScanQRCodeBloc();

  _scanCode() async {
    await _scanBloc.scanQRCode();
  }

  _showAlert(){
    AlertNotOwned.showDialogNotOwned(context, 'Bạn cần sử dụng máy chính chủ để sử dụng chức năng này');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // stream listen code qr
    _scanBloc.streamCode.listen((dataAtt) async {
      if(dataAtt!=null){
        // handling attendance
        LoadingDialog.showLoadingDialog(context);
        await _scanBloc.attendanceByStudent(dataAtt);
      }else{
        // failed
        AlertResult.showAlertError(context, 'Có lỗi khi quét mã');
      }
    }).onError((err){
      // failed
      AlertResult.showAlertError(context, 'Đã có lỗi $err');
    });

    // stream listen attendance
    _scanBloc.streamAttendance.listen((response){
      LoadingDialog.hideLoadingDialog(context);
      if(response.success){
        AlertResult.showAlertSuccess(context, 'Điểm danh thành công');
      }else{
        AlertResult.showAlertError(context, 'Điểm danh thất bại ${response.message.toString()}');
      }
    }).onError((err){
      // failed
      LoadingDialog.hideLoadingDialog(context);
      AlertResult.showAlertError(context, 'Đã có lỗi $err');
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _isOwner ? _scanCode() : _showAlert(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Center(
                child: Opacity(
                  opacity: _isOwner == false ? 0.4 : 1,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Image.asset(
                      'asset/image/qr_code.png', height: widget._sizeIcon, width: widget._sizeIcon, fit: BoxFit.contain,),
                  ),
                ),
              ),
              Visibility(
                visible: !_isOwner,
                child: Align(alignment: Alignment.bottomCenter,
                    child: Icon(Icons.block, color: primary, size: 48,)),
              )
            ],
          ),
          Opacity(
              opacity: _isOwner == false ? 0.4 : 1,
              child: Text(AppLocalizations.of(context).tr(
                  'main_student.home.grid_menu.scan_code'), style: Theme
                  .of(context)
                  .primaryTextTheme
                  .subtitle
                  .copyWith(color: textLightPrimary),))
        ],
      ),
    );
  }
}
