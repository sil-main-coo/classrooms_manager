

import 'package:quanly_sinhvien/utils/values/name_role.dart';

class LoginSessionModel{
  String _token;
  String _idUser;
  NameOfRole _nameOfRole;
  bool _isOwner;
  bool _isLogin;

  LoginSessionModel(this._token, this._nameOfRole, this._isOwner);

  LoginSessionModel.fromJson(Map<String, dynamic> json){
    _token = json['token'];
    _isOwner= json['is_owner'];
    _nameOfRole = NameOfRole.values.firstWhere((e) => e.toString() == json['role']);
    if(_token!=null && _nameOfRole!= null)
      _isLogin = true;
    else
      _isLogin= false;
  }

  Map<String, dynamic> toJson(){
    return {
      "\"token\"": "\""+this.token+"\"",
      "\"role\"": "\""+this.nameOfRole.toString()+"\"",
      "\"is_owner\"":  this._isOwner ,
    };
  }

  NameOfRole get nameOfRole => _nameOfRole;

  set nameOfRole(NameOfRole value) {
    _nameOfRole = value;
  }

  String get token => _token;

  set token(String value) {
    _token = value;
  }

  bool get isLogin => _isLogin;

  set isLogin(bool value) {
    _isLogin = value;
  }


  bool get isOwner => _isOwner;

  set isOwner(bool value) {
    _isOwner = value;
  }

  set idUser(String value) {
    _idUser = value;
  }

  String get idUser => _idUser;


}