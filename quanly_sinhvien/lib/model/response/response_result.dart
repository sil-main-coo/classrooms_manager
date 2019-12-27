import 'package:flutter/material.dart';

class ResponseResult{
  bool _success;
  int _status;
  String _message;

  ResponseResult(this._success, this._status, this._message);

  ResponseResult.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    if(!_success){
      _message = json['message'];
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "\"success\"": this._success.toString(),
    };
  }

  ResponseResult.withError(ResponseResult err){
    this._success= err.success;
    this._status= err.status;
    this._message= err.message;
  }

  ResponseResult.withDisconnect(){
    this._success= false;
    this._status= 0;
    this._message= 'Disconneted';
  }

  String get message => _message;

  int get status => _status;

  bool get success => _success;


}