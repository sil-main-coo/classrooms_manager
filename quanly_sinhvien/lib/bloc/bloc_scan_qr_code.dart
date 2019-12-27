import 'dart:async';
import 'package:quanly_sinhvien/api/device/api_device.dart';
import 'package:quanly_sinhvien/api/server/api_attendance.dart';
import 'package:quanly_sinhvien/reponsitory_api/server/repo_attendance.dart';
import 'package:quanly_sinhvien/model/request/attendance.dart';
import 'package:quanly_sinhvien/model/response/response_result.dart';
import 'package:quanly_sinhvien/singleton/singletont_token.dart';

class ScanQRCodeBloc {
  final _deviceApi = DeviceApi();
  final SingletonToken _singletonToken = SingletonToken.getInstance();

  StreamController<
      ResponseResult> _streamAttendance = StreamController();
  Stream<ResponseResult> get streamAttendance => _streamAttendance.stream;

  StreamController<AttendanceData> _streamCode= StreamController();
  Stream<AttendanceData> get streamCode => _streamCode.stream;

  StreamController<String> _streamBarCode= StreamController();
  Stream<String> get streamBarCode => _streamBarCode.stream;

  dispose() {
    _streamAttendance.close();
    _streamCode.close();
    _streamBarCode.close();
  }

  isOwner(){
    return _singletonToken.loginSession.isOwner;
  }

  scanBarcode() async {
    final code = await _deviceApi.scanQRCode(); // scan code
    if (code == null) {
      _streamBarCode.sink.addError('Could not get code value');
    }else {
      _streamBarCode.sink.add(code);
    }
  }

  scanQRCode() async {
    final location = await _deviceApi
        .getCurrentLocation(); // get current location
    if (location == null) {
      _streamCode.sink.addError('Could not get location value');
    } else {
      final imei = await _deviceApi.getIMEI(); // get IMEI device
      if (imei == null) {
        _streamCode.sink.addError('Could not get imei value');
      } else {
        final code = await _deviceApi.scanQRCode(); // scan code
        if (code == null) {
          _streamCode.sink.addError('Could not get code value');
        }else {
          final dataAttendance = new AttendanceData(code: code,
            lat: location.latitude.toString(),
            lon: location.longitude.toString(),
            imei: imei,);
          _streamCode.sink.add(dataAttendance);
        }
      }
    }
  }

  //  This function call attendance api
  attendanceByStudent(AttendanceData data) async {
    AttendanceRepo attendanceApi = AttendanceApi();

    final response = await attendanceApi.attendance(
        _singletonToken.loginSession.token, data
    );

    if (response.success) {
      _streamAttendance.sink.add(response);
    } else {
      _streamAttendance.sink.addError('${response.message}');
    }
  }

  attendanceByTeacher(String idClass, String studentCode) async {
    AttendanceRepo attendanceApi = AttendanceApi();

    final response = await attendanceApi.scanBarcodeTeacher(
        _singletonToken.loginSession.token, idClass, studentCode
    );

    if (response.success) {
      _streamAttendance.sink.add(response);
    } else {
      _streamAttendance.sink.addError('${response.message}');
    }
  }

}