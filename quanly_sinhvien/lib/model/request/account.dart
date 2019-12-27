
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:quanly_sinhvien/utils/values/name_role.dart';

class Account{
  String _userName;
  String _role, _pwd;

  Account(this._userName, String pwd, NameOfRole nameOfRole){
    this._pwd=  md5.convert(utf8.encode(pwd)).toString();
    if(nameOfRole == NameOfRole.TEACHER){
      this._role = 'teacher';
      this._userName= 'nguyenvanphac';
      this._pwd= 'e6a04337e99c292aa3b32b2860fc3b04';
    }else{
      this._userName= 'CT020301';
      this._pwd= '34f75e4a833a2f322c46c17c804caf23';
      this._role= 'student';
    }
  }

  get pwd => _pwd;

  String get userName => _userName;

  String get role => _role;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this._userName;
    data['password'] = this._pwd;
    data['role'] = this._role;
    return data;
  }

}