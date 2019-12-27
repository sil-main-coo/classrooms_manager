import 'package:quanly_sinhvien/model/response/response_result.dart';

class LoginResponse extends ResponseResult{
  String _accessToken;
  String _imei;
  bool _isOwner;

  LoginResponse(bool success, int stt, String mess, this._accessToken, this._imei) : super(success, stt, mess);

  LoginResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    _accessToken = json['access_token'];
    _imei= json['imei'];
  }

  LoginResponse.withError(ResponseResult err) : super.withError(err);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this._accessToken;
    data['imei'] = this._imei;
    return data;
  }


  bool get isOwner => _isOwner;

  set isOwner(bool value) {
    _isOwner = value;
  }

  String get imei => _imei;

  String get accessToken => _accessToken;

}