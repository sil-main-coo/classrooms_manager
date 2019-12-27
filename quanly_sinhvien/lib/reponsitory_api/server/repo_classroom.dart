import 'package:quanly_sinhvien/model/response/response_list_classroom.dart';

abstract class ClassroomRepo{
  Future<ResponseListClassroom> getListClassroom(String token);
  String getInfoClassroom(String id);
}