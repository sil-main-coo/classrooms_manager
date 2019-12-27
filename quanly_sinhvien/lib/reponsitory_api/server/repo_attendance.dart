import 'package:quanly_sinhvien/model/request/attendance.dart';
import 'package:quanly_sinhvien/model/response/response_result.dart';

abstract class AttendanceRepo{
  Future<ResponseResult> attendance(String token, AttendanceData attendance);

  Future<ResponseResult> scanBarcodeTeacher(String token, String idClass, String studentCode);
}