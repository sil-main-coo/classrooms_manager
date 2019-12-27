import 'package:quanly_sinhvien/base/base_event.dart';
import 'package:quanly_sinhvien/model/request/account.dart';
import 'package:quanly_sinhvien/utils/values/name_role.dart';

class LoginEvent extends BaseEvent{
  final Account _account;
  final NameOfRole _nameOfRole;

  Account get account => _account;


  NameOfRole get nameOfRole => _nameOfRole;

  LoginEvent(this._account, this._nameOfRole);
}