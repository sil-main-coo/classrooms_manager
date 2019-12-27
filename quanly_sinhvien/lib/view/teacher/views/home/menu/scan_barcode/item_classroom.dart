import 'package:flutter/material.dart';
import 'package:quanly_sinhvien/bloc/bloc_scan_qr_code.dart';
import 'package:quanly_sinhvien/model/response/classroom/classroom.dart';
import 'package:quanly_sinhvien/utils/values/colors.dart';
import 'package:quanly_sinhvien/view/widgets/dialog/alert_result.dart';
import 'package:quanly_sinhvien/view/widgets/loader/loading_dialog.dart';

class ClassroomItem extends StatefulWidget {
  Classroom _classroom;

  ClassroomItem(this._classroom);

  @override
  _ClassroomItemState createState() => _ClassroomItemState();
}

class _ClassroomItemState extends State<ClassroomItem> {
  final _scanBloc= ScanQRCodeBloc();

  _scanCode() async {
    await _scanBloc.scanBarcode();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // stream listen code qr
    _scanBloc.streamBarCode.listen((dataAtt) async {
      if(dataAtt!=null){
        // handling attendance
        LoadingDialog.showLoadingDialog(context);
        await _scanBloc.attendanceByTeacher(widget._classroom.id.toString(), dataAtt);
      }else{
        // failed
        AlertResult.showAlertError(context, 'Có lỗi khi quét mã');
      }
    }).onError((err){
      // failed
      AlertResult.showAlertError(context, 'Có lỗi: $err');
    });

    // stream listen attendance
    _scanBloc.streamAttendance.listen((response){
      LoadingDialog.hideLoadingDialog(context);
      if(response.success){
        AlertResult.showAlertSuccess(context, 'Điểm danh thành công cho sinh viên');
      }else{
        AlertResult.showAlertError(context, 'Điểm danh thất bại ${response.message.toString()}');
      }
    }).onError((err){
      // failed
      LoadingDialog.hideLoadingDialog(context);
      AlertResult.showAlertError(context, '$err');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () => _scanCode(),
        child: new Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new GridTile(
              child: new Text(
                widget._classroom.className, style: Theme.of(context).primaryTextTheme.title.copyWith(color: textLightPrimary),), //just for testing, will fill with image later
            ),
          ),
        ),
      ),
    );
  }
}
