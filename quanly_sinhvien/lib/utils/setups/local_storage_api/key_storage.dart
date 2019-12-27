import 'package:quanly_sinhvien/utils//values/name_role.dart';

class KeyStorageTeacher{
  static final teachScheduleKey= NameOfRole.TEACHER.toString()+'schedule';
  static final teachProfileKey= NameOfRole.TEACHER.toString()+'profile';
  static final teachProfileMeKey= NameOfRole.TEACHER.toString()+'profile_me';
}

class KeyStorageStudent{
  static final stScheduleKey= NameOfRole.STUDENT.toString()+'schedule';
  static final stProfileKey= NameOfRole.STUDENT.toString()+'profile';
  static final stProfileMeKey= NameOfRole.STUDENT.toString()+'profile_me';
}
class KeyStorageApplication{
  static final tokenKey= 'token';
}


